import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./workspace.models.tsp";
import "./common.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

/**
 * Model that represents the latest workspace evaluation result.
 */
@parentResource(Workspace)
@singleton("latest")
@removed(Microsoft.Chaos.Versions.v2026_11_01)
@renamedFrom(Microsoft.Chaos.Versions.v2026_11_01, "WorkspaceEvaluation")
model LegacyWorkspaceEvaluation
  is ProxyResource<WorkspaceEvaluationProperties> {
  ...ResourceNameParameter<
    Resource = LegacyWorkspaceEvaluation,
    KeyName = "evaluationName",
    SegmentName = "evaluations",
    NamePattern = ""
  >;
}

/**
 * A retained workspace evaluation of published scenario-template versions.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
@parentResource(Workspace)
model WorkspaceEvaluation is ProxyResource<WorkspaceEvaluationProperties> {
  ...ResourceNameParameter<
    Resource = WorkspaceEvaluation,
    KeyName = "evaluationName",
    SegmentName = "evaluations",
    NamePattern = "^(latest|[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})$"
  >;
}

/**
 * Model that represents the properties of the workspace evaluation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only evaluation result with operation status, not a resource provisioning lifecycle"
model WorkspaceEvaluationProperties {
  /**
   * The evaluation status.
   */
  @visibility(Lifecycle.Read)
  status: WorkspaceEvaluationStatus;

  /**
   * The evaluation UTC start time.
   */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /**
   * The evaluation UTC end time.
   */
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  /**
   * System or infrastructure errors encountered during evaluation.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errors?: OperationError[];

  /**
   * The workspace ID this evaluation belongs to.
   */
  @visibility(Lifecycle.Read)
  workspaceId: Azure.Core.armResourceIdentifier;

  /**
   * The resource snapshot ID used for this evaluation.
   */
  @added(Microsoft.Chaos.Versions.v2026_08_01_preview)
  @madeRequired(Microsoft.Chaos.Versions.v2026_11_01)
  @visibility(Lifecycle.Read)
  resourceSnapshotId: string;

  /**
   * The canonical Azure resource ID of the retained discovery result that supplied resourceSnapshotId. This reference does not change when the latest discovery changes and never identifies the latest alias or a protected LRO polling handle.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  @visibility(Lifecycle.Read)
  discoveryResultId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Chaos/workspaces/discoveries";
    }
  ]>;

  /**
   * The number of scenarios to evaluate.
   */
  @removed(Microsoft.Chaos.Versions.v2026_08_01_preview)
  @visibility(Lifecycle.Read)
  numScenariosToEvaluate?: int32;

  /**
   * The number of scenarios that evaluated successfully.
   */
  @removed(Microsoft.Chaos.Versions.v2026_08_01_preview)
  @visibility(Lifecycle.Read)
  numScenariosEvaluatedSucceeded?: int32;

  /**
   * The number of scenarios that failed evaluation.
   */
  @removed(Microsoft.Chaos.Versions.v2026_08_01_preview)
  @visibility(Lifecycle.Read)
  numScenariosEvaluatedFailed?: int32;

  /**
   * The number of scenarios that were cancelled during evaluation.
   */
  @removed(Microsoft.Chaos.Versions.v2026_08_01_preview)
  @visibility(Lifecycle.Read)
  numScenariosEvaluatedCancelled?: int32;

  /**
   * The number of templates to evaluate.
   */
  @added(Microsoft.Chaos.Versions.v2026_08_01_preview)
  @madeRequired(Microsoft.Chaos.Versions.v2026_11_01)
  @typeChangedFrom(Microsoft.Chaos.Versions.v2026_11_01, int32)
  @visibility(Lifecycle.Read)
  numTemplatesToEvaluate: WorkspaceEvaluationCount;

  /**
   * The number of templates that evaluated successfully.
   */
  @added(Microsoft.Chaos.Versions.v2026_08_01_preview)
  @madeRequired(Microsoft.Chaos.Versions.v2026_11_01)
  @typeChangedFrom(Microsoft.Chaos.Versions.v2026_11_01, int32)
  @visibility(Lifecycle.Read)
  numTemplatesEvaluatedSucceeded: WorkspaceEvaluationCount;

  /**
   * The number of templates that failed evaluation.
   */
  @added(Microsoft.Chaos.Versions.v2026_08_01_preview)
  @madeRequired(Microsoft.Chaos.Versions.v2026_11_01)
  @typeChangedFrom(Microsoft.Chaos.Versions.v2026_11_01, int32)
  @visibility(Lifecycle.Read)
  numTemplatesEvaluatedFailed: WorkspaceEvaluationCount;

  /**
   * The number of templates that were cancelled during evaluation.
   */
  @added(Microsoft.Chaos.Versions.v2026_08_01_preview)
  @madeRequired(Microsoft.Chaos.Versions.v2026_11_01)
  @typeChangedFrom(Microsoft.Chaos.Versions.v2026_11_01, int32)
  @visibility(Lifecycle.Read)
  numTemplatesEvaluatedCancelled: WorkspaceEvaluationCount;

  /**
   * The overall evaluation result.
   */
  @removed(Microsoft.Chaos.Versions.v2026_11_01)
  @visibility(Lifecycle.Read)
  evaluationResult?: RecommendationStatus;

  /**
   * Per-scenario evaluation results.
   */
  @removed(Microsoft.Chaos.Versions.v2026_08_01_preview)
  @visibility(Lifecycle.Read)
  @identifiers(#["scenarioName"])
  results?: ScenarioEvaluationResultItem[];

  /**
   * Per-template evaluation results.
   */
  @added(Microsoft.Chaos.Versions.v2026_08_01_preview)
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "results")
  @identifiers(#["templateId"])
  resultsV2?: TemplateEvaluationResultItem[];
}

