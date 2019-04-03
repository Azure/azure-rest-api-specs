const utils = require('../test/util/utils')
import * as path from "path"
import * as avocado from "@azure/avocado"
import * as openApiMarkDown from "@azure/openapi-markdown"
import * as yaml from "js-yaml"
import * as util from "util"
import * as childProcess from "child_process"
import * as fs from "fs"

const exec = util.promisify(childProcess.exec)
const mkdir = util.promisify(fs.mkdir)

type Result = {
  readonly stdout: string
  readonly stderr: string
}

const execWrap = async (c: string, cwd?: string): Promise<Result> => {
  try {
    const result = await exec(c, { cwd })
    return result
  } catch (e) {
    console.error(e)
    return { stdout: "", stderr: "" }
  }
}

async function main() {
  const current = path.resolve(process.cwd())
  // console.log(`vars: ${JSON.stringify(process.env)}`)
  // const source = process.env.SYSTEM_PULLREQUEST_SOURCEBRANCH
  const target = process.env.SYSTEM_PULLREQUEST_TARGETBRANCH
  // console.log(`source: ${source}`)
  console.log(`target: ${target}`)
  // const sourceBranchName = "source-731debc6-97f9-4d30-afb3-9abffc660325"
  // const targetBranchName = "target-731debc6-97f9-4d30-afb3-9abffc660325"
  // await execWrap(`git branch ${sourceBranchName}`)
  await execWrap(`git branch ${target} remotes/origin/${target}`)
  {
    const { stdout } = await execWrap(`git diff ${target}..HEAD --name-status`)
    console.log(stdout)
  }
  await mkdir("../old")
  const parsedCurrent = path.parse(current)
  const oldCwd = path.resolve(path.join(current, "../old"))
  await execWrap(`git clone ${current} -s`, oldCwd)
  const oldRepoPath = path.join(oldCwd, parsedCurrent.base)
  console.log(oldRepoPath)
  {
    const { stdout } = await execWrap(`git checkout -b ${target} remotes/origin/${target}`, oldRepoPath)
    console.log(stdout)
  }

  const swaggersToProcess = utils.getFilesChangedInPR();
  let errorNumbers = 0
  const set = new Set<string>()
  for (const swagger of swaggersToProcess) {
    const rm = await openApiMarkDown.findReadMe(path.dirname(swagger))
    if (rm === undefined) {
      console.error(`No readme.md for ${swagger}`)
      ++errorNumbers
    } else {
      const dir = path.dirname(rm)
      if (dir.includes("specification")) {
        set.add(dir)
      } else {
        console.error(`No readme.md for ${swagger}`)
        ++errorNumbers
      }
    }
  }
  for (const swagger of set) {
    try {
      console.log(swagger)
      const errors = avocado.avocado(swagger)
      for await (const e of errors) {
        console.error(yaml.safeDump(e))
        ++errorNumbers
      }
    } catch (e) {
      console.error("fatal error:")
      console.error(e)
      ++errorNumbers
    }
  }
  console.log(`errors: ${errorNumbers}`)
  return errorNumbers === 0 ? 0 : 1
}

main().then(process.exit)