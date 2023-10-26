import { TsvHost } from "./tsv-host.js";
import { simpleGit } from "simple-git";
import { runCmd, checkFileExists } from "./utils.js";

export const TsvRunnerHost: TsvHost = {
  gitOperation: simpleGit,
  runCmd: runCmd,
  checkFileExists: checkFileExists,
  // TODO: Other functions that need mocks
};
