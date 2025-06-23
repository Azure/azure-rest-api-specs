/**
 * By design, the only members exported from this file are:
 * - function detectBreakingChange()
 * - let defaultBreakingChangeBaseBranch
 *
 * defaultBreakingChangeBaseBranch must be exported as it is a static variable. TODO: refactor it.
 *
 * In the "breakingChanges directory invocation depth" this file has depth 1,
 * i.e. it is invoked by files with depth 0 and invokes files with depth 2.
 */

import { RawMessageRecord, ResultMessageRecord } from "./types/message.js";
import { mkdirSync, readFileSync, writeFileSync, existsSync, rmSync } from "node:fs";
import * as path from "path";
import { OadTrace } from "./types/oad-types.js";
import { BreakingChangeDetector } from "./breaking-change-detector.js";
import { BreakingChangesCheckType, Context } from "./types/breaking-change-check.js";
import { getSwaggerDiffs } from "./command-helpers.js";
import { generateBreakingChangeResultSummary } from "./generate-report.js";

/**
 * The function detectBreakingChange() is executed with type SameVersion or CrossVersion, by
 * corresponding runScript functions in:
 * - breakingChangeValidationPipeline.ts
 * - crossVersionBreakingChangeValidationPipeline.ts
 *
 * Most importantly, this function does the following:
 *
 * 1. Invokes
 *     BreakingChangeDetector.checkBreakingChangeOnSameVersion()
 *   or
 *     BreakingChangeDetector.checkCrossVersionBreakingChange(),
 *   depending on the input type.
 *
 * 2. Saves the PR context to the unified pipeline store ("pipe.log" file) in call to:
 *     oadTracer.save(context.contextConfig() as PRContext);
 *   Note that this does not save the OAD messages to the unified pipeline store.
 *   Instead, they are saved to unified pipeline store within step 1.
 *
 * 3. Adds "review required" labels to ADO pipeline variable, in call to:
 *     ruleManager.addBreakingChangeLabels(comparisonType);
 *
 * 4. Outputs full list of the OAD messages to build log for human review, in call to:
 *     logFullOadMessagesList()
 * TODO: add breaking change labels
 */
