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

/** Base validation category; reporting-only performance scores use the baseline and generated candidate evaluation summaries. */
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
  @doc("Validation or publication outcome.")
  status: AgentOptimizationSkillResultStatus;

  @doc("Exact input baseline when updating or retaining an existing skill, with the same name as output_skill. Omitted when creating a new skill.")
  input_skill?: AgentOptimizationFoundrySkillReference;

  @doc("Intended identity for every result. A confirmed version appears only with status created; no_change retains the baseline version only in input_skill.")
  output_skill: AgentOptimizationFoundrySkillOutputReference;

  @doc("Safe, human-readable explanation of why this skill was proposed or retained, grounded in the selected evidence. Omitted until available. Must not include sensitive trace excerpts or hidden model reasoning.")
  rationale?: string;

  @doc("Artifact checks, including rejections. Absence does not imply success. Candidate evaluation is reported through AgentOptimizationCandidate.evaluation and is not included in per-skill validations.")
  validations?: AgentOptimizationSkillValidation[];

  @doc("Primary failure, rejection, or uncertain-publication reason. Detailed findings remain in validations. Omitted when there is no error.")
  error?: AgentOptimizationSkillResultError;
}

/** Frozen evidence and discovered baselines, without duplicating requested job configuration. */
model AgentOptimizationSkillResolvedContext {
  @doc("Complete evidence cohort, including traces that produced no artifact. Omitted before resolution; an empty array means a resolved empty cohort.")
  source_trace_ids?: string[];

  @doc("Deduplicated exact baselines discovered from the agent and its toolboxes. Excludes skills supplied only through skill_references context items and does not imply invocation. Omitted before discovery; empty when none were discovered or the job is agentless.")
  agent_skills?: AgentOptimizationFoundrySkillReference[];
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

/** Latest recorded state of one logical step in the persisted execution snapshot. */
model AgentOptimizationSkillExecutionStep {
  @doc("Service-authored logical step name, unique within the snapshot, for example resolve_inputs, collect_traces, or publish_skills. Consumers must tolerate unfamiliar names.")
  name: string;

  @doc("Recorded step state.")
  status: AgentOptimizationSkillExecutionStepStatus;

  @doc("Safe service-authored explanation, never raw model or trace content.")
  @maxLength(1024)
  summary?: string;

  @doc("Step-specific JSON key/value details, with arbitrary JSON values rather than a fixed property schema. Omitted when unavailable. Never include sensitive trace or model content.")
  step_details?: Record<unknown>;

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
