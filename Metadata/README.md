# Problems Information & Metadata

### Table of Contents
- [Reward NFT Metadata](#reward-nft-metadata)
- [Problems Classification Instructions](#problems-classification-instructions)
- [problemVersion1](#problemVersion1)
- [problemVersion2 (TBD)](#problemVersion2)

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
| 47. |Company|⭐⭐|Advanced Withdraw |Mur**|
| 48. |DSA|⭐⭐| Merkle Tree |Mur** ✅|
| 49. |DeFi|⭐⭐|Simple Staking DeFi Protocol|Mur** |
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

### problemVersion2

> TBD, these problems will be added after DappChef begins earning.