export async function detectBreakingChange(context: Context): Promise<number> {
  let statusCode: number = 0;
  const oadTracer = new OadTrace(context);
  console.log("ENTER definition detectBreakingChange");

  console.log(`PR target branch is ${context.prInfo ? context.prTargetBranch : ""}`);

  const diffs = await getSwaggerDiffs();

  console.log("Found PR changes:");
  console.log(JSON.stringify(diffs, null, 2));

  let swaggersToProcess = diffs.modifications?.concat(diffs.additions || []) as Array<string>;

  console.log("Processing swaggers:");
  console.log(swaggersToProcess);

  // 1 switch pr to base branch
  changeBaseBranch(context);
  await context.prInfo?.checkout(context.prInfo.baseBranch);

  const newSwaggers = diffs.additions || [];

  const changedSwaggers = diffs.modifications || [];

  const deletedSwaggers = diffs.deletions || [];

  const newExistingVersionDirs: string[] = [];

  const addedVersionDirs = [...newSwaggers.map((f: string) => path.dirname(f))];

  for (const f of addedVersionDirs) {
    if (existsSync(path.join(context.prInfo!.workingDir, f))) {
      newExistingVersionDirs.push(f);
    }
  }
  // new swaggers in the existing version folder
  const newExistingVersionSwaggers = newSwaggers.filter((f: string) =>
    newExistingVersionDirs.includes(path.dirname(f)),
  );
  const needCompareDeletedSwaggers: string[] = deletedSwaggers.filter((f: string) =>
    existsSync(path.join(context.prInfo!.workingDir, f)),
  );

  const newVersionSwaggers = newSwaggers.filter(
    (f: string) => !newExistingVersionDirs.includes(path.dirname(f)),
  );
  const nonExistingChangedSwaggers = changedSwaggers.filter(
    (f: string) => !existsSync(path.join(context.prInfo!.workingDir, f)),
  );
  const existingChangedSwaggers = changedSwaggers.filter(
    (f: string) => !nonExistingChangedSwaggers.includes(f),
  );
  const needCompareOldSwaggers = existingChangedSwaggers
    .concat(newExistingVersionSwaggers)
    .concat(needCompareDeletedSwaggers);

  console.log("Found new version swaggers:");
  console.log(newVersionSwaggers);

  console.log("Found new existing version swaggers:");
  console.log(newExistingVersionSwaggers);

  console.log("Found changed existing swaggers:");
  console.log(existingChangedSwaggers);

  console.log("The following changed swaggers are not existed in base branch:");
  console.log(nonExistingChangedSwaggers);

  console.log("The following are deleted swaggers that need to do the comparison: ");
  console.log(needCompareDeletedSwaggers);

  console.log(
    `Creating dummy files to compare for deleted Swagger files. Count: ${needCompareDeletedSwaggers.length}`,
  );

  // create a dummy file to compare. if the deleted file exists in base branch
  for (const f of needCompareDeletedSwaggers) {
    const baseFilePath = path.join(context.prInfo!.workingDir, f);
    if (isSameVersionBreakingType(context.runType)) {
      createDummySwagger(baseFilePath, path.resolve(f));
    }
  }

  console.log(
    `Creating dummy files to compare for new Swagger files in existing API version folders. ` +
      `Count: ${newExistingVersionSwaggers.length}`,
  );

  // create dummy swagger for new swaggers whose api version already existed before the PR.
  newExistingVersionSwaggers.forEach((f: string) => {
    const oldSwagger = path.join(context.prInfo!.workingDir, f);
    if (isSameVersionBreakingType(context.runType)) {
      createDummySwagger(path.resolve(f), oldSwagger);
    }
  });

  if (context.prInfo) {
    oadTracer.setBaseBranch(context.prInfo.baseBranch);
    const detector = new BreakingChangeDetector(context, needCompareOldSwaggers, oadTracer);

    let msgs: ResultMessageRecord[] = [];
    let runtimeErrors: RawMessageRecord[] = [];
    let oadViolationsCnt: number = 0;
    let errorCnt: number = 0;

    let comparisonType: BreakingChangesCheckType = isSameVersionBreakingType(context.runType)
      ? "SameVersion"
      : "CrossVersion";

    ({ msgs, runtimeErrors, oadViolationsCnt, errorCnt } =
      await detector.checkBreakingChangeOnSameVersion());

    oadTracer.save();
    const comparedSpecsTableContent = oadTracer.genMarkdown();
    //TODO process breaking change labels

    // If exitCode is already defined and non-zero, we do not interfere with its value here.
    if (process.exitCode === undefined || process.exitCode === 0) {
      // This exitCode determines if the relevant GitHub breaking change check
      // will fail. We want for it to fail only if:
      //
      // Case 1: there was at least one label added denoting breaking change issue, as declared by oadMessagesRuleMap.ts
      //
      // OR
      //
      // Case 2: there was at least one runtime error that is not a warning.
      //
      // Notably, we want for the exitCode to remain 0, denoting success, in following cases:
      // - If there are messages from OAD (openapi-diff) denoting violations, but none
      //   of them resulted in adding any breaking changes labels.
      //   This is why we do not include 'oadViolationsCnt' in this formula at all.
      //   Instead, we rely on 'labelsAddedCount'.
      //   See https://github.com/Azure/azure-sdk-tools/issues/6396
      // - If there are errors, but they are only warning-level. This happens when comparing
      //   to previous preview version. In such cases, these errors are not included in the 'errorCnt' at all.
      //process.exitCode = labelsAddedCount > 0 || errorCnt > 0 ? 1 : 0;
      process.exitCode = errorCnt > 0 ? 1 : 0;
    }

    console.log(
      `detectBreakingChange: prUrl: ${context.prUrl}, ` +
        `comparisonType: ${comparisonType}, labelsAddedCount: , ` +
        `errorCnt: ${errorCnt}, oadViolationsCnt: ${oadViolationsCnt}, ` +
        `process.exitCode: ${process.exitCode}`,
    );

    if (process.exitCode === 0 && oadViolationsCnt > 0) {
      // We are using this log as a metric to track and measure impact of the work on improving "breaking changes" tooling. Log statement added around 2/22/2024.
      // See: https://github.com/Azure/azure-sdk-tools/issues/7223#issuecomment-1839830834
      console.log(
        `detectBreakingChange: ` +
          `Prevented spurious failure of breaking change check. prUrl: ${context.prUrl}, ` +
          `comparisonType: ${comparisonType}, oadViolationsCnt: ${oadViolationsCnt}, ` +
          `process.exitCode: ${process.exitCode}.`,
      );
    }
    if (oadViolationsCnt > 0 || errorCnt > 0) {
      // set statusCode to 1 if there are any OAD violations(errors) or runtime errors occurred.
      statusCode = 1;
    }

    logFullOadMessagesList(msgs);
    await generateBreakingChangeResultSummary(
      context,
      msgs,
      runtimeErrors,
      comparedSpecsTableContent,
      "",
      statusCode,
    );
    /*
    generateJunitReport(
      !isSameVersionBreakingType(type) ? "CrossVersionBreakingChange" : "BreakingChange",
    );*/
  } else {
    console.log("!pr. Skipping the process of breaking change detection.");
  }

  console.log(`Cleaning up dummy files. Count: ${createdDummySwagger.length}`);

  cleanDummySwagger();

  console.log("RETURN definition detectBreakingChange");

  return statusCode;
}

