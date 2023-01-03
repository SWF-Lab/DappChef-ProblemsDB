# DappChef-ProblemsDB

## Rules

### Problems Metadata Template
FileName: `problem<problemNumber>.json` (e.g. `problem997.json`)
```json
{
    "problemNumber": "<int>, number of this problem",
    "problemVersion": "<int>, support dappchef version of this problem",
    "description": "<str>, What user sholud do in this problem, which means problem statement",
    "problemInformation": {
        "problemCodeBody": "<str>, the whole code without empty, which means the answer of this problem",
        "problemCodeBodyWithEmpty": "<str>, the whole code with empty, which means the examination point of this problem",
    },
    "problemSolution": [
        {
            "methodName": "<str>, MethodName"
            "callData": "<any>, callData"
            "expectReturn": "<any>, the return of calling the Method with the callData"
         },
        {
            "methodName": "<str>, MethodName"
            "callData": "<any>, callData"
            "expectReturn": "<any>, the return of calling the Method with the callData"
         },
        {
            "methodName": "<str>, MethodName"
            "callData": "<any>, callData"
            "expectReturn": "<any>, the return of calling the Method with the callData"
         },
        {
            "methodName": "<str>, MethodName"
            "callData": "<any>, callData"
            "expectReturn": "<any>, the return of calling the Method with the callData"
         },
        {
            "methodName": "<str>, MethodName"
            "callData": "<any>, callData"
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
    ]
    "image": "<str>, ipfs://<ipfsPrefix>/<problemNumber>, which means the NFT image location",
}
```

> This metadata conforms to the [OpenSea Format](https://docs.opensea.io/docs/metadata-standards) which can show the attributes successfullty.

### Problems Classification Instructions

| Learning Roadmap(L.R) | Class | Statement | Difficulty |
| :---: | :---: | --- | :---: |
|S.C Beginner L.R | Beginner |- From 0 to 1 Web3 Beginner Learning Roadmap <br/> - Basic Solidity Syntax Skill, Basic Dapp Skill & Concept|⭐|
|S.C Beginner L.R | NFT	| Complete NFT Construction & Dapp System Development	|⭐~⭐⭐|
|S.C Junior L.R | GameFi	|	|⭐⭐|
|S.C Junior L.R | DeFi	|	|⭐⭐|
|S.C Junior L.R | Design_Pattern	| Upgradable Contract, Contract Wallet, Auction Model | ⭐⭐ |
| Interview Problems | Company	| Collected from lots of famous web3 company classical interview problem	|⭐⭐|
|S.C Senior L.R | Testing | 	|⭐⭐|
|S.C Senior L.R | DSA | 	|⭐⭐⭐|
|S.C Senior L.R | Gas_Optim | 	|⭐⭐⭐|
|Theories L.R |	Cryptography |	|⭐⭐⭐|
|EVM L.R|	Assembly |	|⭐⭐⭐|

## Problems Information

### problemVersion1
| No. | Class | Difficulty | Statement | Setter |
| --- | --- | --- | --- | --- |
| 1. ||⭐||Dino|
| 2. ||||Dino|
| 3. ||||Dino|
| 4. ||||Dino|
| 5. ||||Dino|
| 6. ||||Dino|
| 7. ||||Dino|
| 8. ||||Dino|
| 9. ||||Dino|
| 10. ||||Dino|
| 11. ||||Dino|
| 12. ||||Dino|
| 13. ||||Dino|
| 14. ||||Dino|
| 15. ||||Dino|
| 16. ||||Dino|
| 17. ||||Dino|
| 18. ||||Dino|
| 19. ||||Dino|
| 20. ||||Dino|
| 21. ||||FoodChain|
| 22. ||||FoodChain|
| 23. ||||FoodChain|
| 24. ||||FoodChain|
| 25. ||||FoodChain|
| 26. ||||FoodChain|
| 27. ||||FoodChain|
| 28. ||||FoodChain|
| 29. ||||FoodChain|
| 30. ||||FoodChain|
| 31. ||||FoodChain|
| 32. ||||FoodChain|
| 33. ||||FoodChain|
| 34. ||||FoodChain|
| 35. ||||FoodChain|
| 36. ||||FoodChain|
| 37. ||||FoodChain|
| 38. ||||FoodChain|
| 39. ||||FoodChain|
| 40. ||||FoodChain|
| 41. ||⭐⭐||Mur**|
| 42. ||||Mur**|
| 43. ||||Mur**|
| 44. ||||Mur**|
| 45. ||||Mur**|
| 46. ||||Mur**|
| 47. ||||Mur**|
| 48. ||||Mur**|
| 49. ||||Mur**|
| 50. ||||Mur**|
| 51. ||||Mur**|
| 52. ||||Mur**|
| 53. ||||Mur**|
| 54. ||||Mur**|
| 55. ||||Mur**|
| 56. ||||Mur**|
| 57. ||||Mur**|
| 58. ||||Mur**|
| 59. ||||Mur**|
| 60. ||||Mur**|
| 61. ||||Mur**|
| 62. ||||FoodChain|
| 63. ||||FoodChain|
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
| 74. ||||Dino|
| 75. ||||Dino|
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
| 92. ||||Mur**|
| 93. ||||Mur**|
| 94. ||||Mur**|
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
