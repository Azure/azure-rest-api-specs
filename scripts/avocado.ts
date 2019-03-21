const utils = require('../test/util/utils')
// const cp = require("child_process")
import * as path from "path"
import * as avocado from "@azure/avocado"

/*
const exec = (cmd: string, options: {}) => {
  const result = cp.spawnSync(
    cmd,
    {
      ...options,
      shell: true,
      stdio: [process.stdin, process.stdout, process.stderr]
    }
  )
  return result.status
}
*/

async function main() {
  const swaggersToProcess = utils.getFilesChangedInPR();
  let errorNumbers = 0
  for (const swagger of swaggersToProcess) {
    try {
      // const avocadoPath = path.resolve("node_modules/.bin/avocado")
      // await oav.validateExamples(swagger, null, {consoleLogLevel: 'error', pretty: true});
      // run OAV as a separate process to avoid memory issues.
      // console.log(path.dirname(swagger))
      /*
      const r = exec(
        avocadoPath,
        {
          cwd: path.dirname(swagger)
        })
        */
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