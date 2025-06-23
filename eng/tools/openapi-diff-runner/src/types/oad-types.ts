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
import { basename } from "path";
import { getVersionFromInputFile, specificBranchHref } from "../utils/common-utils.js";
import { MessageLevel } from "./message.js";
import { sourceBranchHref } from "../utils/common-utils.js";
import { ApiVersionLifecycleStage, Context } from "./breaking-change-check.js";
import { defaultBreakingChangeBaseBranch } from "../command-helpers.js";
import { readFileSync } from "fs";
import { fileURLToPath } from "url";
import { dirname, join } from "path";

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

// record oad invoking trace
export class OadTrace {
  private traces: { old: string; new: string; baseBranch: string }[] = [];
  private baseBranch = defaultBreakingChangeBaseBranch;
  private context: Context;

  constructor(context: Context) {
    this.context = context;
  }

  add(oldSwagger: string, newSwagger: string) {
    this.traces.push({ old: oldSwagger, new: newSwagger, baseBranch: this.baseBranch });
    return this;
  }

  setBaseBranch(branchName: string) {
    this.baseBranch = branchName;
  }

  save() {
    const markdown = this.genMarkdown();
    if (markdown) {
      return this.context.logger.appendMarkdown(markdown);
    }
  }

  genMarkdown() {
    const oadVersion = packageJson.dependencies["@azure/oad"].replace(/[\^~]/, "");
    if (this.traces.length === 0) {
      return "";
    }
    let content = `
| Compared specs ([v${oadVersion}](https://www.npmjs.com/package/@azure/oad/v/${oadVersion}))| new version | base version |
|-------|-------------|--------------|
`;
    for (const value of this.traces.values()) {
      content += `|${basename(value.new)} |${getVersionFromInputFile(value.new, true)}([${this.context.headCommit}](${sourceBranchHref(value.new)}))|${getVersionFromInputFile(value.old, true)}([${value.baseBranch}](${specificBranchHref(value.old, value.baseBranch)}))|\n`;
    }
    content += `\n`;
    return content;
  }
}

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
