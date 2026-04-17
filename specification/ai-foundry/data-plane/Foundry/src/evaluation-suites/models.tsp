import "@typespec/openapi";

import "../common/models.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Rest;
using OpenAPI;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Child models
// ---------------------------------------------------------------------------

@doc("""
  Reference to a dataset registered in the Foundry project.
  When datasetVersion is omitted the latest version is used.
  """)
model DatasetReference {
  @doc("Dataset name as registered in the Foundry project.")
  datasetName: string;

  @doc("Dataset version. Omit to use the latest version.")
  datasetVersion?: string;
}

@doc("""
  Reference to an agent for an evaluation suite.
  Provide either name (for Foundry agents) or id (for 3P agents), not both.
  """)
model EvaluationSuiteAgentReference {
  @doc("Foundry agent name. Mutually exclusive with id.")
  name?: string;

  @doc("3P agent identifier. Mutually exclusive with name.")
  id?: string;
}

@doc("""
  A testing criteria entry within an evaluation suite.
  Same shape as testing criteria on eval groups (azure_ai_evaluator grader type).
  """)
model EvaluationSuiteTestingCriteria {
  @doc("The grader type. Always 'azure_ai_evaluator' for Foundry evaluators.")
  type: string;

  @doc("Display name for this testing criteria entry. Must be unique within the suite.")
  name: string;

  @doc("""
    Evaluator name from the project's evaluator catalog.
    Supports both built-in evaluators (e.g. builtin.relevance, builtin.task_adherence)
    and custom evaluators registered in the catalog.
    """)
  evaluatorName: string;

  @doc("Evaluator version. Omit to use the latest version.")
  evaluatorVersion?: string;

  @doc("""
    Initialization parameters for the evaluator.
    Includes deployment_name (LLM judge model), threshold (pass/fail score), and
    any evaluator-specific parameters.
    """)
  initializationParameters?: Record<unknown>;

  @doc("""
    Maps dataset columns to evaluator inputs.
    For example, {"query": "{{item.query}}", "response": "{{item.response}}"}.
    """)
  dataMapping?: Record<string>;
}

// ---------------------------------------------------------------------------
// CRUD Resource model
// ---------------------------------------------------------------------------

@doc("""
  An evaluation suite bundles testing criteria — an optional dataset, one or more
  evaluator configs with thresholds and init params — into a reusable, named artifact that
  can gate agent changes across batch, scheduled, continuous, and CI/CD evals.
  """)
@resource("evaluationSuites")
model EvaluationSuiteVersion {
  @doc("""
    Human-readable display name.
    Does not need to be unique. Shown in portal list views and eval reports.
    """)
  displayName?: string;

  @doc("""
    Dataset reference for evaluation.
    Optional — omit for evaluator-only suites where data comes from
    live production traces or is provided at run time.
    The referenced dataset must exist in the project's dataset registry.
    """)
  dataset?: DatasetReference;

  @doc("Testing criteria. At least one entry is required.")
  @minItems(1)
  testingCriteria: EvaluationSuiteTestingCriteria[];

  @doc("""
    Agent reference for this evaluation suite.
    Optional — allows evaluation suites to exist before being linked to an agent,
    or to be used as shared baselines (e.g. safety checks).
    Provide either name (Foundry agents) or id (3P agents), not both.
    """)
  agentReference?: EvaluationSuiteAgentReference;

  // AssetBase provides: name (string, @key), version (string, read-only),
  // id (string, read-only), description (string, optional), tags (Record<string>, optional)
  ...AssetBase;
}

// ---------------------------------------------------------------------------
// Run API models
// ---------------------------------------------------------------------------

@doc("Request body for running an evaluation from a suite.")
model EvaluationSuiteRunRequest {
  @doc("Name for the eval group. Default: '{suiteName}-runs'.")
  groupName?: string;

  @doc("Suite version to run. Default: latest.")
  suiteVersion?: string;

  @doc("Evaluation level: 'turn' or 'conversation'. Optional.")
  evaluationLevel?: string;
}

@doc("Response from running an evaluation suite.")
model EvaluationSuiteRunResponse {
  @doc("The evaluation (group) ID created.")
  evaluationId: string;

  @doc("The eval run ID created.")
  runId: string;

  @doc("The eval group name.")
  groupName: string;

  @doc("The suite name used.")
  suiteName: string;

  @doc("The suite version resolved.")
  suiteVersion: string;

  @doc("Status of the run.")
  status: string;

  @doc("Unix timestamp when the run was created.")
  createdAt: int64;
}

// ---------------------------------------------------------------------------
// Generate API (LRO) models
// ---------------------------------------------------------------------------

@doc("Caller-supplied inputs for an evaluation suite generation job.")
model EvaluationSuiteGenerationJobInputs {
  @doc("The suite name to create.")
  name: string;

  @doc("Agent reference — the agent to generate evaluators and dataset for.")
  agentReference: EvaluationSuiteAgentReference;

  @doc("""
    Optional initialization parameters applied to all generated evaluators.
    For example, deployment_name for LLM judge model, default threshold.
    """)
  initializationParameters?: Record<unknown>;

  @doc("""
    Optional data mapping applied to all generated evaluators.
    Auto-inferred from evaluator data schema if not provided.
    """)
  dataMapping?: Record<string>;
}

@doc("Result produced by a successful evaluation suite generation job.")
model EvaluationSuiteGenerationJobResult {
  @doc("The created suite name.")
  suiteName: string;

  @doc("The created suite version.")
  suiteVersion: string;

  @doc("The generated evaluator name.")
  evaluatorName: string;

  @doc("The generated evaluator version.")
  evaluatorVersion: string;

  @doc("The generated dataset name.")
  datasetName?: string;

  @doc("The generated dataset version.")
  datasetVersion?: string;
}

@doc("Evaluation suite generation job resource.")
model EvaluationSuiteGenerationJob
  is JobLike<EvaluationSuiteGenerationJobResult, EvaluationSuiteGenerationJobInputs> {
  @doc("The timestamp when the job was created, represented in Unix time.")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("The timestamp when the job finished, represented in Unix time.")
  @visibility(Lifecycle.Read)
  finished_at?: FoundryTimestamp;
}
