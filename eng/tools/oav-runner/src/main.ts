#!/usr/bin/env node

// The original ordering of this code is pulled directly from the original at
// openapi-alps#public/rest-api-specs-scripts/src/modelValidationPipeline.ts
import * as oav from 'oav';

// use ,specification, example to filter the changed files to just specs and examples
import { getChangedFiles } from "@azure-tools/specs-shared/changed-files";

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

export function greet(name: string): string {
  return `Hello, ${name}!`;
}

export async function main(rootDirectory: string): Promise<Number> {
    let errors: Array<string> = [];

    const oavType = new oav.LiveValidator({}, undefined);
    console.log(oavType);
    console.log(rootDirectory);

    let results = await getChangedFiles({
      cwd: rootDirectory
    })

    for (const result of results) {
      console.log(result);
    }

    if (errors){
        return 1;
    }
    return 0;
}