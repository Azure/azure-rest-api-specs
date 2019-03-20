const utils = require('../test/util/utils')
const cp = require("child_process")
import path from "path"

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

async function main() {
  const swaggersToProcess = utils.getFilesChangedInPR();
  let result = 0
  for (const swagger of swaggersToProcess) {
    try {
      const avocadoPath = path.resolve("node_modules/.bin/avocado")
      // await oav.validateExamples(swagger, null, {consoleLogLevel: 'error', pretty: true});
      // run OAV as a separate process to avoid memory issues.
      console.log(path.dirname(swagger))
      const r = exec(
        avocadoPath,
        {
          cwd: path.dirname(swagger)
        })
      if (result === 0) {
        result = r
      }
    } catch (e) {
      console.error("error: ")
      console.error(e)
      result = 1
    }
  }
  return result
}

main()