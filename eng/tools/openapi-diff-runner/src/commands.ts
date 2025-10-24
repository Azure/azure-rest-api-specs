/**
 * In the "breakingChanges directory invocation depth" this file has depth 1,
 * i.e. it is invoked by files with depth 0 and invokes files with depth 2.
 */

import { BREAKING_CHANGES_CHECK_TYPES } from "@azure-tools/specs-shared/breaking-change";
import { existsSync } from "node:fs";
import * as path from "node:path";
import {
  changeBaseBranch,
  cleanDummySwagger,
  createDummySwagger,
  getCreatedDummySwaggerCount,
  getSwaggerDiffs,
  isSameVersionBreakingType,
  logFullOadMessagesList,
  outputBreakingChangeLabelVariables,
} from "./command-helpers.js";
import {
  checkBreakingChangeOnSameVersion,
  checkCrossVersionBreakingChange,
  createBreakingChangeDetectionContext,
} from "./detect-breaking-change.js";
import { generateBreakingChangeResultSummary } from "./generate-report.js";
import { LOG_PREFIX, logMessage } from "./log.js";
import { Context } from "./types/breaking-change.js";
import { RawMessageRecord, ResultMessageRecord } from "./types/message.js";
import { createOadTrace, generateOadMarkdown, setOadBaseBranch } from "./types/oad-types.js";
import { checkPrTargetsProductionBranch } from "./utils/common-utils.js";
import { appendMarkdownToLog } from "./utils/oad-message-processor.js";

/**
 * The function validateBreakingChange() is executed with type SameVersion or CrossVersion
 *
 * Most importantly, this function does the following:
 *
 * 1. Invokes
 *     detect-breaking-change.checkBreakingChangeOnSameVersion()
 *   or
 *     detect-breaking-change.checkCrossVersionBreakingChange(),
 *   depending on the input type.
 *
 * 2. Gernerate markdown report
 *
 * 3. Compute "review required" labels to be added in the PR in call to:
 *     ruleManager.addBreakingChangeLabelsToBeAdded(comparisonType);
 *
 * 4. Outputs full list of the OAD messages to build log for human review,
 */
