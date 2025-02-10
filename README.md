Detailed Introduction to DeLotGame Contract (Thanks to the original free generation on the deepseek official website)
I. Contract Overview
The DeLotGame contract is a smart contract deployed on the Ethereum blockchain, featuring the following characteristics:
Fully operating within the contract: All logic is executed inside the contract.
Fully operable within the wallet: Users can interact with the contract through their wallets.
Fully decentralized: It doesn't rely on centralized institutions or servers.
No wallet authorization required: Users can use the contract without additional wallet authorization.
In addition, when this contract runs on the Base chain, the measured gas fee is less than 0.1 yuan. The test addresses are as follows:
BaseSepolia address: 0xD056c1EE47A65C1f0A43Cbd89DE882AF5075DD1D
EthSepolia address: 0x0228c4fAc26F86A7Beff238bAFeE066457D6B296
This contract provides three core functions: minting, gameplay, and coin redemption.
II. Participating in the DeLotGame Contract Using the MetaMask Browser Plug - in Wallet (Currently, the mobile MetaMask wallet does not support transfer remarks for the DEMO)
(I) Participating in the Game
Preparation: Open the MetaMask plugin, connect to a network that supports the DeLotGame contract, and confirm that there is sufficient ETH in the wallet.
Transfer: Click the "Send" button, enter the DeLotGame contract address in the "Recipient" field, and set the amount of ETH to transfer.
Input data: Click "Advanced Options", and in the "Data" field, enter the guessed data in HEX format (composed of valid characters 0 - 9, a - f, with a length not exceeding 16 bytes) as the guessing characters.
Confirm the transaction: After checking that the transfer information is correct, click "Confirm" to complete the transfer. The contract will record and process the relevant data.
(II) Winning Mechanism
Target block number: After each transfer with valid HEX data, the contract will calculate a target block number (i.e., the first block number ending with zero after the block number where the transfer occurs).
Hash value judgment: When the current block number exceeds the target block number and the difference between the two is within 256 blocks, the contract will obtain the hash value of the target block.
Winning condition: If the hash value is valid and the last character of the hash value is included in the data of the previous transfer, it is considered a win.
Reward calculation: The reward amount is calculated according to the formula (the amount of ETH transferred last time * 16) / the length of the data transferred last time. If the ETH balance of the contract is insufficient, the entire balance will be issued as a reward.
(III) Pledge (Minting)
Transfer operation: In MetaMask, click the "Send" button, enter the DeLotGame contract address and the amount of ETH to transfer.
Leave the data field blank: Ensure that the "Data" field is blank.
Confirm the transaction: After checking that the transfer information is correct, click "Confirm".
Minting rules:
If the total token supply is 0, or the ETH balance of the contract is less than or equal to the total token supply, the number of minted tokens is equal to the amount of transferred ETH.
Otherwise, the number of minted tokens is (the amount of transferred ETH * the total token supply) / the ETH balance of the contract.
(IV) Redemption
Manual Redemption
Visit the website: Visit a website that supports contract interaction and find the redeem function of the DeLotGame contract.
Input quantity: Enter the quantity of DLT tokens to be redeemed (greater than 0) in the function input box.
Check conditions: Ensure that the total token supply is greater than 0 and the contract has sufficient ETH balance for redemption.
Confirm the transaction: Click the "Write" button, and confirm the transaction information in the confirmation window popped up by MetaMask to complete the redemption. The corresponding quantity of DLT tokens will be burned, and the user will receive the corresponding amount of ETH.
Direct Redemption
Transfer operation: In MetaMask, click the "Send" button and fill in the contract address as the "Recipient".
Input quantity: Fill in the quantity of DLT tokens to be redeemed in the "Amount" field.
Confirm the transaction: After checking that it is correct, confirm the transaction to complete the direct redemption. Users can also authorize others to transfer on their behalf, call the transferFrom function, and set the receiving address as the contract address to trigger the automatic redemption logic.
DeLotGame 合约详细介绍（感谢 deepseek 官网原版免费生成）
一、合约概述
DeLotGame 合约是部署在以太坊区块链上的智能合约，具备以下特性：
完全合约内运行：所有逻辑均在合约内部执行。
完全钱包内操作：用户通过钱包即可与合约进行交互。
完全去中心化：无需依赖中心化机构或服务器。
无需钱包授权：用户无需对钱包进行额外授权即可使用合约。
此外，该合约在 Base 链上运行时，实测 gas 费用低于 0.1 元。测试地址如下：
BaseSepolia 地址：0xD056c1EE47A65C1f0A43Cbd89DE882AF5075DD1D
EthSepolia 地址：0x0228c4fAc26F86A7Beff238bAFeE066457D6B296
该合约提供三大核心功能：铸币、游戏玩法及兑币。
二、使用 MetaMask 浏览器插件版钱包（目前手机 MetaMask 钱包不支持转账备注 DEMO）参与 DeLotGame 合约
（一）参与游戏
准备：打开 MetaMask 插件，连接至支持 DeLotGame 合约的网络，并确认钱包中有足够的 ETH。
转账：点击 “发送” 按钮，在 “收件人” 栏输入 DeLotGame 合约地址，并设定转账的 ETH 数量。
输入数据：点击 “高级选项”，在 “数据” 栏输入竞猜的 HEX 格式的数据（由有效字符 0 - 9、a - f 组成，长度不超过 16 字节），作为竞猜字符。
确认交易：检查转账信息无误后，点击 “确认” 完成转账。合约将记录并处理相关数据。
（二）中奖机制
目标区块号：每次附带有效 HEX 数据转账后，合约会计算出一个目标区块号（即转账所在区块号后的第一个整十区块号）。
哈希值判断：当当前区块号超过目标区块号，且两者差值在 256 个区块以内时，合约会获取目标区块的哈希值。
中奖条件：若哈希值有效，且上次转账数据中包含该哈希值的最后一个字符，则视为中奖。
奖励计算：奖励金额按公式 (上次转账 ETH 数量 * 16) / 上次转账数据长度计算。若合约 ETH 余额不足，则发放全部余额作为奖励。
（三）质押（铸币）
转账操作：在 MetaMask 中点击 “发送” 按钮，输入 DeLotGame 合约地址和要转账的 ETH 数量。
数据栏留空：确保 “数据” 栏为空。
确认交易：检查转账信息无误后，点击 “确认”。
铸币规则：
若代币总供应量为 0，或合约 ETH 余额小于等于代币总供应量，铸币数量等于转账的 ETH 数量。
否则，铸币数量为 (转账 ETH 数量 * 代币总供应量) / 合约 ETH 余额。
（四）兑换
手动兑换
访问网页：访问支持合约交互的网页，找到 DeLotGame 合约的 redeem 函数。
输入数量：在函数输入框中输入要兑换的 DLT 代币数量（大于 0）。
检查条件：确保代币总供应量大于 0，且合约有足够的 ETH 余额用于兑换。
确认交易：点击 “写入” 按钮，在 MetaMask 弹出的确认窗口中确认交易信息，完成兑换。相应数量的 DLT 代币将被销毁，用户将获得对应数量的 ETH。
直接兑换
转账操作：在 MetaMask 中点击 “发送” 按钮，将 “收件人” 填写为合约地址。
输入数量：“金额” 栏填写为要兑换的 DLT 代币数量。
确认交易：检查无误后确认交易，即可完成直接兑换。用户也可以使用授权他人代转的方式，调用 transferFrom 函数，并将接收地址设为合约地址，触发自动兑换逻辑。
