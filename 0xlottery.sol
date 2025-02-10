// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DeLotGame is ERC20 {
    struct TransferRecord {
        uint256 amount;
        uint256 triggerBlock;
        bytes userData;
    }

    mapping(address => TransferRecord) public transferHistory;
    uint256 private constant MAX_DATA_LENGTH = 16;

    constructor() ERC20("DeLot", "DLT") {}

    // 接收ETH无数据时触发铸币
    receive() external payable {
        _processMint();
    }

    // 接收HEX数据时触发游戏逻辑
    fallback() external payable {
        _processGame(msg.sender, msg.data);
    }

    // 铸币核心逻辑
    function _processMint() private {
        uint256 ethAmount = msg.value;
        uint256 contractEth = address(this).balance;
        uint256 totalDLT = totalSupply();

        uint256 mintAmount = totalDLT == 0 ? ethAmount : 
            contractEth <= totalDLT ? ethAmount : 
            (ethAmount * totalDLT) / contractEth;

        _mint(msg.sender, mintAmount);
    }

    // 游戏核心逻辑
    function _processGame(address sender, bytes memory data) private {
        TransferRecord memory last = transferHistory[sender];
        bytes memory cleanData = _sanitizeData(data);
        require(cleanData.length > 0, "Invalid game data");

        // 处理未领取的奖励
        if (last.triggerBlock != 0) {
            uint256 targetBlock = _nextRoundNumber(last.triggerBlock);
            
            if (block.number > targetBlock && 
                block.number - targetBlock <= 256) 
            {
                bytes32 targetHash = blockhash(targetBlock);
                
                if (targetHash != 0 && 
                    _hasMatchingChar(last.userData, _getLastChar(targetHash)))
                {
                    _sendReward(sender, last.amount, last.userData.length);
                }
            }
        }

        // 记录新转账
        transferHistory[sender] = TransferRecord(
            msg.value,
            block.number,
            cleanData
        );
    }

    // 兑换功能（需主动调用）
    function redeem(uint256 amount) external {
        require(amount > 0, "Amount must > 0");
        uint256 totalDLT = totalSupply();
        require(totalDLT > 0, "No DLT in circulation");

        uint256 ethAmount = (amount * address(this).balance) / totalDLT;
        require(ethAmount > 0, "Insufficient ETH");

        _burn(msg.sender, amount);
        payable(msg.sender).transfer(ethAmount);
    }

    // 重写ERC20的transfer函数，支持直接发送DeLot兑换ETH
    function transfer(address to, uint256 amount) public override returns (bool) {
        if (to == address(this)) {
            _autoRedeem(msg.sender, amount);
            return true;
        }
        return super.transfer(to, amount);
    }

    // 重写ERC20的transferFrom函数，支持直接发送DeLot兑换ETH
    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        if (to == address(this)) {
            _autoRedeem(from, amount);
            return true;
        }
        return super.transferFrom(from, to, amount);
    }

    // 自动兑换逻辑
    function _autoRedeem(address from, uint256 amount) private {
        require(amount > 0, "Amount must > 0");
        uint256 totalDLT = totalSupply();
        require(totalDLT > 0, "No DLT in circulation");

        uint256 ethAmount = (amount * address(this).balance) / totalDLT;
        require(ethAmount > 0, "Insufficient ETH");

        _burn(from, amount);
        payable(from).transfer(ethAmount);
    }

    // 辅助函数
    function _sendReward(address to, uint256 lastAmount, uint256 dataLength) private {
        uint256 reward = (lastAmount * 16) / dataLength;
        reward = address(this).balance < reward ? address(this).balance : reward;
        payable(to).transfer(reward);
    }

    function _hasMatchingChar(bytes memory data, bytes1 target) private pure returns (bool) {
        for (uint i = 0; i < data.length; i++) {
            if (data[i] == target) return true;
        }
        return false;
    }

    // 原有工具函数（保持原始实现）
    function _nextRoundNumber(uint256 n) internal pure returns (uint256) {
        return n + (10 - (n % 10));
    }

    function _sanitizeData(bytes memory data) internal pure returns (bytes memory) {
        uint start = 0;
        if (data.length >= 2 && data[0] == 0x30 && data[1] == 0x78) {
            start = 2;
        }
        uint byteLength = data.length - start;
        require(byteLength * 2 <= MAX_DATA_LENGTH, "Data overflow");

        bytes memory cleaned = new bytes(byteLength * 2);
        for (uint i = start; i < data.length; i++) {
            bytes1 b = data[i];
            cleaned[(i - start)*2] = _nibbleToChar(uint8(b) >> 4);
            cleaned[(i - start)*2 + 1] = _nibbleToChar(uint8(b) & 0x0F);
        }
        return cleaned;
    }

    function _getLastChar(bytes32 hash) internal pure returns (bytes1) {
        uint8 lowNibble = uint8(hash[31]) & 0x0F;
        return _nibbleToChar(lowNibble);
    }

    function _nibbleToChar(uint8 nibble) internal pure returns (bytes1) {
        require(nibble < 16, "Invalid nibble");
        return nibble < 10 ? bytes1(nibble + 48) : bytes1(nibble + 87);
    }
}