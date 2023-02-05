import * as fs from 'fs'
import path from "path";
import { ethers } from "hardhat"
import prompts from "prompts"
import DEPLOYER_ABI from "./DeployerABI.json"

async function main() {

    /** ---------------------------------------------------------------------------
     * Setting up the basic ethers object 
     * --------------------------------------------------------------------------- */

    const provider = ethers.provider
    const wallet = new ethers.Wallet(process.env.ETHEREUM_PRIVATE_KEY as any, provider)

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
    const solution = JudgeInfo.problemSolution

    const constructorCode = ethers.utils.defaultAbiCoder.encode(
        JudgeInfo.constructorCallData.map((e: any) => e[0]),
        JudgeInfo.constructorCallData.map((e: any) => e[1])
    )
    const bytecode = ethers.utils.solidityPack(
        ["bytes", "bytes"],
        [creationCode, constructorCode]
    )
   
    /** ---------------------------------------------------------------------------
     * User deploer contract to deploy the answer contract 
     * --------------------------------------------------------------------------- */
    
    const DeployerContract = new ethers.Contract(
        process.env.DEPLOYER_CONTRACT_ADDR as string,
        DEPLOYER_ABI,
        wallet
    )

    console.log(`Trying to deploy problem ${problemNumber} with Deployer Contract:`)
    
    const tx = await DeployerContract.deploy(bytecode, wallet.address, problemNumber)
    const receipt = await tx.wait()
    const event = receipt.events.find((e: any) => e.event === "Deploy")
    const [_deployAddr, _solver, _problemNum] = event.args
    console.log(`    Tx successful with hash: ${receipt.transactionHash}`)
    console.log(`    Deployed contract address is ${_deployAddr}`)

    /** ---------------------------------------------------------------------------
     * Judge the answer contract with the "problemSolution" in the problem json 
     * --------------------------------------------------------------------------- */

    const AnswerContract = await ethers.getContractAt(AnswerABI, _deployAddr, wallet)
    console.log(`\nBegin the Judging...`)

    for (let i = 0; i < solution.length; i++) {

        console.log(`    \nTesting ${i}: ${solution[i].methodName}`)
        console.log(`    - Sameple Input: ${solution[i].callData}`)
        
        try{
            const _return = await AnswerContract[solution[i].methodName](
                ...solution[i].callData
            )

            if (solution[i].expectReturn.length == 0){
                await _return.wait()
                console.log(`    ...Write Function Finished!`)
                continue
            }

            console.log(`    - Sameple Output: ${solution[i].expectReturn}`)
            console.log(`    - Your Output: ${_return}`)
            if (_return.toString() == solution[i].expectReturn.toString()) {
                console.log(`    ...Accepted!`)
            }
            else{
                console.log(`    ...Wrong Answer!`)
                return
            }
        } catch (e: any) {
            console.log(e)
            return
        }
    }
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