const whitelistsBranches = ["ARMCoreRPDev", "rpsaasmaster"];

function changeBaseBranch(context: Context) {
  /*
   * always compare against main
   * we still use the changed files got from the PR, because the main branch may quite different with the PR target branch
   */
  function isBreakingChangeWhiteListBranch() {
    return (
      isSameVersionBreakingType(context.runType) &&
      whitelistsBranches.some((b) => context.prTargetBranch.toLowerCase() === b.toLowerCase())
    );
  }
  // same version breaking change for PR targets to rpaas or armCoreRpDev, will compare with the original target branch.
  if (context.baseBranch !== context.prTargetBranch && !isBreakingChangeWhiteListBranch()) {
    context.prInfo!.baseBranch = context.baseBranch;
    console.log(`switch target branch to ${context.baseBranch}`);
  }
}

function logFullOadMessagesList(msgs: ResultMessageRecord[]) {
  console.log("---- Full list of messages ----");
  console.log("[");
  // Printing the messages one by one because the console.log appears to elide the messages with "... X more items"
  // after approximately 292 messages.
  for (const msg of msgs) {
    console.log(JSON.stringify(msg, null, 4) + ",");
  }
  console.log("]");
  console.log("---- End of full list of messages ----");
}

const createdDummySwagger: string[] = [];

function createDummySwagger(fromSwagger: string, toSwagger: string) {
  if (!existsSync(path.dirname(toSwagger))) {
    mkdirSync(path.dirname(toSwagger), { recursive: true });
  }
  const content = readFileSync(fromSwagger).toString();
  const swaggerJson = JSON.parse(content);
  swaggerJson.paths = {};
  if (swaggerJson["x-ms-paths"]) {
    swaggerJson["x-ms-paths"] = {};
  }
  if (swaggerJson["x-ms-parameterized-host"]) {
    delete swaggerJson["x-ms-parameterized-host"];
  }
  swaggerJson.parameters = {};
  swaggerJson.definitions = {};
  writeFileSync(toSwagger, JSON.stringify(swaggerJson, null, 2));
  createdDummySwagger.push(toSwagger);
  console.log(`created a dummpy swagger:${toSwagger} from ${fromSwagger}`);
}

function cleanDummySwagger() {
  for (const swagger of createdDummySwagger) {
    rmSync(swagger, { recursive: true, force: true });
  }
}

// return true if the type indicates the same version breaking change
function isSameVersionBreakingType(type: BreakingChangesCheckType) {
  return type === "SameVersion";
}
