/**
 * By design, the members exported from this file are functional breaking change detection utilities.
 *
 * In the "breakingChanges directory invocation depth" this fil    if (previousSt    if (previousPreview) {
      const { oadViolationsCnt, errorCnt } = await doBreakingChangeDetection(
        detectionContext,
        path.resolve(detectionContext.context.prInfo!.tempRepoFolder, swaggerPath),
        swaggerPath,
        BREAKING_CHANGES_CHECK_TYPES.CROSS_VERSION,
        "preview",
      );      const { oadViolationsCnt, errorCnt } = await doBreakingChangeDetection(
        detectionContext,
        path.resolve(detectionContext.context.prInfo!.tempRepoFolder, swaggerPath),
        swaggerPath,
        BREAKING_CHANGES_CHECK_TYPES.CROSS_VERSION,
        "stable",
      );pth 2,
 * i.e. it is invoked by files with depth 1 and invokes files with depth 3.
 */
import { BREAKING_CHANGES_CHECK_TYPES } from "@azure-tools/specs-shared/breaking-change";
import { SpecModel } from "@azure-tools/specs-shared/spec-model";
import { appendFileSync, existsSync } from "node:fs";
import * as path from "node:path";
import { logError, LogLevel, logMessage } from "./log.js";
import { runOad } from "./run-oad.js";
import {
  ApiVersionLifecycleStage,
  BreakingChangesCheckType,
  Context,
  logFileName,
} from "./types/breaking-change.js";
import { RawMessageRecord, ResultMessageRecord } from "./types/message.js";
import { addOadTrace, OadMessage, OadTraceData } from "./types/oad-types.js";
import { applyRules } from "./utils/apply-rules.js";
import {
  blobHref,
  branchHref,
  convertRawErrorToUnifiedMsg,
  getRelativeSwaggerPathToRepo,
  processOadRuntimeErrorMessage,
  specIsPreview,
} from "./utils/common-utils.js";
import { processAndAppendOadMessages } from "./utils/oad-message-processor.js";
import {
  deduplicateSwaggers,
  getExistedVersionOperations,
  getPrecedingSwaggers,
} from "./utils/spec.js";

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
  existingVersionSwaggers: string[]; // Files in existing API version directories
  newVersionSwaggers: string[]; // Files in completely new API version directories
  newVersionChangedSwaggers: string[]; // Files in existing API version directories that have changed
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
  existingVersionSwaggers: string[],
  newVersionSwaggers: string[],
  newVersionChangedSwaggers: string[],
  oadTracer: OadTraceData,
): BreakingChangeDetectionContext {
  return {
    context,
    existingVersionSwaggers,
    newVersionSwaggers,
    newVersionChangedSwaggers,
    oadTracer,
    msgs: [],
    runtimeErrors: [],
    tempTagName: "oad-default-tag",
  };
}

/**
 * The entry points for breaking change detection are:
 * - checkBreakingChangeOnSameVersion()
 * - checkCrossVersionBreakingChange()
 * both of which are invoked by the function commands.ts / validateBreakingChange()
 */

/** The function checkBreakingChangeOnSameVersion()
 * maps to the lower "Same-version check" rectangle at:
 * https://aka.ms/azsdk/pr-brch-deep#diagram-explaining-breaking-changes-and-versioning-issues
 *
 * This function is called by the function commands.ts / validateBreakingChange()
 * This function calls doBreakingChangeDetection with appropriate "type" and other parameters.
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

  for (const swaggerPath of detectionContext.existingVersionSwaggers) {
    logMessage(`Processing swaggerPath: ${swaggerPath}`, LogLevel.Group);
    const { oadViolationsCnt, errorCnt } = await doBreakingChangeDetection(
      detectionContext,
      path.resolve(detectionContext.context.prInfo!.tempRepoFolder, swaggerPath),
      swaggerPath,
      BREAKING_CHANGES_CHECK_TYPES.SAME_VERSION,
      specIsPreview(swaggerPath)
        ? ApiVersionLifecycleStage.PREVIEW
        : ApiVersionLifecycleStage.STABLE,
    );
    aggregateOadViolationsCnt += oadViolationsCnt;
    aggregateErrorCnt += errorCnt;
    logMessage("Processing completed", LogLevel.EndGroup);
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

/** The function checkCrossVersionBreakingChange()
 * maps to the upper "Cross-version check" rectangle at:
 * https://aka.ms/azsdk/pr-brch-deep#diagram-explaining-breaking-changes-and-versioning-issues
 *
 * This function is called by the function commands.ts / validateBreakingChange()
 * This function calls this.doBreakingChangeDetection with appropriate "type" and other parameters.
 */
