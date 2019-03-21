const utils = require('../test/util/utils')
import * as path from "path"
import * as avocado from "@azure/avocado"
import * as openApiMarkDown from "@azure/openapi-markdown"

async function main() {
  const swaggersToProcess = utils.getFilesChangedInPR();
  let errorNumbers = 0
  const set = new Set<string>()
  for (const swagger of swaggersToProcess) {
    const dir = await openApiMarkDown.findReadMe(path.dirname(swagger))
    if (dir === undefined) {
      console.error(`No readme.md for ${swagger}`)
      ++errorNumbers
    } else {
      set.add(dir)
    }
  }
  for (const swagger of set) {
    try {
      const errors = avocado.avocado(path.dirname(swagger))
      for await (const e of errors) {
        console.error(e)
        ++errorNumbers
      }
    } catch (e) {
      console.error("fatal error:")
      console.error(e)
    }
  }
  console.log(`errors: ${errorNumbers}`)
  return errorNumbers == 0 ? 0 : 1
}

main()