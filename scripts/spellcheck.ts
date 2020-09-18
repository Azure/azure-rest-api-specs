import { logError, logWarn, runCheckOverChangedSpecFiles } from './utils';

runCheckOverChangedSpecFiles({
  onCheckFile: (context, filePath) => {
    return context.exec(`cspell ${filePath}`);
  },

  onExecError: async (result) => {
    if (result.stdout) {
      logError(result.stdout);
    }
    if (result.stderr) {
      console.error(result.stderr);
    }
  },

  onNotInCI: (context) => {
    logWarn("Not in CI environment. Run against all the spec json.");
    return context.exec(`cspell "specification/**/*.json"`);
  },

  onFinalFailed: async () => {
    logError('Please fix the error or add words to ./custom-words.txt');
  }
})