export async function checkCrossVersionBreakingChange(
  detectionContext: BreakingChangeDetectionContext,
): Promise<{
  msgs: ResultMessageRecord[];
  runtimeErrors: RawMessageRecord[];
  oadViolationsCnt: number;
  errorCnt: number;
}> {
  logMessage(`ENTER definition checkCrossVersionBreakingChange`);

  let aggregateOadViolationsCnt = 0;
  let aggregateErrorCnt = 0;
  for (const swaggerPath of detectionContext.newVersionSwaggers
    .concat(detectionContext.newVersionChangedSwaggers)
    .concat(detectionContext.existingVersionSwaggers.filter(isInDevFolder))) {
    logMessage(`Processing swaggerPath: ${swaggerPath}`, LogLevel.Group);

    // use the detectionContext.context.localSpecRepoPath to resolve the absolute path as it's the merge commit working directory
    const absoluteSwaggerPath = path.resolve(
      detectionContext.context.localSpecRepoPath,
      swaggerPath,
    );
    logMessage(`checkCrossVersionBreakingChange: absoluteSwaggerPath: ${absoluteSwaggerPath}`);
    const specModel = await getSpecModel(
      detectionContext.context.prInfo!.tempRepoFolder,
      swaggerPath,
    );

    // If the specModel is not found, it means the swaggerPath is a new RP
    if (!specModel) {
      continue;
    }

    const originalReturnedSwaggers = await specModel.getSwaggers();
    const availableSwaggers = deduplicateSwaggers(originalReturnedSwaggers);
    logMessage(
      `checkCrossVersionBreakingChange: swaggerPath: ${swaggerPath}, availableSwaggers.length: ${availableSwaggers?.length}`,
    );

    // use absoluteSwaggerPath as it will need to it will fall back to use the version info in the swagger content
    const previousVersions = await getPrecedingSwaggers(absoluteSwaggerPath, availableSwaggers);
    logMessage(
      `checkCrossVersionBreakingChange: previousVersions: ${JSON.stringify(previousVersions)}`,
    );
    const previousStableSwaggerPath = previousVersions.stable;
    const previousPreviewSwaggerPath = previousVersions.preview;
    if (previousStableSwaggerPath) {
      const { oadViolationsCnt, errorCnt } = await doBreakingChangeDetection(
        detectionContext,
        path.resolve(detectionContext.context.prInfo!.tempRepoFolder, previousStableSwaggerPath),
        swaggerPath,
        BREAKING_CHANGES_CHECK_TYPES.CROSS_VERSION,
        ApiVersionLifecycleStage.STABLE,
      );
      aggregateOadViolationsCnt += oadViolationsCnt;
      aggregateErrorCnt += errorCnt;
    }
    if (previousPreviewSwaggerPath) {
      const { oadViolationsCnt, errorCnt } = await doBreakingChangeDetection(
        detectionContext,
        path.resolve(detectionContext.context.prInfo!.tempRepoFolder, previousPreviewSwaggerPath),
        swaggerPath,
        BREAKING_CHANGES_CHECK_TYPES.CROSS_VERSION,
        ApiVersionLifecycleStage.PREVIEW,
      );
      aggregateErrorCnt += errorCnt;
      // This code block is commented out because we are purposefully ignoring errorCnt here,
      // not adding them to aggregateErrorCnt,
      // as they originate from cross-version comparison with a preview version.
      //
      // Comparison to previous preview version must never cause the breaking change process to report failure, per:
      // - https://github.com/Azure/azure-sdk-tools/issues/6396
      //
      // Contrast this with same-version API breaking changes detection on a preview version, which still produces
      // errors/failures.
      //
      // aggregateErrorCnt += errorCnt;

      // There is no need to ignore oadViolationsCnt here, as it is expected to be zero, due
      // to applyRules.ts / applyRule() function downgrading the severity of all "Error" messages.
      aggregateOadViolationsCnt += oadViolationsCnt;
    }
    if (!previousStableSwaggerPath && !previousPreviewSwaggerPath) {
      await checkAPIsBeingMovedToANewSpec(detectionContext.context, swaggerPath, availableSwaggers);
    }
    logMessage("Processing completed", LogLevel.EndGroup);
  }
  logMessage(
    `RETURN definition checkCrossVersionBreakingChange. ` +
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
    const oadMessages = await runOad(oldSpec, newSpec);

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
      detectionContext.context,
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
        new: blobHref(
          detectionContext.context.sourceRepo,
          detectionContext.context.headCommit,
          getRelativeSwaggerPathToRepo(newSpec),
        ),
        old: branchHref(
          detectionContext.context.targetRepo,
          getRelativeSwaggerPathToRepo(oldSpec),
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

export function isInDevFolder(swaggerPath: string) {
  return swaggerPath.startsWith("dev/");
}

/**
 * Find the path to the closest readme.md file based on the input file path,
 * searching upward from the file's directory up to the 'resource-manager' or 'data-plane' sub path.
 * Example:
 * input: specification/network/resource-manager/Microsoft.Network/stable/2019-11-01/network.json
 * returns: path to the directory containing the closest readme.md file, up to specification/network/resource-manager
 */
export function getReadmeFolder(swaggerFile: string) {
  const segments = swaggerFile.split(/\\|\//);

  if (!segments || segments.length < 3) {
    return undefined;
  }

  // Handle dev folder conversion
  if (segments[0] === "dev") {
    segments[0] = "specification";
  }

  // Find the boundary index (resource-manager or data-plane)
  const resourceManagerIndex = segments.findIndex((segment) => segment === "resource-manager");
  const dataPlaneIndex = segments.findIndex((segment) => segment === "data-plane");
  const boundaryIndex = resourceManagerIndex !== -1 ? resourceManagerIndex : dataPlaneIndex;

  // Determine search range: from file's parent directory up to boundary (or root if no boundary found)
  const startIndex = segments.length - 2; // Start from parent directory of the file
  const minIndex = boundaryIndex !== -1 ? boundaryIndex : 2; // Stop at boundary or at least keep first 3 segments

  // Search upward for readme.md
  for (let i = startIndex; i >= minIndex; i--) {
    const currentPath = segments.slice(0, i + 1).join(path.sep);
    const readmePath = path.join(currentPath, "readme.md");

    if (existsSync(readmePath)) {
      return currentPath;
    }
  }

  // Fallback: return up to boundary if found, otherwise first 3 segments
  if (boundaryIndex !== -1) {
    return segments.slice(0, boundaryIndex + 1).join(path.sep);
  }

  return segments.slice(0, 3).join(path.sep);
}

/**
 * Get or create a SpecModel for the given swagger path.
 * Uses caching to avoid redundant SpecModel initialization for the same folder.
 * @param specRepoFolder - The root folder of the spec repository
 * @param swaggerPath - Path to the swagger file
 * @returns SpecModel instance for the folder containing the swagger file or undefined if the folder does not exist
 */
export function getSpecModel(specRepoFolder: string, swaggerPath: string): SpecModel | undefined {
  const folder = getReadmeFolder(swaggerPath);

  if (!folder) {
    throw new Error(`Could not determine readme folder for swagger path: ${swaggerPath}`);
  }

  let isNewRp = false;
  let fullFolderPath = path.join(specRepoFolder, folder);
  if (!existsSync(fullFolderPath)) {
    isNewRp = true;
  }

  // If the initial folder doesn't exist, search upward for a folder with readme.md
  while (
    isNewRp &&
    !fullFolderPath.endsWith("resource-manager") &&
    !fullFolderPath.endsWith("data-plane")
  ) {
    const parent = path.dirname(fullFolderPath);

    // Prevent infinite loop if we reach the root
    if (parent === fullFolderPath) {
      break;
    }

    fullFolderPath = parent;
    const readmePath = path.join(fullFolderPath, "readme.md");

    // If we find a readme.md, use this folder
    if (existsSync(readmePath)) {
      isNewRp = false;
      break;
    }
  }

  // Return if the readme folder is not found which means it's a new RP
  if (isNewRp) {
    logMessage(
      `getSpecModel: this is a new RP as ${fullFolderPath} folder does not exist in the base branch of spec repo.`,
    );
    return undefined;
  }
  logMessage(`getSpecModel: folder: ${fullFolderPath}, swaggerPath: ${swaggerPath}`);

  // Create new SpecModel and cache it
  const specModel = new SpecModel(fullFolderPath);

  return specModel;
}

export async function checkAPIsBeingMovedToANewSpec(
  context: Context,
  swaggerPath: string,
  availableSwaggers: any[],
) {
  const absoluteSwaggerPath = path.resolve(context.localSpecRepoPath, swaggerPath);
  logMessage(`checkAPIsBeingMovedToANewSpec: absoluteSwaggerPath: ${absoluteSwaggerPath}`);
  const specModel = getSpecModel(context.localSpecRepoPath, swaggerPath);
  if (!specModel) {
    return;
  }
  const swaggersFromOriginalClonedRepo = await specModel.getSwaggers();
  const targetSwagger = swaggersFromOriginalClonedRepo.find((s) => s.path === absoluteSwaggerPath);
  if (!targetSwagger) {
    logError(
      `checkAPIsBeingMovedToANewSpec: targetSwagger not found for swaggerPath: ${swaggerPath}`,
    );
    return;
  }
  const targetOperations = await targetSwagger.getOperations();

  // use absoluteSwaggerPath as it will need to it will fall back to use the version info in the swagger content
  const movedApis = await getExistedVersionOperations(absoluteSwaggerPath, availableSwaggers, [
    ...targetOperations.values(),
  ]);
  logMessage(
    `checkAPIsBeingMovedToANewSpec: swaggerPath: ${swaggerPath}, movedApis.size: ${movedApis.size}`,
  );
  if (movedApis.size > 0) {
    logMessage(
      `The swagger ${swaggerPath} has no previous version being found, but its APIs were found in other swaggers. It means that you are moving some APIs to this new swagger file.`,
    );
    for (const [swaggerFile, operations] of movedApis) {
      const operationIds = operations.map((op: any) => op.id).join(",");
      appendFileSync(
        logFileName,
        convertRawErrorToUnifiedMsg(
          context,
          "APIsBeingMovedToANewSpec",
          "Attention: There are some existing APIs currently documented in a new spec file. The validation may not be able to report breaking changes with these APIs. It is recommended not to rename swagger file or move public APIs to a new file when creating a new API version." +
            ` The existing APIs being moved are: ${operationIds};`,
          "Warning",
          swaggerFile,
        ),
      );
      logMessage(`The following are details for existing APIs being moved to the new spec:`);
      logMessage(`  swagger file: ${swaggerFile}, operationIds: ${operationIds}\n`);
    }
  }
}
