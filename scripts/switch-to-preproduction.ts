import process from 'process';
import fs from 'fs';
import childProcess from 'child_process';

function main() {
  if (!process.env.PREPRODUCTION_PIPELINE) {
    return;
  }

  console.log('Switch to preproduction package.json');
  fs.copyFileSync('.azure-pipelines-preproduction/package.json', 'package.json');
  fs.copyFileSync('.azure-pipelines-preproduction/package-lock.json', 'package-lock.json');

  childProcess.execSync('npm ci', {
    env: {
      ...process.env,
      PREPRODUCTION_PIPELINE: ''
    }
  });
}

main();
