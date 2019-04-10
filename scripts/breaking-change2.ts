import * as avocado from '@azure/avocado'
import * as process from 'process'

//main function
const runScript = async () {
  await avocado.createPullRequestProperties({ cwd: process.cwd(), env: process.env })
}

// magic starts here
runScript().then(_ => {
  console.log('Thanks for using breaking change tool to review.');
  console.log('If you encounter any issue(s), please open issue(s) at https://github.com/Azure/openapi-diff/issues .');
}).catch(err => {
  console.log(err);
  process.exitCode = 1;
})