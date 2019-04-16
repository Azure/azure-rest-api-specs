import * as scripts from '@azure/rest-api-specs-scripts'

scripts.breakingChange().then(() => {
  console.log(`Thanks for using breaking change tool to review.`);
  console.log(`If you encounter any issue(s), please open issue(s) at https://github.com/Azure/openapi-diff/issues .`);
}).catch(err => {
  console.log(err);
  process.exitCode = 1;
})