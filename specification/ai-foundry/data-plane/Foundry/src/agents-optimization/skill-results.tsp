// Skill optimization candidate detail models.

import "./inputs.tsp";

namespace Azure.AI.Projects;

/** Intended output identity, not proof that a skill version was created. */
model AgentOptimizationFoundrySkillOutputReference {
  @doc("Registered Foundry skill reference discriminator.")
  type: "foundry_skill";

  @doc("Intended skill name, retained for rejected, failed, pending, and unchanged results.")
  @minLength(1)
  name: string;

  @doc("Exact service-returned version, present only with status created after confirmed publication. Never copy the input version here or infer a version for an uncertain write.")
  @minLength(1)
  version?: string;
}

/** Planned change to a versioned skill. */
union AgentOptimizationSkillChangeType {
  string,

  /** Create a new skill. */
  create: "create",

  /** Update an exact existing skill baseline. */
  update: "update",

  /** Keep an existing skill unchanged. */
  no_op: "no_op",
}

/** Publication or validation outcome for one skill, independent of whole-job status. */
union AgentOptimizationSkillResultStatus {
  string,

  /** A new skill version was confirmed created. */
  created: "created",

  /** Validated artifact is byte-identical to its exact baseline; no version was created. */
  no_change: "no_change",

  /** Artifact was rejected by validation. */
  rejected: "rejected",

  /** Publication has not completed. */
  pending: "pending",

  /** Processing or publication failed. */
  failed: "failed",

  /** A publication attempt has an uncertain outcome; no version is claimed. */
  publication_unknown: "publication_unknown",
}

/** Structured error for an independent skill outcome. */
model AgentOptimizationSkillResultError {
  @doc("Stable service-authored error code.")
  @minLength(1)
  @maxLength(128)
  code: string;

  @doc("Safe explanation, never raw exceptions or sensitive trace or model content.")
  @minLength(1)
  @maxLength(1024)
  message: string;
}

/** Status of an artifact validation and its coverage. */
union AgentOptimizationSkillValidationStatus {
  string,

  /** The check ran and passed. */
  passed: "passed",

  /** The check ran and failed. */
  failed: "failed",

  /** The check ran with limitations or findings. */
  warning: "warning",

  /** The planned check was not reached; this is not a pass. */
  skipped: "skipped",

  /** Required tooling or model configuration was missing. */
  unavailable: "unavailable",
}

/** Artifact check identifier. Only implemented checks in the validation plan are reported. */
union AgentOptimizationSkillValidationId {
  string,
  schema: "schema",
  format: "format",
  pii: "pii",
  lint_scripts: "lint-scripts",
  quality: "quality",
  security_scan: "security-scan",
  overlap: "overlap",
  package_integrity: "package_integrity",
  target_compatibility: "target_compatibility",
  evidence_provenance: "evidence_provenance",
}

/** Base validation category; comparative performance evaluation is not currently supported. */
@discriminator("type")
model AgentOptimizationSkillValidation {
  @doc("Validation category discriminator.")
  type: string;
}

/** Per-skill artifact validation with explicit coverage and limitations. */
model AgentOptimizationSkillArtifactValidation
  extends AgentOptimizationSkillValidation {
  @doc("Artifact validation discriminator.")
  type: "artifact";

  @doc("Check identifier. Each (type, id) pair is unique within one skill result.")
  id: AgentOptimizationSkillValidationId;

  @doc("Whether the check ran and its outcome. Unimplemented checks are omitted.")
  status: AgentOptimizationSkillValidationStatus;

  @doc("Safe explanation of coverage, limitations, or why the check did not run. Limited checks must not imply full-package coverage; no sensitive excerpts.")
  @maxLength(1024)
  details: string;

  @doc("Service-authored failure or availability code. Omitted when unavailable.")
  error_code?: string;

  @doc("Advisory quality or overlap score, not a comparative candidate evaluation score.")
  @minValue(0)
  @maxValue(1)
  score?: float64;
}

/** One independent skill outcome with its input baseline and intended or confirmed output. */
model AgentOptimizationSkillResult {
  @doc("Intended change.")
  change_type: AgentOptimizationSkillChangeType;

  @doc("Validation or publication outcome.")
  status: AgentOptimizationSkillResultStatus;

  @doc("Exact input baseline for update or no_op, with the same name as output_skill. Omitted for create.")
  input_skill?: AgentOptimizationFoundrySkillReference;

  @doc("Intended identity for every result. A confirmed version appears only with status created; no_change retains the baseline version only in input_skill.")
  output_skill: AgentOptimizationFoundrySkillOutputReference;

  @doc("Artifact checks, including rejections. Absence does not imply success. Comparative performance evaluations are not supported.")
  validations?: AgentOptimizationSkillValidation[];

  @doc("Primary failure, rejection, or uncertain-publication reason. Detailed findings remain in validations. Omitted when there is no error.")
  error?: AgentOptimizationSkillResultError;
}

