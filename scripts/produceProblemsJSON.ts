import * as fs from 'fs'
import path from "path";

async function main() {
    let obj = {}

    for (let i = 1; i <= 100; i++) {
        let problemNumber = i
        try{
            const raw_problemInfo = fs.readFileSync(path.join(__dirname, `../problemVersion1/${problemNumber}/problem${problemNumber}.json`))
            const problemInfo = JSON.parse(raw_problemInfo as any);
            obj[`${problemNumber}`] = problemInfo
        } catch {
            continue
        }    
    }
    // console.log(obj)

    let data = JSON.stringify(obj);
    fs.writeFileSync('problems.json', data);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })