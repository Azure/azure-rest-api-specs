/**
 * By design, the members exported from this file are functional breaking change detection utilities.
 *
 * In the "breakingChanges directory invocation depth" this file has depth 2,
 * i.e. it is invoked by files with depth 1 and invokes files with depth 3.
 */
import {
  ApiVersionLifecycleStage,
  BreakingChangesCheckType,
  Context,
} from "./types/breaking-change.js";
import { logFileName } from "./utils/breaking-change-config.js";
import { RawMessageRecord, ResultMessageRecord } from "./types/message.js";
import {
  blobHref,
  branchHref,
  getRelativeSwaggerPathToRepo,
  processOadRuntimeErrorMessage,
  specIsPreview,
} from "./utils/common-utils.js";
import { appendFileSync } from "node:fs";
import * as path from "path";
import { applyRules } from "./utils/apply-rules.js";
import { OadMessage, OadTraceData, addOadTrace } from "./types/oad-types.js";
import { runOad } from "./run-oad.js";
import { processAndAppendOadMessages } from "./utils/oad-message-processor.js";
import { logError, logMessage } from "./log.js";

// We want to display some lines as we improved AutoRest v2 error output since March 2024 to provide multi-line error messages, e.g.:
// https://github.com/Azure/autorest/pull/4934
// For console (diagnostic) logs we want to display the entire stack trace.
// The value here is an arbitrary high number to limit the stack trace in case a bug would cause it to be excessively long.
const stackTraceMaxLength = 500;

/**
 * Context for breaking change detection operations
 */
export interface BreakingChangeDetectionContext {
  context: Context;
  oldSwaggers: string[];
  oadTracer: OadTraceData;
  msgs: ResultMessageRecord[];
  runtimeErrors: RawMessageRecord[];
  tempTagName: string;
}

/**
 * Create a new breaking change detection context
 */
export function createBreakingChangeDetectionContext(
  context: Context,
  oldSwaggers: string[],
  oadTracer: OadTraceData,
): BreakingChangeDetectionContext {
  return {
    context,
    oldSwaggers,
    oadTracer,
    msgs: [],
    runtimeErrors: [],
    tempTagName: "oad-default-tag",
  };
}

/**
 * The entry points for breaking change detection are:
 * - checkBreakingChangeOnSameVersion()
 * - checkCrossVersionBreakingChange() (TODO: implement)
 * both of which are invoked by the function commands.ts / validateBreakingChange()
 * TODO migrate swaggerVersionManager to support cross-version checks
 */

/** The function checkBreakingChangeOnSameVersion()
 * maps to the lower "Same-version check" rectangle at:
 * https://aka.ms/azsdk/pr-brch-deep#diagram-explaining-breaking-changes-and-versioning-issues
 *
 * This function is called by the function commands.ts / validateBreakingChange()
 * This function calls doBreakingChangeDetection with appropriate "type" and "isCrossVersion" parameters.
 */
export async function checkBreakingChangeOnSameVersion(
  detectionContext: BreakingChangeDetectionContext,
): Promise<{
  msgs: ResultMessageRecord[];
  runtimeErrors: RawMessageRecord[];
  oadViolationsCnt: number;
  errorCnt: number;
}> {
  logMessage(`ENTER definition checkBreakingChangeOnSameVersion`);

  let aggregateOadViolationsCnt = 0;
  let aggregateErrorCnt = 0;

  for (const swaggerJson of detectionContext.oldSwaggers) {
    const { oadViolationsCnt, errorCnt } = await doBreakingChangeDetection(
      detectionContext,
      path.resolve(detectionContext.context.prInfo!.workingDir, swaggerJson),
      swaggerJson,
      "SameVersion",
      specIsPreview(swaggerJson) ? "preview" : "stable",
    );
    aggregateOadViolationsCnt += oadViolationsCnt;
    aggregateErrorCnt += errorCnt;
  }

  logMessage(
    `RETURN definition checkBreakingChangeOnSameVersion. ` +
      `msgs.length: ${detectionContext.msgs.length}, ` +
      `aggregateOadViolationsCnt: ${aggregateOadViolationsCnt}, aggregateErrorCnt: ${aggregateErrorCnt}`,
  );

  return {
    msgs: detectionContext.msgs,
    runtimeErrors: detectionContext.runtimeErrors,
    oadViolationsCnt: aggregateOadViolationsCnt,
    errorCnt: aggregateErrorCnt,
  };
}

