/**
 * The file breakingChangeShared.ts contains members that:
 * - are shared across 2 or more files in the "breakingChanges" folder.
 * - AND do not depend on any members from beyond this file, except "@azure/swagger-validation-common".
 * - "Deep-dive into breaking changes on spec PRs"
 *   https://aka.ms/azsdk/pr-brch-deep
 *
 * - "[Breaking Change][PR Workflow] Use more granular labels for Breaking Changes approvals"
 *   https://github.com/Azure/azure-sdk-tools/issues/6374
 */
import { readFileSync } from "node:fs";
import { basename, dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import {
  getVersionFromInputFile,
  sourceBranchHref,
  specificBranchHref,
} from "../utils/common-utils.js";
import { ApiVersionLifecycleStage, Context } from "./breaking-change.js";
import { MessageLevel } from "./message.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const packageJson = JSON.parse(readFileSync(join(__dirname, "../../../package.json"), "utf-8"));
/**
 * A type that represents AutoRest.Swagger.ComparisonMessage from OAD
 * after being transformed by ComparisonMessage.GetValidationMessagesAsJson().
 *
 * An OadMessage gets converted to ResultMessageRecord by the function oadMessagesToResultMessageRecords.
 *
 * For origin of data of this type and OAD source links, see comments in:
 * runOad.ts
 */
export type OadMessage = {
  readonly id: string;
  readonly code: OadRuleCode;
  readonly docUrl: string;
  readonly message: string;
  readonly mode: string; // "mode" is assigned from MessageType enum in openapi-diff, which is ["Addition", "Update", Removal"]
  readonly type: MessageLevel; // "type" is assigned from openapi-diff's "Severity" , which is openapi-diff's Category enum, which is ["Info", "Warning", "Error"]
  readonly new: ChangeProperties;
  readonly old: ChangeProperties;
  readonly groupName?: ApiVersionLifecycleStage;
};

export type ChangeProperties = {
  readonly location?: string;
  readonly path?: string;
  readonly ref?: string;
};

/**
 * Represents the state of OAD tracing with immutable data structure
 */
export type OadTraceData = {
  readonly traces: readonly {
    readonly old: string;
    readonly new: string;
  }[];
  readonly baseBranch: string;
  readonly context: Context;
};

/**
 * Creates a new OAD trace data structure
 */
export const createOadTrace = (context: Context): OadTraceData => ({
  traces: [],
  baseBranch: context.baseBranch,
  context,
});

/**
 * Adds a new trace entry to the OAD trace data
 */
export const addOadTrace = (
  traceData: OadTraceData,
  oldSwagger: string,
  newSwagger: string,
): OadTraceData =>
  ({
    ...traceData,
    traces: [...traceData.traces, { old: oldSwagger, new: newSwagger }],
  }) as OadTraceData;

/**
 * Sets the base branch for the OAD trace data
 */
export const setOadBaseBranch = (traceData: OadTraceData, branchName: string): OadTraceData => ({
  ...traceData,
  baseBranch: branchName,
});

/**
 * Generates markdown content from OAD trace data
 */
export const generateOadMarkdown = async (traceData: OadTraceData): Promise<string> => {
  const oadVersion = packageJson.dependencies?.["@azure/oad"]?.replace(/[\^~]/, "") || "unknown";
  if (traceData.traces.length === 0) {
    return "";
  }

  // Create properly formatted markdown table without leading whitespace
  let content = `| Compared specs ([v${oadVersion}](https://www.npmjs.com/package/@azure/oad/v/${oadVersion})) | new version | base version |
|-------|-------------|--------------|
`;

  for (const value of traceData.traces) {
    // Compose each column for clarity
    const newFileName = basename(value.new);
    const newVersion = await getVersionFromInputFile(value.new, true);

    // Truncate commit hash to first 8 characters for better readability
    const shortCommit = traceData.context.headCommit.substring(0, 8);
    const newCommitLink = `[${shortCommit}](${sourceBranchHref(traceData.context.sourceRepo, traceData.context.headCommit, value.new)})`;

    const oldVersion = await getVersionFromInputFile(value.old, true);
    const oldCommitLink = `[${traceData.baseBranch}](${specificBranchHref(traceData.context.targetRepo, value.old, traceData.baseBranch)})`;

    // Add a row to the markdown table with proper spacing
    content += `| ${newFileName} | ${newVersion} (${newCommitLink}) | ${oldVersion} (${oldCommitLink}) |
`;
  }

  return content;
};

// Codes correspond to members of openapi-diff ComparisonMessages:
// https://github.com/Azure/openapi-diff/blob/4c158308aca2cfd584e556fe8a05ce6967de2912/openapi-diff/src/modeler/AutoRest.Swagger/ComparisonMessages.cs
export type OadRuleCode =
  | "AddedAdditionalProperties"
  | "AddedEnumValue"
  | "AddedOperation"
  | "AddedOptionalProperty"
  | "AddedPath"
  | "AddedPropertyInResponse"
  | "AddedReadOnlyPropertyInResponse"
  | "AddedRequiredProperty"
  | "AddedXmsEnum"
  | "AddingHeader"
  | "AddingOptionalParameter"
  | "AddingRequiredParameter"
  | "AddingResponseCode"
  | "ArrayCollectionFormatChanged"
  | "ChangedParameterOrder"
  | "ConstantStatusHasChanged"
  | "ConstraintChanged"
  | "ConstraintIsStronger"
  | "ConstraintIsWeaker"
  | "DefaultValueChanged"
  | "DifferentAllOf"
  | "DifferentDiscriminator"
  | "DifferentExtends"
  | "ModifiedOperationId"
  | "NoVersionChange"
  | "ParameterInHasChanged"
  | "ParameterLocationHasChanged"
  | "ProtocolNoLongerSupported"
  | "ReadonlyPropertyChanged"
  | "ReferenceRedirection"
  | "RemovedAdditionalProperties"
  | "RemovedClientParameter"
  | "RemovedDefinition"
  | "RemovedEnumValue"
  | "RemovedOperation"
  | "RemovedOptionalParameter"
  | "RemovedPath"
  | "RemovedProperty"
  | "RemovedRequiredParameter"
  | "RemovedResponseCode"
  | "RemovedXmsEnum"
  | "RemovingHeader"
  | "RequestBodyFormatNoLongerSupported"
  | "RequiredStatusChange"
  | "ResponseBodyFormatNowSupported"
  | "TypeChanged"
  | "TypeFormatChanged"
  | "VersionsReversed"
  | "XmsEnumChanged"
  | "XmsLongRunningOperationChanged";