/** Frozen evidence and discovered baselines, without duplicating requested job configuration. */
model AgentOptimizationSkillResolvedContext {
  @doc("Complete evidence cohort, including traces that produced no artifact. Omitted before resolution; an empty array means a resolved empty cohort.")
  source_trace_ids?: string[];

  @doc("Deduplicated exact baselines discovered from the agent and its toolboxes. Excludes skills supplied only through additional_skills and does not imply invocation. Omitted before discovery; empty when none were discovered or the job is agentless.")
  agent_skills?: AgentOptimizationFoundrySkillReference[];
}

/** Logical skill pipeline steps, in execution order. */
union AgentOptimizationSkillExecutionStepName {
  string,
  resolve_inputs: "resolve_inputs",
  collect_traces: "collect_traces",
  collect_feedback: "collect_feedback",
  prepare_evidence: "prepare_evidence",
  classify_traces: "classify_traces",
  derive_learnings: "derive_learnings",
  plan_changes: "plan_changes",
  generate_skills: "generate_skills",
  validate_skills: "validate_skills",
  publish_skills: "publish_skills",
}

/** Latest recorded state of a logical execution step. */
union AgentOptimizationSkillExecutionStepStatus {
  string,
  not_started: "not_started",
  in_progress: "in_progress",
  completed: "completed",
  failed: "failed",
  skipped: "skipped",
  cancelled: "cancelled",
}

/** Measured facts for one step. Unknown values are omitted, never zero-filled. Trace counts refer to distinct conversations, not telemetry rows. */
model AgentOptimizationSkillExecutionStepDetails {
  @doc("Distinct references discovered from the target agent.")
  @minValue(0)
  discovered_skills_count?: int32;

  @doc("Distinct explicit references; these may overlap discovered references.")
  @minValue(0)
  additional_skills_count?: int32;

  @doc("Distinct references in the deduplicated effective baseline inventory.")
  @minValue(0)
  effective_skills_count?: int32;

  @doc("Selected trace conversations.")
  @minValue(0)
  selected_traces_count?: int32;

  @doc("Selected trace conversations with at least one matched human annotation.")
  @minValue(0)
  traces_with_human_annotations_count?: int32;

  @doc("Selected trace conversations with at least one matched evaluation result.")
  @minValue(0)
  traces_with_evaluation_results_count?: int32;

  @doc("Selected trace conversations with either feedback kind; overlap counts once.")
  @minValue(0)
  traces_with_feedback_count?: int32;

  @doc("Trace conversations retained after evidence preparation.")
  @minValue(0)
  prepared_traces_count?: int32;

  @doc("Trace conversations excluded at this step.")
  @minValue(0)
  excluded_traces_count?: int32;

  @doc("Trace conversations classified as successful.")
  @minValue(0)
  good_traces_count?: int32;

  @doc("Trace conversations classified as unsuccessful.")
  @minValue(0)
  bad_traces_count?: int32;

  @doc("Grounded learnings retained by this step.")
  @minValue(0)
  learnings_count?: int32;

  @doc("New skills selected by change planning.")
  @minValue(0)
  planned_creates_count?: int32;

  @doc("Existing skills selected for updates.")
  @minValue(0)
  planned_updates_count?: int32;

  @doc("Artifacts passing required package validation, not all optional checks.")
  @minValue(0)
  validated_skills_count?: int32;

  @doc("Artifacts rejected by validation.")
  @minValue(0)
  rejected_skills_count?: int32;

  @doc("Validated artifacts byte-identical to their exact baselines.")
  @minValue(0)
  no_change_skills_count?: int32;

  @doc("Versions confirmed created, not planned or uncertain writes.")
  @minValue(0)
  published_skills_count?: int32;
}

/** Latest recorded state of one logical step in the persisted execution snapshot. */
model AgentOptimizationSkillExecutionStep {
  @doc("Logical step name, unique within the snapshot.")
  name: AgentOptimizationSkillExecutionStepName;

  @doc("Recorded step state.")
  status: AgentOptimizationSkillExecutionStepStatus;

  @doc("Safe service-authored explanation, never raw model or trace content.")
  @maxLength(1024)
  summary?: string;

  @doc("Measured details for this step. Omitted when unavailable.")
  step_details?: AgentOptimizationSkillExecutionStepDetails;

  @doc("Safe failure or cancellation code, cleared when a retry starts or succeeds.")
  error_code?: string;
}

/** Persisted candidate execution snapshot, including partial runs. Not exposed on the job or candidate list response. */
model AgentOptimizationSkillExecutionSummary {
  @doc("Time the recorded execution facts last changed, as a UTC Unix timestamp in seconds.")
  updated_at: FoundryTimestamp;

  @doc("At most ten distinct steps in pipeline order. Older snapshots may omit collect_feedback.")
  @maxItems(10)
  steps: AgentOptimizationSkillExecutionStep[];
}
