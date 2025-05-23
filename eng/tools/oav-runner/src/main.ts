#!/usr/bin/env node

// The original ordering of this code is pulled directly from the original at
// openapi-alps#public/rest-api-specs-scripts/src/modelValidationPipeline.ts
import * as oav from 'oav';
import * as path from 'path';
// import * as glob from 'glob';
import * as fs from 'fs';

import { getChangedFiles, swagger } from "@azure-tools/specs-shared/changed-files";

export async function checkSpecs(rootDirectory: string): Promise<[number, Array<object>]> {
    let errors: Array<object> = [];

    console.log(`Executing checks in ${rootDirectory}`);

    const changedFiles = await getChangedFiles({
      cwd: rootDirectory
    })

    const swaggerFiles = await processFilesToSpecificationList(rootDirectory, changedFiles);

    for (const swaggerFile of swaggerFiles) {
      try {
        const errorResults = await oav.validateSpec(swaggerFile, undefined);

        if (errorResults.validateSpec && errorResults.validateSpec.errors){
          errors.push(errorResults.validateSpec.errors);
        }
      }
      catch (e) {
        // todo: add error handling beyond logging
        console.log(e);
      }
    }

    if (errors){
        return [1, errors];
    }
    return [0, []];
}


export async function processFilesToSpecificationList(rootDirectory: string, files: string[]): Promise<Array<string>> {
    // this is implemented in existing example and spec validation pipeline simply by pulling _all_ of the swagger files
    // and then filtering them down to just the ones that are in the changed files list.

    // we might have to do that, but as far as I can tell, the "pull everything" approach only works for the nonPR. If its PR
    // it literally never uses the total result.
    return files.filter((file) => {
      if (
          file.match(/.*\/cadl-project.yaml$/gi) !== null ||
          file.match(/.*\/package.json$/gi) !== null ||
          file.match(/.*\/sdk-suppressions.yaml$/gi) !== null ||
          file.match(/.*\/suppressions.yaml$/gi) !== null ||
          file.match(/.*\/tspconfig.yaml$/gi) !== null ||
          file.match(/.*\/cspell.yaml$/gi) !== null ||
          file.match(/.*\/scenarios\/*/gi) !== null ||
          file.match(/.*(json|yaml)$/gi) == null ||
          file.match(/.*specification\/.*/gi) == null ||
          file.match(/.*\/examples\/*/gi) !== null ||
          file.match(/.*\/quickstart-templates\/*/gi) !== null
        ) {
          return false;
        }

        let swaggerResult = swagger(file);
        let targetFile = path.join(rootDirectory, file);
        console.log(`Checking ${targetFile}`);

        // if it's a swagger file, we should check to see if it exists
        // as a deleted file will also show up in the changed files list
        if (swaggerResult && fs.existsSync(targetFile)) {
          return true
        }
        return false;
      });
}


// keep these around for now, but they are not used in the current implementation
// the biggest thing is that I'm uncertain if I will need to keep some sort of this globbing around to support when _only_ examples
// are changed, for instance.

// export const getSwaggers = () => {
//   const getGlobPath = () =>
//     path.join(__dirname, "../", "../", "/specification/**/*.json");
//     return glob.sync(getGlobPath(), {
//     ignore: [
//       "**/scenarios/**/*.json",
//       "**/examples/**/*.json",
//       "**/quickstart-templates/*.json",
//       "**/schema/*.json",
//     ],
//   });
// };

// export const getExamples = () => {
//   const exampleGlobPath = path.join(
//     __dirname,
//     "../",
//     "../",
//     "/specification/**/examples/**/*.json"
//   );
//   return glob.sync(exampleGlobPath);
// };

// this is some code from modelValidationPipeline.ts that is not used in the current implementation
// import jsYaml from 'js-yaml';

// // type ErrorType = "error" | "warning";

// // const vsoLogIssueWrapper = (issueType: string, message: string) => {
// //   return `##vso[task.logissue type=${issueType}]${message}`;
// // }

// // const prettyPrint = <T extends oav.NodeError<T>>(
// //   errors: ReadonlyArray<T> | undefined,
// //   errorType: ErrorType
// // ) => {
// //   if (errors !== undefined) {
// //     for (const error of errors) {
// //       const yaml = jsYaml.dump(error);
// //       if (process.env["Agent.Id"]) {
// //         /* tslint:disable-next-line:no-console no-string-literal */
// //         console.error(vsoLogIssueWrapper(errorType, errorType));
// //         /* tslint:disable-next-line:no-console no-string-literal */
// //         console.error(vsoLogIssueWrapper(errorType, yaml));
// //       } else {
// //         /* tslint:disable-next-line:no-console no-string-literal */
// //         console.error("\x1b[31m", errorType, ":", "\x1b[0m");
// //         /* tslint:disable-next-line:no-console no-string-literal */
// //         console.error(yaml);
// //       }
// //     }
// //   }
// // }
