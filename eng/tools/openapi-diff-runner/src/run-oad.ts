/**
 * By design, the only member exported from this file is the runOad function.
 *
 * In the "breakingChanges directory invocation depth" this file has depth 3,
 * i.e. it is invoked by files with depth 2.
 */
import * as oad from "@azure/oad";
import { logMessage, logMessageSafe } from "./log.js";
import { OadMessage } from "./types/oad-types.js";

/**
 * The runOad() function is a wrapper around the "@azure/oad" library whose source is https://github.com/Azure/openapi-diff.
 *
 * runOad() is invoked by BreakingChangeDetector.doBreakingChangeDetection().
 *
 * runOad() eventually invokes openApiDiff.compare() which calls into openapi-diff repo OpenApiDiff class compare() method [1],
 * which obtains semantic model of the old / new (before / after) swagger file specs and then compares them
 * via the C# OpenApiDiff.Program.Compare() method [2].
 *
 * The OAD messages returned from "@azure/oad" invocation are then slightly post-processed and returned as OadMessage[] collection.
 *
 * See also: OadMessage type comment.
 *
 * [1] https://github.com/Azure/openapi-diff/blob/4c158308aca2cfd584e556fe8a05ce6967de2912/src/lib/validators/openApiDiff.ts#L128
 * [2] https://github.com/Azure/openapi-diff/blob/4c158308aca2cfd584e556fe8a05ce6967de2912/openapi-diff/src/core/OpenApiDiff/Program.cs#L40
 */
export async function runOad(
  oldSpec: string,
  newSpec: string,
  oldTag?: string,
  newTag?: string,
): Promise<OadMessage[]> {
  logMessage(
    `ENTER definition runOad oldSpec: ${oldSpec}, newSpec: ${newSpec}, oldTag: ${oldTag}, newTag: ${newTag}`,
  );

  if (
    oldSpec === null ||
    oldSpec === undefined ||
    typeof oldSpec.valueOf() !== "string" ||
    !oldSpec.trim().length
  ) {
    throw new Error(
      'oldSpec is a required parameter of type "string" and it cannot be an empty string.',
    );
  }

  if (
    newSpec === null ||
    newSpec === undefined ||
    typeof newSpec.valueOf() !== "string" ||
    !newSpec.trim().length
  ) {
    throw new Error(
      'newSpec is a required parameter of type "string" and it cannot be an empty string.',
    );
  }

  let oadCompareOutput: string;
  if (oldTag && newTag) {
    logMessage("oad.CompareTags() when (oldTag && newTag)");

    oadCompareOutput = await oad.compareTags(oldSpec, oldTag, newSpec, newTag, {
      consoleLogLevel: "warn",
    });
  } else {
    logMessage("oad.CompareTags() when !(oldTag && newTag)");

    oadCompareOutput = await oad.compare(oldSpec, newSpec, { consoleLogLevel: "warn" });
  }

  logMessageSafe(`oadCompareOutput: ${oadCompareOutput}`);

  // The oadCompareOutput is emitted by this OAD source:
  // OpenApiDiff.Program.Main():
  // https://github.com/Azure/openapi-diff/blob/7a3f705224e03de762689eeeb6d4f1b6820dc463/openapi-diff/src/core/OpenApiDiff/Program.cs#L40-L50
  // And each message is of type AutoRest.Swagger.ComparisonMessage:
  // https://github.com/Azure/openapi-diff/blob/7a3f705224e03de762689eeeb6d4f1b6820dc463/openapi-diff/src/modeler/AutoRest.Swagger/ComparisonMessage.cs#L17-L17
  // after it was transformed by ComparisonMessage.GetValidationMessagesAsJson().
  const oadMessages: OadMessage[] = JSON.parse(oadCompareOutput);

  logMessage(
    `RETURN definition runOad. oadMessages.length: ${oadMessages.length}, ` +
      `oldSpec: ${oldSpec}, newSpec: ${newSpec}, oldTag: ${oldTag}, newTag: ${newTag}.`,
  );

  return oadMessages;
}
