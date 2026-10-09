import "./models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

const EvaluatorDiagnosticsRequiredPreviews = #{
  required_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview],
};

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

  @doc("Existing rubric-health computations were recorded for a generated evaluator version.")
  health_computed: "health_computed",
}

@doc("The shared fields for recorded evaluator changes and health snapshots.")
@discriminator("type")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model EvaluatorDiagnostic {
  @doc("The stable server-assigned diagnostic identifier.")
  @minLength(1)
  id: string;

  @doc("The evaluator version associated with the recorded snapshot.")
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

@doc("Actor properties shared by recorded evaluator diagnostics without introducing another discriminator level.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model EvaluatorDiagnosticActorProperties {
  @doc("The authenticated user or service responsible for the lineage event.")
  actor: EvaluatorDiagnosticActor;
}

@doc("A flat page of recorded evaluator changes and computed health snapshots.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model CompletedEvaluatorDiagnosticsPage {
  @doc("The recorded evaluator diagnostics.")
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

  @doc("Whether more diagnostic entries are available.")
  has_more: boolean;
}

@doc("A normalized rubric-health score produced by the existing computation.")
@minValue(0)
@maxValue(1)
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
scalar EvaluatorHealthScore extends float64;

@doc("Two zero-based indices into the health snapshot's dimension_ids array.")
@minItems(2)
@maxItems(2)
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model EvaluatorHealthRedundantPair is Array<int32>;

@doc("A snapshot of existing rubric-health computations. Missing components remain null and are not replaced with zeros.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model EvaluatorHealthMetrics {
  @doc("The number of rubric dimensions used by the computation.")
  @minValue(0)
  n_dimensions: int32;

  @doc("The dimension identifiers in their order when health was computed.")
  dimension_ids: string[];

  @doc("Embedding-based dimension diversity, or null when unavailable.")
  diversity: EvaluatorHealthScore | null;

  @doc("Embedding-based source coverage, or null when unavailable.")
  coverage: EvaluatorHealthScore | null;

  @doc("Failure-path balance computed by the existing keyword heuristic.")
  negative_vs_positive: EvaluatorHealthScore;

  @doc("The method used for negative/positive balance. Currently 'heuristic'.")
  negpos_method: string;

  @doc("The existing weighted overall score. Null if any component is unavailable; weights are not renormalized around missing components.")
  overall: EvaluatorHealthScore | null;

  @doc("Provisional structural confidence: 'low', 'med', or 'high'. This is not a calibrated statistical confidence.")
  confidence: string;

  @doc("Whether the embedding computation completed successfully.")
  embeddings_ok: boolean;

  @doc("The embedding provider used by the computation, such as 'local_tfidf'.")
  embedding_provider: string;

  @doc("Embedding availability: 'ok', 'not_configured', 'invalid_response', or 'failed'.")
  embedding_status: string;

  @doc("Pairs of dimension indices flagged as redundant by the existing computation.")
  redundant_pairs: EvaluatorHealthRedundantPair[];
}

@doc("Health computed during evaluator generation and retained as a historical snapshot. GET does not recompute these values after later edits.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model HealthComputedDiagnosticChange extends EvaluatorDiagnostic {
  ...EvaluatorDiagnosticActorProperties;
  type: EvaluatorDiagnosticType.health_computed;

  @doc("The generation job that produced the health snapshot.")
  @minLength(1)
  generation_job_id: string;

  @doc("The computed health metrics and their availability.")
  health: EvaluatorHealthMetrics;
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

@doc("A diagnostic change recording the creation of an evaluator version.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model VersionCreatedDiagnosticChange extends EvaluatorDiagnostic {
  ...EvaluatorDiagnosticActorProperties;
  type: EvaluatorDiagnosticType.version_created;

  @doc("The preceding published evaluator version, when one exists.")
  prior_version?: EvaluatorVersionNumber;

  @doc("The evaluator generation job that created the version, when applicable.")
  @minLength(1)
  generation_job_id?: string;
}

@doc("A diagnostic change recording the addition of a rubric dimension.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
model DimensionAddedDiagnosticChange extends EvaluatorDiagnostic {
  ...EvaluatorDiagnosticActorProperties;
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
model DimensionUpdatedDiagnosticChange extends EvaluatorDiagnostic {
  ...EvaluatorDiagnosticActorProperties;
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
model DimensionRemovedDiagnosticChange extends EvaluatorDiagnostic {
  ...EvaluatorDiagnosticActorProperties;
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
model DefinitionUpdatedDiagnosticChange extends EvaluatorDiagnostic {
  ...EvaluatorDiagnosticActorProperties;
  type: EvaluatorDiagnosticType.definition_updated;

  @doc("The functional field changes applied.")
  @minItems(1)
  field_changes: EvaluatorFieldChange[];
}
