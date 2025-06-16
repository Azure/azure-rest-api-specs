/**
 * By design, the only member exported from this file is the BreakingChangeDetector class.
 *
 * In the "breakingChanges directory invocation depth" this file has depth 2,
 * i.e. it is invoked by files with depth 1 and invokes files with depth 3.
 */
import {
  ApiVersionLifecycleStage,
  BreakingChangesCheckType,
  Context,
  logFileName,
} from "./types/breaking-change-check.js";
import { MessageLine, ResultMessageRecord } from "./types/message.js";
import { blobHref, branchHref, cutoffMsg, getRelativeSwaggerPathToRepo } from "./utils.js";
import { appendFileSync } from "node:fs";
import _ from "lodash";
import * as path from "path";
import { applyRules } from "./apply-rules.js";
import { OadMessage, OadTrace } from "./types/oad-types.js";
import { runOad } from "./run-oad.js";
import { Logger } from "./logger.js";

/**
 * The entry points of the class BreakingChangeDetector are
 * - checkBreakingChangeOnSameVersion()
 * - checkCrossVersionBreakingChange()
 * both of which are invoked by the function detectBreakingChange.ts / detectBreakingChange()
 */
export class BreakingChangeDetector {
  //versionManager: SwaggerVersionManager = new SwaggerVersionManager();
  logger: Logger;
  context: Context;
  errors: Map<[string, string], RuntimeError[]>;
  tempTagName = "oad-default-tag";
  oadTracer: OadTrace;
  private msgs: ResultMessageRecord[] = [];

  constructor(
    private context: Context,
    private newSwaggers: string[],
    private oldSwaggers: string[],
    private changedNewSwaggers: string[],
    private tracer: OadTrace,
  ) {
    this.errors = new Map<[string, string], RuntimeError[]>();
    this.context = context;
    this.oadTracer = tracer;
    this.logger = new Logger(this.context);
  }

