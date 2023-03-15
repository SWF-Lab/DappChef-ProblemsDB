import * as fs from 'fs'
import path from "path";
import { ethers } from "hardhat"
import prompts from "prompts"
import Ganache from "ganache-core";

// $ yarn execute scripts/judgeGanache.ts

async function main() {

    /** ---------------------------------------------------------------------------
     * Setting up the basic ethers object 
     * --------------------------------------------------------------------------- */
    
    const ganache = Ganache.provider({});
    const provider = new ethers.providers.Web3Provider(ganache as any);

    const accounts = await provider.listAccounts();

    const wallet = provider.getSigner(accounts[0]);
    const wallet_1 = provider.getSigner(accounts[1]);
    const wallet_2 = provider.getSigner(accounts[2]);
    const wallet_3 = provider.getSigner(accounts[3]);
    const wallet_4 = provider.getSigner(accounts[4]);
    const wallet_5 = provider.getSigner(accounts[5]);
    const wallet_6 = provider.getSigner(accounts[6]);
    const wallet_7 = provider.getSigner(accounts[7]);
    const wallet_8 = provider.getSigner(accounts[8]);
    const wallet_9 = provider.getSigner(accounts[9]);

    // const wallet = new ethers.Wallet(process.env.ETHEREUM_PRIVATE_KEY as any, provider)

    /**  ---------------------------------------------------------------------------
     * Choose the judge problem and construct the answer contract instance 
     * --------------------------------------------------------------------------- */

    const problemNumber = await promptProblem()

    const rawContractInstance = fs.readFileSync(path.join(__dirname, `../artifacts/problemVersion1/${problemNumber}/answer${problemNumber}.sol/answer${problemNumber}.json`))
    const contractInstance = JSON.parse(rawContractInstance.toString());
    const creationCode = contractInstance.bytecode
    const AnswerABI = contractInstance.abi

    const rawJudgeInfo = fs.readFileSync(path.join(__dirname, `../problemVersion1/${problemNumber}/problem${problemNumber}.json`))
    const JudgeInfo = JSON.parse(rawJudgeInfo.toString());

    // Replace the MSG_SENDER
    const originalSolution = JudgeInfo.problemSolution
    const stringified = JSON.stringify(originalSolution);
    const replaced = stringified.replace(/"MSG_SENDER"/g, `"${(await wallet.getAddress()).toString()}"`);
    const solution = JSON.parse(replaced);

    const constructorCode = ethers.utils.defaultAbiCoder.encode(
        JudgeInfo.constructorCallData.map((e: any) => e[0]),
        JudgeInfo.constructorCallData.map((e: any) => e[1])
    )
    const bytecode = ethers.utils.solidityPack(
        ["bytes", "bytes"],
        [creationCode, constructorCode]
    )

    /** ---------------------------------------------------------------------------
     * Judge the answer contract with the "problemSolution" in the problem json 
     * --------------------------------------------------------------------------- */

    const AnswerContractFactory = new ethers.ContractFactory(
        AnswerABI,
        bytecode,
        wallet
    );
    const undeployedAnswerContract = await AnswerContractFactory.deploy();
    const AnswerContract = undeployedAnswerContract.connect(
        wallet
    );
    const _deployAddr = AnswerContract.address
    console.log(`\nBegin the Judging...`)

    let pastTXInfo: any
    let totalGas = ethers.BigNumber.from("0")

    for (let i = 0; i < solution.length; i++) {

        console.log(`    \nTesting ${i}: ${solution[i].methodName}`)
        console.log(`    - Sample Input: ${solution[i].callData}`)

        try {
            // If this methodName is Check Event Emitted
            if ((solution[i].methodName).substring(0, 1) == "#") {

                // Get expectReturn
                const topics0 = ethers.utils.id((solution[i].methodName).substring(1))
                const indexedValue = solution[i].expectReturn[0]
                const nonIndexedValue = solution[i].expectReturn[1].length == 0 ? "" : solution[i].expectReturn[1]
                console.log(`    - Sample Output: ${topics0},${indexedValue},${nonIndexedValue}`)

                // Get the Transaction Log
                const log = AnswerContract.interface.parseLog(pastTXInfo["logs"][0])
                const id = (log.topic).toString()
                const eventTopics = (log.args.slice(0, indexedValue.length)).toString()
                const eventData = nonIndexedValue.length != 0 ?
                    (log.args.slice(indexedValue.length, indexedValue.length + nonIndexedValue.length)).toString()
                    : ""
                console.log(`    - Your Output: ${id},${eventTopics},${eventData}`)

                // Comparing
                if (id == topics0 && eventTopics == indexedValue && eventData == nonIndexedValue) {
                    console.log(`    ...Accepted!`)
                }
                else {
                    console.log(`    ...Wrong Answer!`)
                    return
                }
                continue
            }
            // expect the calling failed and match the error msg.
            else if ((solution[i].methodName).substring(0, 1) == "%") {
                console.log(`    - Expect Error Msg: ${(solution[i].expectReturn)}`)
                try {
                    const _return = await AnswerContract[(solution[i].methodName).substring(1)](
                        ...solution[i].callData
                    )
                    pastTXInfo = await _return.wait()
                    console.log(`    ...Wrong Answer!`)
                    return
                } catch (e: any) {
                    console.log(`    ...Accepted!`)
                }
            }
            // Write Function / Get Function
            else {
                let _return: any

                // call with ether
                if ((solution[i].methodName).substring(0, 1) == "$") {
                    // call the fallback or receive function
                    if ((solution[i].methodName).length == 1) {
                        const tx = (solution[i].callData)[1].length == 0 ?
                            {
                                to: _deployAddr,
                                value: (solution[i].callData)[0]
                            } :
                            {
                                to: _deployAddr,
                                data: ethers.utils.solidityPack(["bytes"], [(solution[i].callData)[1][0]]),
                                value: (solution[i].callData)[0]
                            }
                        _return = await wallet.sendTransaction(tx);
                        pastTXInfo = await _return.wait()
                        totalGas = totalGas.add(pastTXInfo.gasUsed)
                        console.log(`    ...Fallback/Receive Function Finished!`)
                        continue
                    }
                    else {
                        _return = await AnswerContract[(solution[i].methodName).substring(1)](
                            ...(solution[i].callData)[1], { value: (solution[i].callData)[0] }
                        )
                    }

                }
                else {
                    _return = await AnswerContract[solution[i].methodName](
                        ...solution[i].callData
                    )
                }

                if (solution[i].expectReturn.length == 0) {
                    pastTXInfo = await _return.wait()
                    totalGas = totalGas.add(pastTXInfo.gasUsed)
                    console.log(`    ...Write Function Finished!`)
                    continue
                }

                console.log(`    - Sample Output: ${solution[i].expectReturn}`)
                console.log(`    - Your Output: ${_return}`)
                if (_return.toString() == solution[i].expectReturn.toString()) {
                    console.log(`    ...Accepted!`)
                }
                else {
                    console.log(`    ...Wrong Answer!`)
                    return
                }
            }
        } catch (e: any) {
            console.log(e)
            return
        }
    }
    console.log("\nAll Accepted!")
    console.log(`Total Used Gas: ${totalGas.toString()}`)
}

async function promptProblem() {
    const response = await prompts({
        type: "text",
        name: "problemNumber",
        message:
            "Please enter the problemNumber you want to judge:",
    })
    return response.problemNumber
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })