# Special Operation

> **If the funcationality is constructing, don't use these operations in your problem!!**

### TODO Functionality

**有些目前還不支援的內容，過一陣子我會處理這個問題，請大家先避開**
- ✅ Basic Judging System Core
- ✅ [Constructor](#constructor): Deploy the contract with constructor call data
- ✅ [Event](#event): Expect the specific events to be emitted
- ✅ [EXPECT_ERROR](#expect_error): Expect the `require`, `revert`, `assert` to be triggered.
- ✅ [WITH_ETHER](#with_ether): Send Ether (or call function with ether) to the Contract
- ✅ [MSG_SENDER](#MSG_SENDER): Use User's Address to be expectReturn or callData
- ⬜️ [WAIT](#wait): Wait for few blocks
- ⬜️ [GAS_USED_LESS](#GAS_USED_LESS): Expect the total gas used less than specific amount.

### Constructor

Constructor Usage: use array to include the arguments's type and the value.

```JSON
"constructorCallData": [
    ["address", "0xdCca4cE55773359E191110Eeb21E0413f770032B"],
    ["uint256", 321]
],
```

### Event

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

### EXPECT_ERROR

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

### WITH_ETHER

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

### MSG_SENDER

Use the `MSG_SENDER` as the callData (Function Input Params) will give the **Address of the User(now Problem Solver)** to target method.

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
    "callData": ["MSG_SENDER"],
    "expectReturn": ["..."]
}
```
> In the above example, if the user's address is `0x123`, the string `"MSG_SENDER"` in the `callData` array will be replaced to `0x123`.

### WAIT

Use `WAIT` as the methodName and `<wait_block_number>` will wait for specific block amount.

```JSON
{
    "methodName": "WAIT",
    "callData": [10],
    "expectReturn": []
}
```
> Above example is Wait for 10 Block mined.

### GAS_USED_LESS
TBD
