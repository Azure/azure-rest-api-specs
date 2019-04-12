import * as avocado from '@azure/avocado'
import * as fs from 'fs'
import * as path from 'path'
import * as util from 'util'
import * as childProcess from 'child_process'
import * as stringMap from '@ts-common/string-map'
import * as utils from './utils2'

const exec = util.promisify(childProcess.exec)

const getConfigFilesChangedInPR = async (pr: avocado.PullRequestProperties) => {
  const filesChanged = await pr.diff()

  // traverse up to readme.md files
  const configFiles = new Set<string>();
  for (const fileChangedTuple of filesChanged) {
    let fileChanged = fileChangedTuple.path
    while (fileChanged.startsWith("specification")) {
      if (fileChanged.toLowerCase().endsWith("readme.md") && fs.existsSync(fileChanged)) {
        configFiles.add(fileChanged);
        break;
      }
      // select parent readme
      const parts = fileChanged.split('/');
      parts.pop();
      parts.pop();
      parts.push("readme.md");
      fileChanged = parts.join('/');
    }
  }
  const result = [...configFiles.values()];

  console.log('>>>>> Affected configuration files:');
  console.log(result);
  return result;
}

// Creates and returns path to the logging directory
const getLogDir = () => {
  let logDir = path.join(__dirname, '../', 'output');
  if (!fs.existsSync(logDir)) {
      try {
          fs.mkdirSync(logDir);
      } catch (e) {
          if (e.code !== 'EEXIST') throw e;
      }
  }
  return logDir;
}

/**
 * Gets the PR number. We are using the environment
 * variable provided by travis-ci. It is called TRAVIS_PULL_REQUEST. More info can be found here:
 * https://docs.travis-ci.com/user/environment-variables/#Convenience-Variables
 * @returns {string} PR number or 'undefined'.
 */
const getPullRequestNumber = () => {
  let result = process.env['TRAVIS_PULL_REQUEST']
  console.log(
    `@@@@@ process.env['TRAVIS_PULL_REQUEST'] - ${process.env['TRAVIS_PULL_REQUEST']}`
  )

  if (!result) {
    result = 'undefined'
  }

  return result
}

const linterCmd =
  `npx autorest --validation --azure-validator --message-format=json `

// Executes linter on given swagger path and returns structured JSON of linter output
const getLinterResult = async (swaggerPath: string): Promise<utils.MomentOfTruthFileResult> => {
  if (swaggerPath === null || swaggerPath === undefined || typeof swaggerPath.valueOf() !== 'string' || !swaggerPath.trim().length) {
    throw new Error('swaggerPath is a required parameter of type "string" and it cannot be an empty string.');
  }

  let jsonResult = []
  if (!fs.existsSync(swaggerPath)) {
    return []
  }
  let cmd = "npx autorest --reset && " + linterCmd + swaggerPath
  console.log(`Executing: ${cmd}`)
  const { stdout, stderr } = await exec(cmd, { encoding: 'utf8', maxBuffer: 1024 * 1024 * 64 })

  if (stderr.indexOf("Process() cancelled due to exception") !== -1) {
    console.error(stderr)
    throw new Error("AutoRest failed")
  }

  let resultString = stdout + stderr;
  if (resultString.indexOf('{') !== -1) {
      resultString = resultString.replace(/Processing batch task - {.*} \.\n/g, "")
      resultString = "[" + resultString.substring(resultString.indexOf('{')).trim().replace(/\}\n\{/g, "},\n{") + "]"
      //console.log('>>>>>> Trimmed Result...')
      //console.log(resultString)
      try {
          jsonResult = JSON.parse(resultString)
          //console.log('>>>>>> Parsed Result...')
          //console.dir(resultObject, {depth: null, colors: true})
          return jsonResult
      } catch (e) {
          console.error(`An error occurred while executing JSON.parse() on the linter output for ${swaggerPath}:`);
          console.dir(resultString)
          console.dir(e, { depth: null, colors: true })
          process.exit(1)
      }
  }
  return []
}

/**
 * Gets the Repo name. We are using the environment
 * variable provided by travis-ci. It is called TRAVIS_REPO_SLUG. More info can be found here:
 * https://docs.travis-ci.com/user/environment-variables/#Convenience-Variables
 * @returns {string} repo name or 'undefined'.
 */
const getRepoName = () => {
  const result = process.env['TRAVIS_REPO_SLUG'];
  console.log(`@@@@@ process.env['TRAVIS_REPO_SLUG'] - ${result}`);

  return result;
};

// Retrieves Git Repository Url
/**
 * Gets the repo URL
 * @returns {string} repo URL or 'undefined'
 */
const getRepoUrl = () => {
  const repoName = getRepoName()
  return `https://github.com/${repoName}`
}

// main function
const runScript = async () => {
  const pullRequestNumber = getPullRequestNumber()
  const filename = `${pullRequestNumber}.json`
  const logFilepath = path.join(getLogDir(), filename)
  const finalResult: utils.MomentOfTruthResult = {
    pullRequest: pullRequestNumber,
    repositoryUrl: getRepoUrl(),
    files: {},
  }

  //appends the content to the log file
  const writeContent = (content: string) =>
    fs.writeFileSync(logFilepath, content)

  const runTools = async (swagger: string, beforeOrAfter: 'before' | 'after') => {
    console.log(`Processing "${swagger}":`);
    const linterErrors = await getLinterResult(swagger);
    console.log(linterErrors);
    await updateResult(swagger, linterErrors, beforeOrAfter);
  };

  // Updates final result json to be written to the output file
  const updateResult = async (spec: string, errors: utils.MomentOfTruthFileResult, beforeOrAfter: 'before'|'after') => {
    const files = finalResult['files']
    let filesSpec = files[spec]
    if (!filesSpec) {
      files[spec] = filesSpec = {
        before: [],
        after: [],
      }
    }
    filesSpec[beforeOrAfter] = errors;
  }

  //creates the log file if it has not been created
  const createLogFile = () => {
    if (!fs.existsSync(logFilepath)) {
        fs.writeFileSync(logFilepath, '')
    }
  }

  // config.cwd is used as a source repository
  const config = avocado.defaultConfig()
  // pr.workingDir is used as a target repository
  const pr = await avocado.createPullRequestProperties(config)
  if (pr === undefined) {
    return
  }

  const configsToProcess = await getConfigFilesChangedInPR(pr)
  console.log('Processing configs:')
  console.log(configsToProcess)
  createLogFile()
  console.log(`The results will be logged here: "${logFilepath}".`)

  if (configsToProcess.length > 0) {
      for (const configFile of configsToProcess) {
          await runTools(configFile, 'after')
      }

      pr.checkout(pr.targetBranch)
      process.chdir(pr.workingDir)
      for (const configFile of configsToProcess) {
          await runTools(configFile, 'before')
      }
      process.chdir(config.cwd)
  }

  writeContent(JSON.stringify(finalResult, null, 2))
}

// magic starts here
runScript().then(_ => {
  process.exit(0);
}).catch(_ => {
  process.exit(1);
})