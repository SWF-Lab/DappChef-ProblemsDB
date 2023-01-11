<p align="center">
    <h1 align="center">
        🍩 DappChef-ProblemsDB
    </h1>
</p>

## Rules

### Start the Journey

1. Clone the repo
```bash
$ git clone https://github.com/SWF-Lab/DappChef-Core-Contract.git
```
2. Create new branch, reference with SWF-Lab/github_practice:
```bash
$ git checkout main # Change to the main branch
$ git pull # Make sure the local code is same with the remote
$ git checkout -b add-my-context # Create new branch
```
3. Put your problems to the folder `problemVersion1` with template [below](#problems-metadata-template).
4. Write your problems statement [below](#problemversion1)...
5. Push the code to remote repo:
```bash
$ git add .
$ git commit -m "add new problems from x to y"
$ git push
```

> When you wrute your problems' JSON file, you should make sure the `"` symbol of the `string` in contract may conflit with the string symbol of `json`. Hence, you should add the `\`

### Problems Metadata Template
FileName: `problem<problemNumber>.json` (e.g. `problem997.json`)
```json
{
    "problemNumber": "<int>, number of this problem",
    "problemVersion": "<int>, support dappchef version of this problem",
    "description": "<str>, What user sholud do in this problem, which means problem statement",
    "problemInformation": {
        "constructorCallData": "<array>, calldata",
        "problemCodeBody": "<str>, the whole code without empty, which means the answer of this problem",
        "problemCodeBodyWithEmpty": "<str>, the whole code with empty, which means the examination point of this problem",
    },
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
         },
    ],
    "attributes": [
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

> 1. The num of operations in the `problemSolution` is unlimited, if the problem is very complicated, the length of `problemSolution: Array` could be very long.
> 1. This metadata conforms to the [OpenSea Format](https://docs.opensea.io/docs/metadata-standards) which can show the attributes successfullty.

### Reward NFT Metadata
```JSON
{
    "name": "DappChef Rewards NFT #<problemNumber>",
    "description": "DappChef is a Ethereum Smart Contract Development Learning platform. Solve the coding problem, then you can mint the Reward NFT!",
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
|S.C Senior L.R | DSA | 	|⭐⭐⭐|
|S.C Senior L.R | Gas_Optim | 	|⭐⭐⭐|
|Theories L.R |	Cryptography |	|⭐⭐⭐|
|EVM L.R| Assembly |	|⭐⭐⭐|

## Problems Information

### problemVersion1
| No. | Class | Difficulty | Statement | Setter |
| --- | --- | --- | --- | --- |
| 1. |Beginner|⭐||Dino|
| 2. |Beginner|||Dino|
| 3. |Beginner|||Dino|
| 4. |Beginner|||Dino|
| 5. |Beginner|||Dino|
| 6. |Beginner|||Dino|
| 7. |Beginner|||Dino|
| 8. |Beginner|||Dino|
| 9. |Beginner|||Dino|
| 10. |Beginner|||Dino|
| 11. |Beginner|||Dino|
| 12. |Beginner|||Dino|
| 13. |Beginner|||Dino|
| 14. |Beginner|||Dino|
| 15. |Beginner|||Dino|
| 16. |Token|||Dino|
| 17. |Token|||Dino|
| 18. |Token|||Dino|
| 19. |Token|||Dino|
| 20. |Token|||Dino|
| 21. |Beginner|||FoodChain|
| 22. |Beginner|||FoodChain|
| 23. |Beginner|||FoodChain|
| 24. |Beginner|||FoodChain|
| 25. |Beginner|||FoodChain|
| 26. |Beginner|||FoodChain|
| 27. |Beginner|||FoodChain|
| 28. |Beginner|||FoodChain|
| 29. |Beginner|||FoodChain|
| 30. |Beginner|||FoodChain|
| 31. |Beginner|||FoodChain|
| 32. |Beginner|||FoodChain|
| 33. |Beginner|||FoodChain|
| 34. |Beginner|||FoodChain|
| 35. |Beginner|||FoodChain|
| 36. |Token|||FoodChain|
| 37. |Token|||FoodChain|
| 38. |Token|||FoodChain|
| 39. |Token|||FoodChain|
| 40. |Token|||FoodChain|
| 41. |Company|⭐⭐||Mur**|
| 42. |Company|||Mur**|
| 43. |Company|||Mur**|
| 44. |Company|||Mur**|
| 45. |Company|||Mur**|
| 46. |Company|||Mur**|
| 47. |Company|||Mur**|
| 48. ||||Mur**|
| 49. ||||Mur**|
| 50. ||||Mur**|
| 51. ||||Mur**|
| 52. ||||Dino|
| 53. ||||Dino|
| 54. ||||Dino|
| 55. ||||Dino|
| 56. ||||Dino|
| 57. ||||Dino|
| 58. ||||Dino|
| 59. ||||Dino|
| 60. ||||Dino|
| 61. ||||Dino|
| 62. |Token|||FoodChain|
| 63. |Token|||FoodChain|
| 64. ||||FoodChain|
| 65. ||||FoodChain|
| 66. ||||FoodChain|
| 67. ||||FoodChain|
| 68. ||||FoodChain|
| 69. ||||FoodChain|
| 70. ||||FoodChain|
| 71. ||||FoodChain|
| 72. ||||FoodChain|
| 73. ||||FoodChain|
| 74. |Token|||Dino|
| 75. |Token|||Dino|
| 76. ||||Dino|
| 77. ||||Dino|
| 78. ||||Dino|
| 79. ||||Dino|
| 80. ||||Dino|
| 81. ||||Dino|
| 82. ||||Dino|
| 83. ||||Dino|
| 84. ||||Dino|
| 85. ||||Dino|
| 86. ||⭐⭐⭐||Dino|
| 87. ||||Dino|
| 88. ||||Dino|
| 89. ||||FoodChain|
| 90. ||||FoodChain|
| 91. ||||FoodChain|
| 92. |Company|||Mur**|
| 93. |Company|||Mur**|
| 94. |Company|||Mur**|
| 95. ||||Mur**|
| 96. ||||Mur**|
| 97. ||||Mur**|
| 98. ||||Mur**|
| 99. ||||Mur**|
| 100. ||||Mur**|

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
