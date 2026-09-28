import "./models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

const EvaluatorDiagnosticsRequiredPreviews = #{
  required_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview],
};

@doc("A lowercase 64-character SHA-256 hexadecimal digest.")
@minLength(64)
@maxLength(64)
@pattern("^[0-9a-f]{64}$")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
scalar Sha256Hash extends string;

@doc("A published evaluator version number represented as a decimal integer string.")
@minLength(1)
@maxLength(10)
@pattern("^[1-9][0-9]*$")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
scalar EvaluatorVersionNumber extends string;

@doc("The type of actor responsible for an evaluator lineage diagnostic.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
union EvaluatorDiagnosticActorType {
  string,

  @doc("An authenticated user initiated the change.")
  user: "user",

  @doc("A Foundry service component initiated the change.")
  service: "service",
}

@doc("The actor responsible for an evaluator lineage diagnostic.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model EvaluatorDiagnosticActor {
  @doc("The type of actor.")
  type: EvaluatorDiagnosticActorType;

  @doc("A stable opaque principal or service identifier, when available.")
  id?: string;
}

@doc("The severity of an evaluator diagnostic message.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
union EvaluatorDiagnosticMessageSeverity {
  string,

  @doc("Informational diagnostic detail.")
  info: "info",

  @doc("A diagnostic condition that may require attention.")
  warning: "warning",
}

@doc("Known machine-readable classifications for evaluator diagnostic changes.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
union EvaluatorDiagnosticChangeType {
  string,

  @doc("A user created an evaluator version.")
  human_created: "human_created",

  @doc("A user added a rubric dimension.")
  human_added: "human_added",

  @doc("A user changed evaluator functional content.")
  human_edited: "human_edited",

  @doc("A user removed a rubric dimension.")
  human_removed: "human_removed",

  @doc("Evaluator generation created the resulting content.")
  generated: "generated",

  @doc("Evaluator generation changed an existing dimension.")
  regenerated: "regenerated",

  @doc("The generated rubric no longer contained an existing dimension.")
  not_present_in_generated_rubric: "not_present_in_generated_rubric",

  @doc("An evaluator version was published from completed generation.")
  generation_completed: "generation_completed",

  @doc("The diagnostic change is a baseline imported from legacy evaluator history.")
  history_imported: "history_imported",
}

@doc("The supported evaluator diagnostic change shapes.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
union EvaluatorDiagnosticType {
  string,

  @doc("An evaluator version was created.")
  version_created: "version_created",

  @doc("A rubric dimension was added.")
  dimension_added: "dimension_added",

  @doc("A rubric dimension was updated.")
  dimension_updated: "dimension_updated",

  @doc("A rubric dimension was removed.")
  dimension_removed: "dimension_removed",

  @doc("Functional evaluator fields outside individual dimensions were updated.")
  definition_updated: "definition_updated",
}

@doc("The shared fields for immutable evaluator publication lineage.")
@discriminator("type")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model EvaluatorDiagnostic {
  @doc("The stable server-assigned diagnostic identifier.")
  @minLength(1)
  id: string;

  @doc("The immutable published evaluator version to which the lineage entry applies.")
  evaluator_version: EvaluatorVersionNumber;

  @doc("The server-recorded time when the change occurred, expressed as Unix seconds.")
  occurred_at: FoundryTimestamp;

  @doc("A stable machine-readable classification describing why the change occurred.")
  change_type: EvaluatorDiagnosticChangeType;

  @doc("A bounded deterministic summary of the change.")
  explanation?: string;

  @doc("The diagnostic change shape.")
  type: EvaluatorDiagnosticType;
}

@doc("The shared fields for completed evaluator lineage diagnostics.")
@discriminator("type")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model EvaluatorLineageDiagnosticBase extends EvaluatorDiagnostic {
  @doc("The lineage diagnostic change shape.")
  type: EvaluatorDiagnosticType;

  @doc("The authenticated user or service responsible for the lineage event.")
  actor: EvaluatorDiagnosticActor;
}

@doc("A flat page of immutable evaluator lineage diagnostics.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model CompletedEvaluatorDiagnosticsPage {
  @doc("The evaluator publication lineage entries.")
  @maxItems(100)
  @pageItems
  data: EvaluatorDiagnostic[];

  @doc("The first diagnostic identifier represented in this page.")
  @minLength(1)
  first_id?: string | null;

  @doc("The last diagnostic identifier represented in this page.")
  @minLength(1)
  @continuationToken
  last_id?: string | null;

  @doc("Whether more lineage entries are available.")
  has_more: boolean;
}

@doc("A change to one functional evaluator field.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model EvaluatorFieldChange {
  @doc("A stable path identifying the changed field.")
  @minLength(1)
  field: string;

  @doc("The prior snapshot, mapping the exact `field` path to its JSON value. The mapped value may be a scalar, array, object, or null.")
  before: Record<unknown>;

  @doc("The resulting snapshot, mapping the exact `field` path to its JSON value. The mapped value may be a scalar, array, object, or null.")
  after: Record<unknown>;
}

@doc("How an evaluator generation source was used.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
union EvaluatorGenerationSourceUseStatus {
  string,

  @doc("The source was accepted and used.")
  accepted: "accepted",

  @doc("Only part of the source was used.")
  partially_used: "partially_used",

  @doc("The source was rejected.")
  rejected: "rejected",
}

@doc("A bounded evaluator generation source snapshot.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model EvaluatorGenerationSourceSnapshot {
  @doc("The stable source identifier within the generation operation.")
  @minLength(1)
  source_id: string;

  @doc("The source type.")
  @minLength(1)
  source_type: string;

  @doc("The lowercase 64-character SHA-256 source content hash.")
  content_hash: Sha256Hash;

  @doc("How the source was used.")
  status: EvaluatorGenerationSourceUseStatus;
}

@doc("Whether one rubric dimension is covered by recorded generation sources.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
union EvaluatorDimensionSourceCoverageStatus {
  string,

  @doc("The dimension has recorded source coverage.")
  covered: "covered",

  @doc("The dimension has partial recorded source coverage.")
  partial: "partial",

  @doc("The service could not resolve the dimension's source coverage.")
  unresolved: "unresolved",

  @doc("The dimension has no recorded source coverage.")
  uncovered: "uncovered",
}

@doc("Recorded source coverage for one rubric dimension.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model EvaluatorDimensionSourceCoverage {
  @doc("The stable rubric dimension identifier.")
  @minLength(1)
  @maxLength(128)
  dimension_id: string;

  @doc("Stable source identifiers recorded for the dimension.")
  source_ids: string[];

  @doc("The recorded source-coverage status.")
  coverage_status: EvaluatorDimensionSourceCoverageStatus;

  @doc("A bounded explanation of the coverage status.")
  explanation?: string;
}

@doc("A bounded gap in evaluator source coverage.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model EvaluatorSourceCoverageGap {
  @doc("The stable gap code.")
  @minLength(1)
  code: string;

  @doc("The gap severity.")
  severity: EvaluatorDiagnosticMessageSeverity;

  @doc("The related source identifier, when applicable.")
  @minLength(1)
  source_id?: string;

  @doc("The related dimension identifier, when applicable.")
  @minLength(1)
  @maxLength(128)
  dimension_id?: string;

  @doc("A bounded explanation.")
  explanation: string;
}

@doc("Bounded source lineage and coverage recorded by evaluator generation.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model EvaluatorSourceLineageSummary {
  @doc("Recorded generation source snapshots.")
  sources: EvaluatorGenerationSourceSnapshot[];

  @doc("Recorded source coverage by rubric dimension.")
  dimension_coverage: EvaluatorDimensionSourceCoverage[];

  @doc("Recorded source-coverage gaps.")
  coverage_gaps: EvaluatorSourceCoverageGap[];

  @doc("Bounded limitations of the recorded lineage.")
  limitations: string[];
}

@doc("A diagnostic change recording the creation of an evaluator version.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model VersionCreatedDiagnosticChange extends EvaluatorLineageDiagnosticBase {
  type: EvaluatorDiagnosticType.version_created;

  @doc("The preceding published evaluator version, when one exists.")
  prior_version?: EvaluatorVersionNumber;

  @doc("The evaluator generation job that created the version, when applicable.")
  @minLength(1)
  generation_job_id?: string;

  @doc("Bounded source lineage recorded by evaluator generation, when available.")
  source_lineage?: EvaluatorSourceLineageSummary;
}

@doc("A diagnostic change recording the addition of a rubric dimension.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model DimensionAddedDiagnosticChange extends EvaluatorLineageDiagnosticBase {
  type: EvaluatorDiagnosticType.dimension_added;

  @doc("The public dimension identifier associated with the change. It remains stable until explicitly changed; changing an identifier produces a removal change for the prior identifier and an addition change for the new identifier.")
  @minLength(1)
  @maxLength(128)
  dimension_id: string;

  @doc("The resulting complete dimension snapshot.")
  after: Dimension;

  @doc("The public dimension fields changed, when reported.")
  @minItems(1)
  @maxItems(3)
  changed_fields?: string[];
}

@doc("A diagnostic change recording an update to a rubric dimension.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model DimensionUpdatedDiagnosticChange extends EvaluatorLineageDiagnosticBase {
  type: EvaluatorDiagnosticType.dimension_updated;

  @doc("The public dimension identifier associated with the change. It remains stable until explicitly changed; changing an identifier produces a removal change for the prior identifier and an addition change for the new identifier.")
  @minLength(1)
  @maxLength(128)
  dimension_id: string;

  @doc("The complete dimension snapshot before the update.")
  before: Dimension;

  @doc("The complete dimension snapshot after the update.")
  after: Dimension;

  @doc("The public dimension fields changed, when reported.")
  @minItems(1)
  @maxItems(3)
  changed_fields?: string[];
}

@doc("A diagnostic change recording the removal of a rubric dimension.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model DimensionRemovedDiagnosticChange extends EvaluatorLineageDiagnosticBase {
  type: EvaluatorDiagnosticType.dimension_removed;

  @doc("The public dimension identifier associated with the change. It remains stable until explicitly changed; changing an identifier produces a removal change for the prior identifier and an addition change for the new identifier.")
  @minLength(1)
  @maxLength(128)
  dimension_id: string;

  @doc("The complete dimension snapshot before removal.")
  before: Dimension;

  @doc("The public dimension fields changed, when reported.")
  @minItems(1)
  @maxItems(3)
  changed_fields?: string[];
}

@doc("A diagnostic change recording functional evaluator changes outside individual dimensions.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model DefinitionUpdatedDiagnosticChange extends EvaluatorLineageDiagnosticBase {
  type: EvaluatorDiagnosticType.definition_updated;

  @doc("The functional field changes applied.")
  @minItems(1)
  field_changes: EvaluatorFieldChange[];
}