/**
 * Model that represents a single scenario evaluation result.
 */
model ScenarioEvaluationResultItem {
  /**
   * The name of the scenario that was evaluated.
   */
  scenarioName: string;

  /**
   * The evaluation result for this scenario.
   */
  evaluationResult: RecommendationStatus;
}

/**
 * Model that represents a single template evaluation result.
 */
@added(Microsoft.Chaos.Versions.v2026_08_01_preview)
model TemplateEvaluationResultItem {
  /**
   * The template ID that was evaluated. Optional because the underlying BE field may
   * be null for legacy evaluations created before template-centric persistence landed;
   * the GW falls back to `scenarioName` in that case (`scenario.Id == templateId` by BE
   * convention), so ARM responses are typically populated in practice.
   */
  @removed(Microsoft.Chaos.Versions.v2026_11_01)
  @renamedFrom(Microsoft.Chaos.Versions.v2026_11_01, "templateId")
  legacyTemplateId?: string;

  /**
   * The template name that was evaluated. Optional for the same reason as `templateId`.
   */
  @removed(Microsoft.Chaos.Versions.v2026_11_01)
  @renamedFrom(Microsoft.Chaos.Versions.v2026_11_01, "templateName")
  legacyTemplateName?: string;

  /**
   * The canonical ARM ID of the evaluated scenario-template version. Scenario IDs and versionless template aliases are not valid substitutes.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  @visibility(Lifecycle.Read)
  templateId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Chaos/scenarioTemplates/versions";
    }
  ]>;

  /**
   * The stable catalog name of the evaluated scenario template, not a localized display name.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  @visibility(Lifecycle.Read)
  @minLength(1)
  templateName: string;

  /**
   * The evaluation result for this template.
   */
  evaluationResult: RecommendationStatus;
}

/**
 * A nonnegative count of scenario-template versions in an evaluation.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
@minValue(0)
scalar WorkspaceEvaluationCount extends int32;

/**
 * Enum of the workspace evaluation status.
 */
union WorkspaceEvaluationStatus {
  string,

  /**
   * The evaluation is pending and has not started.
   */
  Pending: "Pending",

  /**
   * The evaluation has been accepted and is queued for execution.
   */
  Queued: "Queued",

  /**
   * The evaluation is in progress.
   */
  InProgress: "InProgress",

  /**
   * The evaluation completed successfully.
   */
  Succeeded: "Succeeded",

  /**
   * The evaluation partially succeeded — some scenarios succeeded while others failed.
   */
  @removed(Microsoft.Chaos.Versions.v2026_11_01)
  @renamedFrom(Microsoft.Chaos.Versions.v2026_11_01, "PartiallySucceeded")
  legacyPartiallySucceeded: "PartiallySucceeded",

  /**
   * Unless cancellation won terminal settlement, at least one template applicability test completed and at least one failed or was canceled. Discovery completeness does not determine this processing status. The first terminal settlement is authoritative; a later cancellation does not replace it.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  PartiallySucceeded: "PartiallySucceeded",

  /**
   * The evaluation failed.
   */
  @removed(Microsoft.Chaos.Versions.v2026_11_01)
  @renamedFrom(Microsoft.Chaos.Versions.v2026_11_01, "Failed")
  legacyFailed: "Failed",

  /**
   * No template applicability test completed and at least one failed, unless cancellation won terminal settlement. The accepted resource snapshot and discovery result reference remain present; an admission failure creates no evaluation result.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  Failed: "Failed",

  /**
   * The evaluation was canceled.
   */
  @removed(Microsoft.Chaos.Versions.v2026_11_01)
  @renamedFrom(Microsoft.Chaos.Versions.v2026_11_01, "Canceled")
  legacyCanceled: "Canceled",

  /**
   * Cancellation won terminal settlement, or all admitted template tests were canceled. Previously recorded outcomes may remain. A later callback cannot replace this terminal result, and cancellation cannot replace an already settled result.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  Canceled: "Canceled",
}

@@doc(
  WorkspaceEvaluation.name,
  "The stable service-generated evaluation result ID in hyphenated GUID form. Use latest in the request path for the most recently durably admitted GA template evaluation; responses contain the canonical result ID, not the protected polling identifier."
);
