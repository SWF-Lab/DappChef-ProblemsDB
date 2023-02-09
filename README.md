<p align="center">
    <h1 align="center">
        🍩 DappChef-ProblemsDB
    </h1>
</p>

## Table of Contents

- [Rules](#rules)
    - [TODO Functionality](#todo-functionality)
    - [Important Announcement](#important-announcement)
    - [Start the Journey](#start-the-journey)
    - [Judge](#judge)
- [Problems](#problems)
    - [Problems Template](#problems-template)
    - [Special Operation](#special-operation)
- [Problems Information & Metadata](/Metadata)
- [Reference](/reference)

---

## Rules

### TODO Functionality

**有些目前還不支援的內容，過一陣子我會處理這個問題，請大家先避開**
- ✅ Basic Judging System Core
- ✅ [Constructor](#constructor): Deploy the contract with constructor call data
- ✅ [Event](#event): Expect the specific events to be emitted
- ✅ [EXPECT_ERROR](#expect_error): Expect the `require`, `revert`, `assert` to be triggered.
- ✅ [WITH_ETHER](#with_ether): Send Ether (or call function with ether) to the Contract
- ✅ [USER_ADDRESS](#user_address): Use User's Address to be expectReturn or callData
- ⬜️ [WAIT](#wait): Wait for few blocks
- ⬜️ [GAS_USED_LESS](#GAS_USED_LESS): Expect the total gas used less than specific amount.

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

4. 請注意佈署過程是 EOA(User) -> Deployer -> AnswerContract，所以**佈署的時候** `msg.sender` 會是 Deployer Contract。所以如果你有 `owner` 設定在 `constructor` 裡面，要讓解題者的 `address` 被設定為 `owner`，必須用 `tx.origin` 不可用 `msg.sender`。
```solidity
// 錯誤出法
constructor() {
    owner = msg.sender;
}

// 正確出法
constructor() {
    owner = tx.origin;
}
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

> **If the funcationality is constructing, don't use these operations in your problem!!**

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

#### EXPECT_ERROR

Use the `%` in front of the methodName and the first element of `callData` will become the `<error_msg>`, which will expect the calling failed and match the error msg.

```solidity
function testRequire(uint256 _i) public pure {
    require(_i > 10, "Input must be greater than 10");
}
```

You can use this in the `problem<number>.json`:
```JSON
{
    "methodName": "%testRequire(uint256)",
    "callData": ["9"],
    "expectReturn": ["Input must be greater than 10"]
}
```

#### WITH_ETHER

Use the `$` in front of the methodName and the first element of `callData` will become the `<etherInWei>`, which will transfer specific amount of goerliEther from user to the contract when call the function. 

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

**The second element of `callData` should be an array, which means the calldata when invoking the function. In another word, if you want just call the fallback/receive function without any input, you should use:**
```JSON
{
    "methodName": "$",
    "callData": ["400000000000",[]],
    "expectReturn": []
},
```

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

#### GAS_USED_LESS
TBD
