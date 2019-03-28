const utils = require('../test/util/utils')
import * as path from "path"
import * as avocado from "@azure/avocado"
import * as openApiMarkDown from "@azure/openapi-markdown"
import * as yaml from "js-yaml"

async function main() {
  // console.log(`vars: ${JSON.stringify(process.env)}`)
  const source = process.env.SYSTEM_PULLREQUEST_SOURCEBRANCH
  const target = process.env.SYSTEM_PULLREQUEST_TARGETBRANCH
  console.log(`source: ${source}`)
  console.log(`target: ${target}`)

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