  /** The function checkBreakingChangeOnSameVersion()
   * maps to the lower "Same-version check" rectangle at:
   * https://aka.ms/azsdk/pr-brch-deep#diagram-explaining-breaking-changes-and-versioning-issues
   *
   * This function is called by the function detectBreakingChange.ts / detectBreakingChange()
   * This function calls this.doBreakingChangeDetection with appropriate "type" and "isCrossVersion" parameters.
   */
  async checkBreakingChangeOnSameVersion(): Promise<{
    msgs: ResultMessageRecord[];
    oadViolationsCnt: number;
    errorCnt: number;
  }> {
    console.log(`ENTER definition checkBreakingChangeOnSameVersion`);

    let aggregateOadViolationsCnt = 0;
    let aggregateErrorCnt = 0;
    for (const swaggerJson of this.oldSwaggers) {
      const { oadViolationsCnt, errorCnt } = await this.doBreakingChangeDetection(
        path.resolve(this.context.localSpecRepoPath, swaggerJson),
        swaggerJson,
        "SameVersion",
        specIsPreview(swaggerJson) ? "preview" : "stable",
      );
      aggregateOadViolationsCnt += oadViolationsCnt;
      aggregateErrorCnt += errorCnt;
    }

    console.log(
      `RETURN definition checkBreakingChangeOnSameVersion. ` +
        `this.msgs.length: ${this.msgs.length}, ` +
        `aggregateOadViolationsCnt: ${aggregateOadViolationsCnt}, aggregateErrorCnt: ${aggregateErrorCnt}`,
    );

    return {
      msgs: this.msgs,
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
   *      applyRules() function
   *
   *   which uses the oadMessagesRuleMap.ts config to schedule
   *   appropriate "review required" labels to be added downstream by doBreakingChangeDetection() calling addBreakingChangeLabels()
   *   as well as updates the OAD messages severity.
   *
   * 3. It saves the OadMessage[] collection to the unified pipeline store ("pipe.log" file) in call to:
   *     this.unifiedStore.appendOadMessages()
   *
   * 4. It saves OAD errors, if any, to the unified pipeline store ("pipe.log" file) in call to:
   *     appendOadRuntimeErrors()
   */
  async doBreakingChangeDetection(
    oldSpec: string,
    newSpec: string,
    scenario: BreakingChangesCheckType,
    previousApiVersionLifecycleStage: ApiVersionLifecycleStage,
  ): Promise<{ oadViolationsCnt: number; errorCnt: number }> {
    console.log(
      `ENTER definition BreakingChangeDetector.doBreakingChangeDetection oldSpec: ${oldSpec}, newSpec: ${newSpec}`,
    );

    let oadViolationsCnt = 0;
    let errorCnt = 0;
    try {
      await this.pr.checkout(this.pr.baseBranch);
      const oadMessages: OadMessage[] = await runOad(
        path.resolve(this.context.localSpecRepoPath, oldSpec),
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

      const msgs: ResultMessageRecord[] = this.logger.appendOadMessages(
        modifiedOadMessages,
        this.context.baseBranch,
      );
      this.msgs = this.msgs.concat(msgs);
    } catch (e) {
      const errors = [];

      errors.push({
        error: e,
        groupName: previousApiVersionLifecycleStage,
        old: branchHref(
          getRelativeSwaggerPathToRepo(path.resolve(this.context.localSpecRepoPath, oldSpec)),
          this.context.baseBranch,
        ),
        new: blobHref(getRelativeSwaggerPathToRepo(newSpec)),
      });

      this.errors = this.errors.set([oldSpec, newSpec], errors);
      errorCnt += 1;

      appendOadRuntimeErrors(errors);
    }

    console.log(
      `RETURN definition BreakingChangeDetector.doBreakingChangeDetection ` +
        `scenario: ${scenario}, ` +
        `previousApiVersionLifecycleStage: ${previousApiVersionLifecycleStage}, ` +
        `oldSpec: ${oldSpec}, newSpec: ${newSpec}, ` +
        `oadViolationsCnt: ${oadViolationsCnt}, errorCnt: ${errorCnt}`,
    );

    return { oadViolationsCnt, errorCnt };
  }
}

function appendOadRuntimeErrors(errors: RuntimeError[]) {
  // We want to display some lines as we improved AutoRest v2 error output since March 2024 to provide multi-line error messages, e.g.:
  // https://github.com/Azure/autorest/pull/4934
  // But we also don't want to display too much, due to GitHub check description length limit,
  // which would start causing truncation of messages: see buildCompletedBreakingChangeCheckText.ts / checkPaneLengthLimit.
  const githubCheckPageStackTraceMaxLength = 20;

  // For console (diagnostic) logs we want to display the entire stack trace.
  // The value here is an arbitrary high number to limit the stack trace in case a bug would cause it to be excessively long.
  const consoleLogStackTraceMaxLength = 500;

  // This should have been done by one of the methods in logger.ts
  appendFileSync(
    logFileName,
    JSON.stringify(getErrorResult(errors, githubCheckPageStackTraceMaxLength)) + "\n",
  );
  console.log(
    `appendOadRuntimeErrors: ${JSON.stringify(
      getErrorResult(errors, consoleLogStackTraceMaxLength),
    )}`,
  );
}

function getErrorResult(errors: RuntimeError[], stackTraceMaxLength: number): MessageLine {
  return errors.map((it) => ({
    type: "Raw",
    level: "Error",
    message: "Runtime Exception",
    time: new Date(),
    groupName: it.groupName,
    extra: {
      new: it.new,
      old: it.old,
      details: processOadRuntimeErrorMessage(it.error.message, stackTraceMaxLength),
    },
  }));
}

/**
 * Post-processes the message of an error coming from OAD.
 * Notably, the kind of errors that need post-processing is when OAD
 * throws a runtime error because it has invoked AutoRest, it threw,
 * and OAD has re-thrown it.
 * We want to make such errors more readable, which we do here.
 * Issue capturing this work and providing more context:
 * https://github.com/Azure/azure-sdk-tools/issues/6998
 */
function processOadRuntimeErrorMessage(message: string, stackTraceMaxLength: number): string {
  let outputMsg: string = "";

  // Example "message" string, truncated with cutoffMsg():
  //
  //   Command failed: node "/mnt/vss/_work/_tasks/AzureApiValidation_5654d05d-82c1-48da-ad8f-161b817f6d41/0.0.59/common/temp/node_modules/.pnpm/https://github.com/Azure+oad@0.10.4/node_modules/autorest/dist/app.js" --v2 --input-file=specification/servicebus/resource-manager/Microsoft.ServiceBus/preview/2023-01-01-preview/namespace-preview.json --output-artifact=swagger-document.json --output-artifact=swagger-document.map --output-file=new --output-folder=/tmp\nERROR: Schema violation: Data does not match any schemas from 'oneOf'\n - file:///mnt/vss/_work/1/azure-rest-api-specs/specification/servicebus/resource-manager/Microsoft.ServiceBus/preview/2023-01-01-preview/namespace-preview.json:347:10 ($.paths["/subscriptions/subscriptionId/resourceGroups/resourceGroupName/providers/Microsoft.ServiceBus/namespaces/namespaceName/failover"].post["x-ms-examples"].NamespaceFailOver)\nFATAL: swagger-document/individual/schema-validator - FAILED\nFATAL: Error: [OperationAbortedException] Error occurred. Exiting.\nProcess() cancelled due to e
  //
  const oadAutorestInvocationRuntimeError =
    message.startsWith("Command failed: node") && message.includes("autorest/dist/app.js");

  if (oadAutorestInvocationRuntimeError) {
    let lines: string[] = message.split(/[\r\n]+/);

    const introLine: string =
      `Breaking change detector (OAD) invoked AutoRest. AutoRest threw a runtime error. ` +
      `First ${stackTraceMaxLength} lines of stack trace follow, indexed. ` +
      `First line should contain AutoRest command line invocation details. ` +
      `Remaining lines should contain the main message reported by AutoRest.`;

    const stackTraceLines: string[] = lines
      .slice(0, Math.min(stackTraceMaxLength, lines.length))
      .filter((line) => line.length > 0)
      .map((line, i) => `${i + 1}: ${line}`);

    outputMsg = [introLine, "===================="]
      .concat(stackTraceLines)
      // We join with '<br/>' as this will display correctly as a line break inside
      // a cell of a table generated in given GitHub check description.
      // This '<br/>' will be interpreted downstream by
      // 'msgInterfaceUtils.ts / commonHelper.renderExtra',
      // as called by the 'checker.handlebars' template.
      .join("<br/>");
  } else {
    outputMsg = cutoffMsg(message) || "";
  }
  return outputMsg;
}

function specIsPreview(specPath: string) {
  // Example input value: specification/maps/data-plane/Creator/preview/2022-09-01-preview/wayfind.json
  return specPath.includes("/preview/") && !specPath.includes("/stable/");
}

type RuntimeError = {
  error: Error;
  old: string;
  new: string;
  groupName?: ApiVersionLifecycleStage;
};
