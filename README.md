<p align="center">
    <h1 align="center">
        🍩 DappChef-ProblemsDB
    </h1>
</p>

## Table of Contents

- [Rules](#rules)
    - [Important Announcement](#important-announcement)
    - [Start the Journey](#start-the-journey)
    - [Judge](#judge)
- [Problems](#problems)
    - [Problems Metadata Template](#problems-metadata-template)
    - [Special Operation](#special-operation)
    - [Reward NFT Metadata](#reward-nft-metadata)
    - [Problems Classification Instructions](#problems-classification-instructions)
- [Problems Information](#problems-information)
    - [problemVersion1](#problemversion1)
    - [Problemversion2](#problemversion2)
- [Reference](#reference)

---

## Rules

### Important Announcement

1. 檔案名稱必須要跟最終繼承合約（主合約）的 Contract 變數名稱一致，例如第 48 題：

`answer48.sol` 的 contract 必須為 `answer48`：
```solidity
contract answer48 is ERC721, ERC721Storage {
    // ...
}
```
`problem48.sol` 的 contract 必須為 `problem48`：
```solidity
contract problem48 is ERC721, ERC721Storage {
    // ...
}
```

2. `problem<number>.json` 中 `problemSolution.methodName` 後的 `()` 中要有參數型別，以逗號隔開，不得有空格。例如以下的 `VerifySignature(address,uint256,uint256,address,uint8,uint256,bytes)`：
```JSON
"problemSolution": [
    {
        "methodName": "VerifySignature(address,uint256,uint256,address,uint8,uint256,bytes)",
        "callData": [
                "0xDEcf23CbB14972F2e9f91Ce30515ee955a124Cba",
                "997",
                "1673070083",
                "0xB42faBF7BCAE8bc5E368716B568a6f8Fdf3F84ec",
                "0",
                "0",
                "0xf48090ed731d9b3c956b9ee9843fd96d845879fc22763be659f2fb6f8229b52c245e72e3fb3540e969970333d52fa307b80cb3a04d088364f26c527c4767cb681b"
            ]
        "expectReturn": "true"
    }
]
```

3. 區塊鏈是沒辦法直接回傳 write function 的 return 給鏈下世界的，所以必須寫一個 getFunction (Read Function) 去讀你要檢查的值。

以下為錯誤題目出法：
```solidity
address public a;
function changeValue(address inputAddr) public returns (address) {  
    a = inputAddr;
    return a;
}
```

正確出法為：
```solidity
address public a;
function changeValue(address inputAddr) public{  
    a = inputAddr;
}

function get_a() public view returns(address){
    return a
}
```

對應上方的正確合約出法，在 `problem<number>.json` 中正確批改方法為：
```JSON
"problemSolution": [
        {
            "methodName": "changeValue(address)",
            "callData": [
                "0x90A1ad9E7c86590Fb8eD813bA7f93a6799fBF8b7"
            ],
            "expectReturn": []
        },
        {
            "methodName": "get_a()",
            "callData": [],
            "expectReturn": ["0x90A1ad9E7c86590Fb8eD813bA7f93a6799fBF8b7"]
        }
]
```
4. **目前還不支援 Constructor，過一陣子我會處理這個問題，請大家先避開**

### Start the Journey

1. Clone the repo
```bash
$ git clone https://github.com/SWF-Lab/DappChef-Core-Contract.git
```
2. Make sure the `.env` arguments are same as your image. (add your private key of account which **has enough goerliEther**).
```bash
$ cp .env.example .env
```
3. Prepare the node_modules
```bash
$ yarn install
```
4. Compile the contract:
```bash
$ yarn install & yarn compile --force
```
5. Create new branch, reference with SWF-Lab/github_practice:
```bash
$ git checkout main # Change to the main branch
$ git pull # Make sure the local code is same with the remote
$ git checkout -b add-my-context # Create new branch
```
6. Put your problems to the folder `problemVersion1` with template [below](#problems-metadata-template).
7. Write your problems statement [below](#problemversion1)...
8. Push the code to remote repo:
```bash
$ git add .
$ git commit -m "add new problems from x to y"
$ git push
```

### Judge 

Use the Judge Script to test your problem in Goerli.

> Make sure the problem contract **has been compiled** (`$ yarn compile`), and the private key in the `.env` is as your image.

```
$ yarn execute scripts/judgeGoerli.ts --network goerli
>
yarn run v1.22.18
$ node -r ts-node/register -r tsconfig-paths/register hardhatRunWithArgs.ts scripts/judgeGoerli.ts --network goerli
√ Please enter the problemNumber you want to judge: ... 41
Trying to deploy problem 41 with Deployer Contract:
    Tx successful with hash: 0x6bdc811145a9ec9b5588287632961bde53f6dd0f3569e59ad35af7182bf5cea0
    Deployed contract address is 0xE2AB961DEdbAfDa645139D3DAcaf57700dE2C88d

Begin the Judging...

Testing 0: VerifySignature(address,uint256,uint256,address,uint8,uint256,bytes)
    - Sameple Input: 0xDEcf23CbB14972F2e9f91Ce30515ee955a124Cba,997,1673070083,0xB42faBF7BCAE8bc5E368716B568a6f8Fdf3F84ec,0,0,0xf48090ed731d9b3c956b9ee9843fd96d845879fc22763be659f2fb6f8229b52c245e72e3fb3540e969970333d52fa307b80cb3a04d088364f26c527c4767cb681b
    - Sameple Output: true
    - Your Output: true
    ...Accepted!

Testing 1: VerifySignature(address,uint256,uint256,address,uint8,uint256,bytes)
    - Sameple Input: 0xDEcf23CbB14972F2e9f91Ce30515ee955a124Cba,999,1673070083,0xB42faBF7BCAE8bc5E368716B568a6f8Fdf3F84ec,1,0,0xf48090ed731d9b3c956b9ee9843fd96d845879fc22763be659f2fb6f8229b52c245e72e3fb3540e969970333d52fa307b80cb3a04d088364f26c527c4767cb681b
    - Sameple Output: false
    - Your Output: false
    ...Accepted!
Done in 22.65s.
```

## Problems

### Problems Metadata Template

FileName: `problem<problemNumber>.json` (e.g. `problem997.json`)

> If your function is **Write Function** (calling this function will change the state), your `expectReturn` should be `[]` (empty array).

```json
{
    "problemNumber": "<int>, number of this problem",
    "problemVersion": "<int>, support dappchef version of this problem",
    "description": "<str>, What user sholud do in this problem, which means problem statement",
    "constructorCallData": "<array>, calldata",
    "problemSolution": [
        {
            "methodName": "<str>, MethodName",
            "callData": "<array>, callData",
            "expectReturn": "<any>, the return of calling the Method with the callData"
         },
        {
            "methodName": "<str>, MethodName",
            "callData": "<array>, callData",
            "expectReturn": "<any>, the return of calling the Method with the callData"
         },
        {
            "methodName": "<str>, MethodName",
            "callData": "<array>, callData",
            "expectReturn": "<any>, the return of calling the Method with the callData"
         }
    ],
    "attributes": [
        {
          "trait_type": "difficulty", 
          "value": "<int>, difficulty of this problem, 1~3",
        },
        {
          "trait_type": "class", 
          "value": "<str>, class of this problem, see problems classification instructions part",
        } 
    ],
    "image": "<str>, ipfs://<ipfsPrefix>/<problemNumber>, which means the NFT image location",
}
```

> 1. The num of operations in the `problemSolution` is unlimited, if the problem is very complicated, the length of `problemSolution: Array.length` could be very long.
> 1. This metadata conforms to the [OpenSea Format](https://docs.opensea.io/docs/metadata-standards) which can show the attributes successfullty.

### Special Operation

> This funcationality is constructing, don't use these operations in your problem!!

#### MSG_SENDER / TX_ORIGIN

Use the `MSG_SENDER` / `TX_ORIGIN` as the callData (Function Input Params) will give the **Address of the User(Problem Solver)** to target method.

```JSON
{
    "methodName": "...",
    "callData": "[\"MSG_SENDER\", \"TX_ORIGIN\"]",
    "expectReturn": "..."
}
```

#### WAIT

Use `WAIT` as the methodName and `<wait_block_number>` will wait for specific block amount.

```JSON
{
    "methodName": "WAIT",
    "callData": "[10]",
    "expectReturn": "[]"
}
```

### Reward NFT Metadata
```JSON
{
    "name": "DappChef Rewards NFT #<problemNumber>",
    "description": "DappChef is a Ethereum Smart Contract Development Learning platform. Solve the coding problem, then you can mint the Reward NFT!",
    "solver": "<address>, the problem solve",
    "approver": "<address>, the key address storing in the server to sign(approve) minting request now",
    "problemSolvedTimestamp": "<int>, the timestamp which user solved the problem",
    "attributes": [
        {
          "display_type": "number", 
          "trait_type": "problemNumber", 
          "value": "<int>, number of this problem",
        },
        {
          "trait_type": "difficulty", 
          "value": "<int>, difficulty of this problem, 1~3",
        },
        {
          "trait_type": "class", 
          "value": "<str>, class of this problem, see problems classification instructions part",
        }, 
    ],
    "image": "<str>, ipfs://<ipfsPrefix>/<problemNumber>, which means the NFT image location",
}
```

### Problems Classification Instructions

| Learning Roadmap(L.R) | Class | Statement | Difficulty |
| :---: | :---: | --- | :---: |
|S.C Beginner L.R | Beginner |- From 0 to 1 Web3 Beginner Learning Roadmap <br/> - Basic Solidity Syntax Skill, Basic Dapp Skill & Concept|⭐|
|S.C Beginner L.R | Token	| Complete ERC-20/721 Construction	|⭐~⭐⭐|
|S.C Junior L.R | DeFi	|	|⭐⭐|
|S.C Junior L.R | Design_Pattern	| Upgradable Contract, Contract Wallet, Auction Model | ⭐⭐ |
| Interview Problems | Company	| Collected from lots of famous web3 company classical interview problem	|⭐⭐|
|S.C Senior L.R | DSA | 	|⭐⭐~⭐⭐⭐|
|S.C Senior L.R | Gas_Optim | 	|⭐⭐⭐|
|Theories L.R |	Cryptography | ZKP, Hash, Signature	|⭐⭐⭐|
|EVM L.R| EVM | Assembly, precompiled	|⭐⭐⭐|

## Problems Information

### problemVersion1
| No. | Class | Difficulty | Statement | Setter |
| --- | --- | :---: | --- | :---: |
| 0. |Beginner|⭐| Compiler Version Declaration |Mur** ✅|
| 1. |Beginner|⭐||Dino|
| 2. |Beginner|⭐||Dino|
| 3. |Beginner|⭐||Dino|
| 4. |Beginner|⭐||Dino|
| 5. |Beginner|⭐||Dino|
| 6. |Beginner|⭐||Dino|
| 7. |Beginner|⭐||Dino|
| 8. |Beginner|⭐||Dino|
| 9. |Beginner|⭐||Dino|
| 10. |Beginner|⭐||Dino|
| 11. |Beginner|⭐||Dino|
| 12. |Beginner|⭐||Dino|
| 13. |Beginner|⭐||Dino|
| 14. |Beginner|⭐||Dino|
| 15. |Beginner|⭐||Dino|
| 16. |Token|⭐||Dino|
| 17. |Token|⭐||Dino|
| 18. |Token|⭐||Dino|
| 19. |Token|⭐||Dino|
| 20. |Token|⭐||Dino|
| 21. |Beginner|⭐|Change Values of Global Variables|FoodChain✅|
| 22. |Beginner|⭐||FoodChain|
| 23. |Beginner|⭐||FoodChain|
| 24. |Beginner|⭐||FoodChain|
| 25. |Beginner|⭐||FoodChain|
| 26. |Beginner|⭐||FoodChain|
| 27. |Beginner|⭐||FoodChain|
| 28. |Beginner|⭐||FoodChain|
| 29. |Beginner|⭐||FoodChain|
| 30. |Beginner|⭐||FoodChain|
| 31. |Beginner|⭐||FoodChain|
| 32. |Beginner|⭐||FoodChain|
| 33. |Beginner|⭐||FoodChain|
| 34. |Beginner|⭐||FoodChain|
| 35. |Beginner|⭐||FoodChain|
| 36. |Token|⭐||FoodChain|
| 37. |Token|⭐||FoodChain|
| 38. |Token|⭐||FoodChain|
| 39. |Token|⭐||FoodChain|
| 40. |Token|⭐||FoodChain|
| 41. |Company|⭐⭐|Signature && EIP-1271|Mur** ✅|
| 42. |Company|⭐⭐||Mur**|
| 43. |Company|⭐⭐||Mur**|
| 44. |Company|⭐⭐||Mur**|
| 45. |Company|⭐⭐||Mur**|
| 46. |Company|⭐⭐||Mur**|
| 47. |Company|⭐⭐||Mur**|
| 48. |DSA|⭐⭐| Merkle Tree |Mur** ✅|
| 49. |DeFi|⭐⭐|Simple Staking DeFi Protocol|Mur** ✅|
| 50. ||⭐⭐||Mur**|
| 51. ||⭐⭐||Mur**|
| 52. ||⭐⭐||Dino|
| 53. ||⭐⭐||Dino|
| 54. ||⭐⭐||Dino|
| 55. ||⭐⭐||Dino|
| 56. ||⭐⭐||Dino|
| 57. ||⭐⭐||Dino|
| 58. ||⭐⭐||Dino|
| 59. ||⭐⭐||Dino|
| 60. ||⭐⭐||Dino|
| 61. ||⭐⭐||Dino|
| 62. |Token|⭐⭐||FoodChain|
| 63. |Token|⭐⭐||FoodChain|
| 64. ||⭐⭐||FoodChain|
| 65. ||⭐⭐||FoodChain|
| 66. ||⭐⭐||FoodChain|
| 67. ||⭐⭐||FoodChain|
| 68. ||⭐⭐||FoodChain|
| 69. ||⭐⭐||FoodChain|
| 70. ||⭐⭐||FoodChain|
| 71. ||⭐⭐||FoodChain|
| 72. ||⭐⭐||FoodChain|
| 73. ||⭐⭐||FoodChain|
| 74. |Token|⭐⭐||Dino|
| 75. |Token|⭐⭐||Dino|
| 76. ||⭐⭐||Dino|
| 77. ||⭐⭐||Dino|
| 78. ||⭐⭐||Dino|
| 79. ||⭐⭐||Dino|
| 80. ||⭐⭐||Dino|
| 81. ||⭐⭐||Dino|
| 82. ||⭐⭐||Dino|
| 83. ||⭐⭐||Dino|
| 84. ||⭐⭐||Dino|
| 85. ||⭐⭐||Dino|
| 86. ||⭐⭐⭐||Dino|
| 87. ||⭐⭐⭐||Dino|
| 88. ||⭐⭐⭐||Dino|
| 89. ||⭐⭐⭐||FoodChain|
| 90. ||⭐⭐⭐||FoodChain|
| 91. ||⭐⭐⭐||FoodChain|
| 92. |Company|⭐⭐⭐||Mur**|
| 93. |Company|⭐⭐⭐||Mur**|
| 94. |Company|⭐⭐⭐||Mur**|
| 95. ||⭐⭐⭐||Mur**|
| 96. ||⭐⭐⭐||Mur**|
| 97. ||⭐⭐⭐||Mur**|
| 98. ||⭐⭐⭐||Mur**|
| 99. ||⭐⭐⭐||Mur**|
| 100. ||⭐⭐⭐||Mur**|

### problemVersion2

> TBD, these problems will be added after DappChef begins earning.

---

## Reference

### Roadmap
1. Build these contracts:
    - Lending contract (Based on Aave)
    - Staking contract (Based on Synthetix)
    - AMM (Based on Uniswap v2)
    - ERC20, ERC721, ERC1155
    - Centralized Stable Coin - (Based on USDC)
    - Governance contract (Based on Compound)
    - Understand the architect of uniswap v3 and curve
    - Example:
        - Uniswap v2, v3, curve - https://lnkd.in/g_wmxTpm
        - Compound Governance - https://lnkd.in/gzac5m34
        - Other - https://lnkd.in/gnGNRx7C
2. Make sure you know how to:
    - write unit tests
    - write mocks
    - use Trail of Bits Toolbox
    - use Hardhat + Foundry
    - use SDKs
    - leverage the console with Node
    - check for sol coverage and gas reports
    - integrate contracts with frontend
3. Learn about solidity patterns - https://lnkd.in/gzRYy3t9
4. Learn about attack vectors - https://lnkd.in/gSV_bj9R
5. Learn about gas optimization - https://lnkd.in/gCM692mQ

### Learnging Resource
- [Solidity by Example](https://solidity-by-example.org/)
- [Crypto Zombie](https://cryptozombies.io/)
- [Appworks School Blockchain Program Resource](https://github.com/AppWorks-School/Blockchain-Resource)

### Vulnerability Resource
- [Ethernaut](https://ethernaut.openzeppelin.com/)
- [Damn Vulnerable DeFi](https://github.com/nicolasgarcia214/damn-vulnerable-defi-foundry)
- [DeFiHack](https://www.defihack.xyz/)
- [Hack Solidity](https://zuhaibmd.medium.com/list/hack-solidity-b6a017b75a39)
- [DeFi Security Lecture](https://medium.com/beaver-smartcontract-security/defi-security-lecture-1-reentrancy-attack-182396e41710)
- [DeFiHackLabs](https://github.com/SunWeb3Sec/DeFiHackLabs)
