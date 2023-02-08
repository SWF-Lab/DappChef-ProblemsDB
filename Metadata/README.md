<p align="center">
    <h1 align="center">
        🍩 DappChef-ProblemsDB
    </h1>
</p>

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Rules](#rules)
  - [TODO Functionality](#todo-functionality)
  - [Important Announcement](#important-announcement)
  - [Start the Journey](#start-the-journey)
  - [Judge](#judge)
- [Problems](#problems)
  - [Problems Template](#problems-template)
  - [Special Operation](#special-operation)
    - [Constructor](#constructor)
    - [Event](#event)
    - [WITH\_ETHER](#with_ether)
    - [USER\_ADDRESS](#user_address)
    - [WAIT](#wait)
- [Reference](#reference)
  - [Roadmap](#roadmap)
  - [Learnging Resource](#learnging-resource)
  - [Vulnerability Resource](#vulnerability-resource)

---

## Rules

### TODO Functionality

**有些目前還不支援的內容，過一陣子我會處理這個問題，請大家先避開**
- ✅ Basic Judging System Core
- ✅ [Constructor](#constructor): Deploy the contract with constructor call data
- ✅ [Event](#event): Expect the specify events to be emitted
- ⬜️ [WITH_ETHER](#with_ether): Send Ether (or call function with ether) to the Contract
- ⬜️ [USER_ADDRESS](#user_address): Use User's Address to be expectReturn or callData
- ⬜️ [WAIT](#wait): Wait for few blocks

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
4. Compile the contract (**If the `problem<number>.sol` compiled failed is normal**):
```bash
$ yarn compile --force
```
5. Create new branch, reference with SWF-Lab/github_practice:
```bash
$ git checkout main # Change to the main branch
$ git pull # Make sure the local code is same with the remote
$ git checkout -b add-my-context # Create new branch
```
6. Put your problems to the folder `problemVersion1` with template [below](#problems-metadata-template).
7. Write your problems statement and its **Token Metadata** in [Metadata Folder](/Metadata)...
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
√ Please enter the problemNumber you want to judge: ... 15
Trying to deploy problem 15 with Deployer Contract:
    Tx successful with hash: 0xaaa0917f1d4fc2f78760167e5fe1e2055d88aebeea2ca09e661c0910dc748043
    Deployed contract address is 0xC9f1e159fD3fA27B8a3e235947d499A01579E3A9

Begin the Judging...

Testing 0: getOwner()
    - Sameple Input:
    - Sameple Output: 0xdCca4cE55773359E191110Eeb21E0413f770032B
    - Your Output: 0xdCca4cE55773359E191110Eeb21E0413f770032B
    ...Accepted!

Testing 1: getFoo()
    - Sameple Input:
    - Sameple Output: 321
    - Your Output: 321
    ...Accepted!

All Accepted!
Done in 18.75s.
```

## Problems

### Problems Template

FileName: `problem<problemNumber>.json` (e.g. `problem997.json`)

> If your function is **Write Function** (calling this function will change the state), your `expectReturn` should be `[]` (empty array).

```json
{
    "problemNumber": "<int>, number of this problem",
    "problemVersion": "<int>, support dappchef version of this problem",
    "description": "<str>, What user sholud do in this problem, which means problem statement",
    "constructorCallData": "<array <array>>, calldata types and value",
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

<<<<<<< HEAD
> **If the funcationality is constructing, don't use these operations in your problem!!**
=======
### problemVersion1
| No. | Class | Difficulty | Statement | Setter |
| --- | --- | :---: | --- | :---: |
| 0. |Beginner|⭐| Compiler Version Declaration |Mur** ✅|
| 1. |Beginner|⭐||Dino|
| 2. |Beginner|⭐||Dino|
| 3. |Beginner|⭐||Dino|
| 4. |Beginner|⭐||Dino|
| 5. |Beginner|⭐| Modifier |Dino|
| 6. |Beginner|⭐||Dino|
| 7. |Beginner|⭐||Dino|
| 8. |Beginner|⭐||Dino|
| 9. |Beginner|⭐||Dino|
| 10. |Beginner|⭐||Dino|
| 11. |Beginner|⭐||Dino|
| 12. |Beginner|⭐||Dino|
| 13. |Beginner|⭐||Dino|
| 14. |Beginner|⭐| Event |Mur** ✅|
| 15. |Beginner|⭐| Constructor |Mur** ✅|
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
| 47. |Company|⭐⭐|Advanced Withdraw |Mur** ✅|
| 48. |DSA|⭐⭐| Merkle Tree |Mur** ✅|
| 49. |DeFi|⭐⭐|Simple Staking DeFi Protocol|Mur** ✅|
| 50. ||⭐⭐||Dino|
| 51. ||⭐⭐||Dino|
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
>>>>>>> main

#### Constructor

Constructor Usage: use array to include the arguments's type and the value.

```JSON
"constructorCallData": [
    ["address", "0xdCca4cE55773359E191110Eeb21E0413f770032B"],
    ["uint256", 321]
],
```

#### Event

Event Usage: use `#` in fornt of the event name, and use two array to represent `topics` and `data`.

```JSON
"problemSolution": [
    {
        "methodName": "emitCalling(address,uint256,bool,string)",
        "callData": ["0xdCca4cE55773359E191110Eeb21E0413f770032B", 7, "true", "Hello World!"],
        "expectReturn": []
    },
    {
        "methodName": "#Calling(address,uint256,bool,string,string)",
        "callData": [],
        "expectReturn": [
            ["0xdCca4cE55773359E191110Eeb21E0413f770032B",7,"true"],
            ["Hello World!", "Meow"]
        ]
    }
],
```

#### WITH_ETHER

Use the `$` in front of the methodName and the first element of `callData` will become the `<etherInWei>`, which will transfer specify amount of goerliEther from user to the contract when call the function. 

If you have a function like below:
```solidity
function deposit(uint256 amount, address recipient) public payable {
    // need msg.value == amount
}
```
You can use this in the `problem<number>.json`:
```JSON
{
    "methodName": "$deposit(uint256,address)",
    "callData": ["1000000000000000000", 
        [
            "1000000000000000000", 
            "0xB42faBF7BCAE8bc5E368716B568a6f8Fdf3F84ec"
        ]
    ],
    "expectReturn": []
}
```

If you want to "only transfer ether without calling any function", which means using `receive()` or `fallback()` to get the amount of ether-transfer. 

```solidity
fallback(string memory data) external payable returns (uint256, string memory) {
    return (uint256(msg.value), data);
}
```

You can use this in the `problem<number>.json`:
```JSON
{
    "methodName": "$",
    "callData": ["1000000000000000000", ["Hi!"]],
    "expectReturn": ["1000000000000000000", "Hi!"]
}
```

> Above example is send 1 ether (10*18 wei) to the contract.

#### USER_ADDRESS

Use the `USER_ADDRESS` as the callData (Function Input Params) will give the **Address of the User(now Problem Solver)** to target method.

If you have this function in the Contract:

```solidity
function getBalance(address account) public view returns(uint256){
    return Balance(account);
}
```

You can judge it like:
```JSON
{
    "methodName": "getBalance(address)",
    "callData": ["USER_ADDRESS"],
    "expectReturn": ["..."]
}
```
> In the above example, if the user's address is `0x123`, the string `"USER_ADDRESS"` in the `callData` array will be replaced to `0x123`.

#### WAIT

Use `WAIT` as the methodName and `<wait_block_number>` will wait for specific block amount.

```JSON
{
    "methodName": "WAIT",
    "callData": [10],
    "expectReturn": []
}
```
> Above example is Wait for 10 Block mined.

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