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
- [Metadata](./doc/metadata.md)
- [Special Operation](./doc/special-operations.md)
- [Problems Information](./doc/problems-info.md)
- [Reference](./doc/reference.md)

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
`problem48.txt` 的 contract 必須為 `problem48`：
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
4. Compile the contract:
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
$ yarn execute scripts/judgeGanache.ts
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
### Appendix: Produce Problems Information

```
$ yarn execute scripts/produceProblemsJSON.ts
>
storing file(s) from [object Object]
PROBLEMS_CODE_IPFS_CID
{
  cid: 'bafybeibrjtmdmpv4g2j7yibdhijlq3m6huq34jqfj3twglpyea6xk7pcz4',
  deals: [],
  size: 173575,
  pin: {
    cid: 'bafybeibrjtmdmpv4g2j7yibdhijlq3m6huq34jqfj3twglpyea6xk7pcz4',
    created: 2023-03-19T05:14:07.137Z,
    size: 173575,
    status: 'pinned'
  },
  created: 2023-03-19T05:14:07.137Z
}
storing file(s) from [object Object]
PROBLEMS_IPFS_CID
{
  cid: 'bafybeiclx7jl4eqyesgvj6umcus7ihbfzlwlfvjm2rn3iej3rvtodebexm',
  deals: [],
  size: 57387,
  pin: {
    cid: 'bafybeiclx7jl4eqyesgvj6umcus7ihbfzlwlfvjm2rn3iej3rvtodebexm',
    created: 2023-03-19T05:14:18.942Z,
    size: 57387,
    status: 'pinned'
  },
  created: 2023-03-19T05:14:18.942Z
}
Done in 28.07s.
```