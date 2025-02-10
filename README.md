Thanks to the original free generation on the DeepSeek official website. The DeLotGame contract is a smart contract based on the Ethereum blockchain platform. It operates entirely within the contract, allows for full - wallet operations, is completely decentralized, and doesn't require wallet authorization at all. In actual tests, the gas cost for running on the Base chain is less than 0.1 yuan. You are welcome to test it at the Base Sepolia address (0xD056c1EE47A65C1f0A43Cbd89DE882AF5075DD1D) and the Eth Sepolia address (0x0228c4fAc26F86A7Beff238bAFeE066457D6B296). It inherits from the ERC20 contract standard of OpenZeppelin and issues a token named DeLot (abbreviated as DLT). The contract offers three core functions: token minting, gameplay, and token redemption.
Token Minting Function
When a user sends ETH to the contract address without any attached data, the token minting operation is triggered. The calculation rules for the minting amount are as follows:
If the current total supply of the token is 0, the minting amount is equal to the amount of ETH sent by the user.
If the ETH balance of the contract is less than or equal to the total supply of the token, the minting amount is also equal to the amount of ETH sent by the user.
If neither of the above two conditions is met, the minting amount is calculated by the formula (amount of ETH sent * total supply of the token) / ETH balance of the contract.
Gameplay
When a user sends ETH to the contract address along with HEX - formatted data, the game logic is triggered. First, the contract cleans the data sent by the user, removing the possible 0x prefix and ensuring that the data length meets the maximum limit of 16 bytes. Then, the contract checks the user's last transfer record:
It calculates the target block number triggered by the last transfer. The target block number is the nearest block number divisible by 10 after the block number of the last transfer.
If the current block number is greater than the target block number and the difference between them does not exceed 256, the contract retrieves the hash value of the target block.
If the hash value of the target block is not 0 and the user's last transfer data contains the last character of the target block's hash value, the user can receive a reward. The reward amount is calculated by the formula (amount of ETH in the last transfer * 16) / length of the last transfer data. However, if the contract's ETH balance is insufficient to pay the reward amount, the user can only receive the entire balance of the contract as a reward. Finally, the contract records the relevant information of this transfer, including the amount of transferred ETH, the current block number, and the cleaned data.
Token Redemption Function
Users can actively call the redeem function to exchange their held DLT tokens for ETH. When redeeming, the following conditions need to be met:
The amount of DLT tokens to be redeemed must be greater than 0.
The total supply of the token must be greater than 0, that is, there are DLT tokens in circulation.
The amount of ETH obtained from the redemption must be greater than 0, which means the contract must have sufficient ETH balance for redemption.
The amount of ETH obtained from the redemption is calculated by the formula (amount of DLT tokens to be redeemed * ETH balance of the contract) / total supply of the token. After the redemption is completed, the corresponding amount of DLT tokens will be burned.感谢deepseek官网原版免费生成，DeLotGame 合约是一个基于以太坊区块链平台的智能合约，完全合约内运行、完全钱包内操作、完全去中心化、完全不需要钱包授权，实测在base链上运行gas低于0.1元，欢迎在basesepolia地址测试（0xD056c1EE47A65C1f0A43Cbd89DE882AF5075DD1D）、在ethsepolia地址测试（0x0228c4fAc26F86A7Beff238bAFeE066457D6B296），它继承自 OpenZeppelin 的 ERC20 合约标准，发行名为 DeLot（简称 DLT）的代币。该合约提供了铸币、游戏玩法以及兑币三大核心功能。
铸币功能
当用户向合约地址发送 ETH 且不附带任何数据时，会触发铸币操作。铸币数量的计算规则如下：
若当前代币总供应量为 0，铸币数量等于用户发送的 ETH 数量。
若合约的 ETH 余额小于等于代币总供应量，铸币数量同样等于用户发送的 ETH 数量。
若不满足上述两种情况，铸币数量通过公式 (发送的 ETH 数量 * 代币总供应量) / 合约的 ETH 余额 计算得出。
游戏玩法
当用户向合约地址发送 ETH 并附带 HEX 格式的数据时，会触发游戏逻辑。首先，合约会对用户发送的数据进行清理，去除可能存在的 0x 前缀，并确保数据长度符合最大 16 字节的限制。接着，合约会检查用户上一次转账的记录：
计算上一次转账触发的目标区块号，该目标区块号是上一次转账所在区块号之后最近的能被 10 整除的区块号。
若当前区块号大于目标区块号，且两者的差值不超过 256，合约会获取目标区块的哈希值。
若目标区块的哈希值不为 0，并且用户上一次转账数据中包含目标区块哈希值的最后一个字符，则用户可获得奖励。奖励金额通过公式 (上一次转账的 ETH 数量 * 16) / 上一次转账数据的长度 计算得出，但如果合约的 ETH 余额不足以支付该奖励金额，则用户只能获得合约的全部余额作为奖励。最后，合约会记录本次转账的相关信息，包括转账的 ETH 数量、当前区块号以及清理后的数据。
兑币功能
用户可以主动调用 redeem 函数将持有的 DLT 代币兑换为 ETH。在兑换时，需要满足以下条件：
兑换的 DLT 代币数量必须大于 0。
代币总供应量必须大于 0，即有 DLT 代币在流通。
兑换得到的 ETH 数量必须大于 0，也就是合约要有足够的 ETH 余额用于兑换。
兑换的 ETH 数量通过公式 (要兑换的 DLT 代币数量 * 合约的 ETH 余额) / 代币总供应量 计算得出。兑换完成后，相应数量的 DLT 代币会被销毁。