/**
 * The function doBreakingChangeDetection()
 * is called by
 *
 * - checkBreakingChangeOnSameVersion()
 * - or checkCrossVersionBreakingChange()
 *
 * with appropriate options.
 *
 * Most importantly, this function does the following:
 *
 * 1. Invokes "@azure/oad" via call to runOad() to obtain OadMessage[] collection.
 *
 * 2. It post-processes the OadMessage[] collection by calling
 *    applyRules() function
 *
 *    which uses the oadMessagesRuleMap.ts config to schedule
 *    appropriate "review required" labels to be added downstream by doBreakingChangeDetection() calling addBreakingChangeLabelsToBeAdded()
 *    as well as updates the OAD messages severity.
 *
 * 3. It saves the OadMessage[] collection to the unified pipeline store ("pipe.log" file) in call to:
 *    processAndAppendOadMessages()
 *
 * 4. It saves OAD errors, if any, to the unified pipeline store ("pipe.log" file) in call to:
 *    appendOadRuntimeErrors()
 */
export async function doBreakingChangeDetection(
  detectionContext: BreakingChangeDetectionContext,
  oldSpec: string,
  newSpec: string,
  scenario: BreakingChangesCheckType,
  previousApiVersionLifecycleStage: ApiVersionLifecycleStage,
): Promise<{ oadViolationsCnt: number; errorCnt: number }> {
  logMessage(`ENTER definition doBreakingChangeDetection oldSpec: ${oldSpec}, newSpec: ${newSpec}`);

  let oadViolationsCnt = 0;
  let errorCnt = 0;

  try {
    await detectionContext.context.prInfo!.checkout(detectionContext.context.prInfo!.baseBranch);
    const oadMessages = await runOad(
      path.resolve(detectionContext.context.localSpecRepoPath, oldSpec),
      newSpec,
    );

    // Handle tracing separately - no need for a trace of two tags comparison
    detectionContext.oadTracer = addOadTrace(
      detectionContext.oadTracer,
      getRelativeSwaggerPathToRepo(oldSpec),
      newSpec,
    );

    const modifiedOadMessages: OadMessage[] = applyRules(
      oadMessages,
      scenario,
      previousApiVersionLifecycleStage,
    );

    oadViolationsCnt += modifiedOadMessages.filter(
      (oadMessage) => oadMessage.type === "Error",
    ).length;

    const msgs: ResultMessageRecord[] = processAndAppendOadMessages(
      detectionContext.context.oadMessageProcessorContext,
      modifiedOadMessages,
      detectionContext.context.baseBranch,
    );
    detectionContext.msgs = detectionContext.msgs.concat(msgs);
  } catch (e) {
    const error = e instanceof Error ? e : new Error(String(e));
    const runtimeError: RawMessageRecord = {
      type: "Raw",
      level: "Error",
      message: "Runtime Exception",
      time: new Date(),
      groupName: previousApiVersionLifecycleStage,
      extra: {
        new: blobHref(getRelativeSwaggerPathToRepo(newSpec)),
        old: branchHref(
          getRelativeSwaggerPathToRepo(
            path.resolve(detectionContext.context.localSpecRepoPath, oldSpec),
          ),
          detectionContext.context.baseBranch,
        ),
        details: processOadRuntimeErrorMessage(error.message, stackTraceMaxLength),
      },
    };
    detectionContext.runtimeErrors.push(runtimeError);
    errorCnt += 1;
    appendFileSync(logFileName, JSON.stringify(runtimeError) + "\n");
    logError(`appendOadRuntimeErrors: ${JSON.stringify(runtimeError)}`);
  }

  logMessage(
    `RETURN definition doBreakingChangeDetection ` +
      `scenario: ${scenario}, ` +
      `previousApiVersionLifecycleStage: ${previousApiVersionLifecycleStage}, ` +
      `oldSpec: ${oldSpec}, newSpec: ${newSpec}, ` +
      `oadViolationsCnt: ${oadViolationsCnt}, errorCnt: ${errorCnt}`,
  );

  return { oadViolationsCnt, errorCnt };
}
