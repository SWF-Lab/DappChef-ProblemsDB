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
| No. | Class | Difficulty | Statement |
| --- | --- | --- | --- |
| 1. ||⭐||
| 2. ||||
| 3. ||||
| 4. ||||
| 5. ||||
| 6. ||||
| 7. ||||
| 8. ||||
| 9. ||||
| 10. ||||
| 11. ||||
| 12. ||||
| 13. ||||
| 14. ||||
| 15. ||||
| 16. ||||
| 17. ||||
| 18. ||||
| 19. ||||
| 20. ||||
| 21. ||||
| 22. ||||
| 23. ||||
| 24. ||||
| 25. ||||
| 26. ||||
| 27. ||||
| 28. ||||
| 29. ||||
| 30. ||||
| 31. ||||
| 32. ||||
| 33. ||||
| 34. ||||
| 35. ||||
| 36. ||||
| 37. ||||
| 38. ||||
| 39. ||||
| 40. ||||
| 41. ||⭐⭐||
| 42. ||||
| 43. ||||
| 44. ||||
| 45. ||||
| 46. ||||
| 47. ||||
| 48. ||||
| 49. ||||
| 50. ||||
| 51. ||||
| 52. ||||
| 53. ||||
| 54. ||||
| 55. ||||
| 56. ||||
| 57. ||||
| 58. ||||
| 59. ||||
| 60. ||||
| 61. ||||
| 62. ||||
| 63. ||||
| 64. ||||
| 65. ||||
| 66. ||||
| 67. ||||
| 68. ||||
| 69. ||||
| 70. ||||
| 71. ||||
| 72. ||||
| 73. ||||
| 74. ||||
| 75. ||||
| 76. ||||
| 77. ||||
| 78. ||||
| 79. ||||
| 80. || ⭐⭐⭐ ||
| 81. ||||
| 82. ||||
| 83. ||||
| 84. ||||
| 85. ||||
| 86. ||||
| 87. ||||
| 88. ||||
| 89. ||||
| 90. ||||
| 91. ||||
| 92. ||||
| 93. ||||
| 94. ||||
| 95. ||||
| 96. ||||
| 97. ||||
| 98. ||||
| 99. ||||
| 100. ||||

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