export async function validateBreakingChange(context: Context): Promise<number> {
  let statusCode: number = 0;
  let oadTracer = createOadTrace(context);
  logMessage("ENTER definition validateBreakingChange");

  logMessage(`PR target branch is ${context.prInfo ? context.prTargetBranch : ""}`);

  const diffs = await getSwaggerDiffs();

  logMessage("Found PR changes:");
  logMessage(JSON.stringify(diffs, null, 2));

  let swaggersToProcess = diffs.modifications?.concat(diffs.additions || []) as Array<string>;

  logMessage("Processing swaggers:");
  logMessage(JSON.stringify(swaggersToProcess, null, 2));

  // switch pr to base branch
  changeBaseBranch(context);
  await context.prInfo?.checkout(context.prInfo.baseBranch);
  oadTracer = setOadBaseBranch(oadTracer, context.prInfo?.baseBranch || context.baseBranch);

  const newSwaggers = diffs.additions || [];

  const changedSwaggers = diffs.modifications || [];

  const deletedSwaggers = diffs.deletions || [];

  const newExistingVersionDirs: string[] = [];

  const addedVersionDirs = [...newSwaggers.map((f: string) => path.dirname(f))];

  for (const f of addedVersionDirs) {
    if (existsSync(path.join(context.prInfo!.tempRepoFolder, f))) {
      newExistingVersionDirs.push(f);
    }
  }
  // new swaggers in the existing version folder
  const newExistingVersionSwaggers = newSwaggers.filter((f: string) =>
    newExistingVersionDirs.includes(path.dirname(f)),
  );
  const needCompareDeletedSwaggers: string[] = deletedSwaggers.filter((f: string) =>
    existsSync(path.join(context.prInfo!.tempRepoFolder, f)),
  );

  // new swaggers in the new version folder
  const newVersionSwaggers = newSwaggers.filter(
    (f: string) => !newExistingVersionDirs.includes(path.dirname(f)),
  );
  // new swaggers in the new version folder that have changed
  const newVersionChangedSwaggers = changedSwaggers.filter(
    (f: string) => !existsSync(path.join(context.prInfo!.tempRepoFolder, f)),
  );
  // existing swaggers that have changed
  const existingChangedSwaggers = changedSwaggers.filter(
    (f: string) => !newVersionChangedSwaggers.includes(f),
  );
  // swaggers that are in the existing version directories that have changed or deleted or
  // newly added in the existing version directories
  const needCompareOldSwaggers = existingChangedSwaggers
    .concat(newExistingVersionSwaggers)
    .concat(needCompareDeletedSwaggers);

  logMessage("Found new version swaggers:");
  logMessage(JSON.stringify(newVersionSwaggers, null, 2));

  logMessage("Found new existing version swaggers:");
  logMessage(JSON.stringify(newExistingVersionSwaggers, null, 2));

  logMessage("Found changed existing swaggers:");
  logMessage(JSON.stringify(existingChangedSwaggers, null, 2));

  logMessage("The following changed swaggers are not existed in base branch:");
  logMessage(JSON.stringify(newVersionChangedSwaggers, null, 2));

  logMessage("The following are deleted swaggers that need to do the comparison: ");
  logMessage(JSON.stringify(needCompareDeletedSwaggers, null, 2));

  logMessage(
    `Creating dummy files to compare for deleted Swagger files. Count: ${needCompareDeletedSwaggers.length}`,
  );

  // create a dummy file to compare. if the deleted file exists in base branch
  for (const f of needCompareDeletedSwaggers) {
    const baseFilePath = path.join(context.prInfo!.tempRepoFolder, f);
    if (isSameVersionBreakingType(context.runType)) {
      createDummySwagger(baseFilePath, path.resolve(f));
    }
  }

  logMessage(
    `Creating dummy files to compare for new Swagger files in existing API version folders. ` +
      `Count: ${newExistingVersionSwaggers.length}`,
  );

  // create dummy swagger for new swaggers whose api version already existed before the PR.
  newExistingVersionSwaggers.forEach((f: string) => {
    const oldSwagger = path.join(context.prInfo!.tempRepoFolder, f);
    if (isSameVersionBreakingType(context.runType)) {
      createDummySwagger(path.resolve(f), oldSwagger);
    }
  });

  if (context.prInfo) {
    const detectionContext = createBreakingChangeDetectionContext(
      context,
      needCompareOldSwaggers,
      newVersionSwaggers,
      newVersionChangedSwaggers,
      oadTracer,
    );

    let msgs: ResultMessageRecord[] = [];
    let runtimeErrors: RawMessageRecord[] = [];
    let oadViolationsCnt: number = 0;
    let errorCnt: number = 0;

    if (context.runType === BREAKING_CHANGES_CHECK_TYPES.SAME_VERSION) {
      ({ msgs, runtimeErrors, oadViolationsCnt, errorCnt } =
        await checkBreakingChangeOnSameVersion(detectionContext));
    } else {
      ({ msgs, runtimeErrors, oadViolationsCnt, errorCnt } =
        await checkCrossVersionBreakingChange(detectionContext));
    }
    const comparedSpecsTableContent = await generateOadMarkdown(detectionContext.oadTracer);

    // Log the markdown content to the pipeline log file
    if (comparedSpecsTableContent) {
      appendMarkdownToLog(context.oadMessageProcessorContext, comparedSpecsTableContent);
    }

    // output breaking change label variables only when the PR targets a production branch
    logMessage(
      `Evaluate breaking change labels: targetRepo: ${context.targetRepo}, ` +
        `targetBranch: ${context.prInfo!.targetBranch}`,
    );
    if (checkPrTargetsProductionBranch(context.targetRepo, context.prInfo!.targetBranch)) {
      outputBreakingChangeLabelVariables();
    }

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
      // - If there are errors, but they are only warning-level. This happens when comparing
      //   to previous preview version. In such cases, these errors are not included in the 'errorCnt' at all.
      process.exitCode = errorCnt > 0 ? 1 : 0;
    }

    logMessage(
      `${LOG_PREFIX}validateBreakingChange: prUrl: ${context.prUrl}, ` +
        `comparisonType: ${context.runType},` +
        `errorCnt: ${errorCnt}, oadViolationsCnt: ${oadViolationsCnt}, ` +
        `process.exitCode: ${process.exitCode}`,
    );

    if (process.exitCode === 0 && oadViolationsCnt > 0) {
      // We are using this log as a metric to track and measure impact of the work on improving "breaking changes" tooling. Log statement added around 2/22/2024.
      // See: https://github.com/Azure/azure-sdk-tools/issues/7223#issuecomment-1839830834
      logMessage(
        `${LOG_PREFIX}validateBreakingChange: ` +
          `Prevented spurious failure of breaking change check. prUrl: ${context.prUrl}, ` +
          `comparisonType: ${context.runType}, oadViolationsCnt: ${oadViolationsCnt}, ` +
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
    );
  } else {
    logMessage("!pr. Skipping the process of breaking change detection.");
  }

  logMessage(`Cleaning up dummy files. Count: ${getCreatedDummySwaggerCount()}`);

  cleanDummySwagger();

  logMessage("RETURN definition validateBreakingChange");
  logMessage(`${LOG_PREFIX}validateBreakingChange: statusCode: ${statusCode}`);
  return statusCode;
}
