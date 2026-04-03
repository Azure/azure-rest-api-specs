import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "../common/models.tsp";
import "../main.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Enums
// ---------------------------------------------------------------------------

@doc("The kind of evaluation suite, determining its composition.")
@added(Versions.v2025_10_15_preview)
union EvaluationSuiteKind {
  string,

  @doc("""
    Evaluation suite backed by a dataset.
    Evaluators run against dataset rows. Used for batch, scheduled, or CI/CD evals.
    """)
  DatasetBacked: "dataset_backed",

  @doc("""
    Evaluation suite with evaluators only, no dataset.
    Evaluators run against live production traces.
    """)
  EvaluatorOnly: "evaluator_only",
}

// ---------------------------------------------------------------------------
// Child models
// ---------------------------------------------------------------------------

@doc("""
  Reference to a dataset registered in the Foundry project.
  When datasetVersion is omitted the latest version is used.
  """)
@added(Versions.v2025_10_15_preview)
model DatasetReference {
  @doc("Dataset name as registered in the Foundry project.")
  datasetName: string;

  @doc("Dataset version. Omit to use the latest version.")
  datasetVersion?: string;
}

@doc("Configuration for an evaluator within an evaluation suite.")
@added(Versions.v2025_10_15_preview)
model EvaluationSuiteEvaluator {
  @doc("""
    Evaluator name from the project's evaluator catalog.
    Supports both built-in evaluators (e.g. coherence, fluency, task_adherence)
    and custom evaluators registered in the catalog.
    """)
  evaluatorName: string;

  @doc("""
    Pass/fail threshold. Scores >= threshold pass.
    Omit for informational-only evaluators that report a score
    without gating the evaluation suite result.
    """)
  threshold?: float64;
}

// ---------------------------------------------------------------------------
// Resource model
// ---------------------------------------------------------------------------

@doc("""
  An evaluation suite bundles evaluation criteria — an optional dataset, one or more
  evaluators, and pass/fail thresholds — into a reusable, named artifact that
  can gate agent changes across batch, scheduled, continuous, and CI/CD evals.
  """)
@resource("evaluationSuites")
@added(Versions.v2025_10_15_preview)
model EvaluationSuiteVersion {
  @doc("""
    Human-readable display name.
    Does not need to be unique. Shown in portal list views and eval reports.
    """)
  displayName?: string;

  @doc("""
    Evaluation suite kind.
    Batch: requires a dataset reference; evaluators run against dataset rows.
    Continuous: evaluators only; data comes from live production traces.
    """)
  kind: EvaluationSuiteKind;

  @doc("""
    Dataset reference for offline evaluation.
    Required when kind is batch. Must be null when kind is continuous.
    The referenced dataset must exist in the project's dataset registry.
    """)
  dataset?: DatasetReference;

  @doc("Evaluator configurations. At least one is required.")
  @minItems(1)
  evaluators: EvaluationSuiteEvaluator[];

  @doc("""
    Name of the agent this evaluation suite is associated with.
    Optional — allows evaluation suites to exist before being linked to an agent,
    or to be used as shared baselines (e.g. safety checks).
    """)
  agentName?: string;

  // AssetBase provides: name (string, @key), version (string, read-only),
  // id (string, read-only), description (string, optional), tags (Record<string>, optional)
  ...AssetBase;
}
