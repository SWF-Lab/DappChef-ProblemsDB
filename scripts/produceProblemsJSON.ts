import * as fs from 'fs'
import path from "path";
import { NFTStorage } from 'nft.storage'
import { filesFromPath } from 'files-from-path'
import dotenv from 'dotenv';
dotenv.config();

const token = process.env.NFT_STORAGE_API_TOKEN as string

async function upload() {
    
    const directoryPath = "./problemVersion1/problems"
    const files = filesFromPath(directoryPath, {
        pathPrefix: path.resolve(directoryPath), // see the note about pathPrefix below
        hidden: true, // use the default of false if you want to ignore files that start with '.'
    })

    const storage = new NFTStorage({ token })

    console.log(`storing file(s) from ${path}`)
    const cid = await storage.storeDirectory(files)
    console.log({ cid })

    const status = await storage.status(cid)
    console.log(status)
}

async function main() {
    let obj = {}

    for (let i = 1; i <= 100; i++) {
        let problemNumber = i
        try{
            const raw_problemInfo = fs.readFileSync(path.join(__dirname, `../problemVersion1/${problemNumber}/problem${problemNumber}.json`))
            const problemInfo = JSON.parse(raw_problemInfo as any);
            obj[`${problemNumber}`] = problemInfo

            const problemText = fs.readFileSync(path.join(__dirname, `../problemVersion1/${problemNumber}/problem${problemNumber}.txt`))
            fs.writeFileSync(`./problemVersion1/problems/${problemNumber}.txt`, problemText)
        } catch {
            continue
        }    
    }
    // console.log(obj)

    let data = JSON.stringify(obj)
    fs.writeFileSync('problems.json', data)
    await upload()
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })