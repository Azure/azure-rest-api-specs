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

@doc("The kind of test suite, determining its intended evaluation mode.")
@added(Versions.v2025_10_15_preview)
union TestSuiteKind {
  string,

  @doc("""
    Offline evaluation backed by a dataset.
    Used for batch, scheduled, or CI/CD evals.
    """)
  Batch: "batch",

  @doc("""
    Online evaluation with no dataset.
    Evaluators run against live production traces.
    """)
  Continuous: "continuous",
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

@doc("Configuration for an evaluator within a test suite.")
@added(Versions.v2025_10_15_preview)
model TestSuiteEvaluator {
  @doc("""
    Evaluator name from the project's evaluator catalog.
    Supports both built-in evaluators (e.g. coherence, fluency, task_adherence)
    and custom evaluators registered in the catalog.
    """)
  evaluatorName: string;

  @doc("""
    Pass/fail threshold. Scores >= threshold pass.
    Omit for informational-only evaluators that report a score
    without gating the test suite result.
    """)
  threshold?: float64;
}

// ---------------------------------------------------------------------------
// Resource model
// ---------------------------------------------------------------------------

@doc("""
  A test suite bundles evaluation criteria — an optional dataset, one or more
  evaluators, and pass/fail thresholds — into a reusable, named artifact that
  can gate agent changes across batch, scheduled, continuous, and CI/CD evals.
  """)
@resource("testSuites")
@added(Versions.v2025_10_15_preview)
model TestSuite {
  @doc("Unique identifier of the test suite within the project.")
  @key("id")
  @encodedName("application/json", "id")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("""
    Human-readable display name.
    Does not need to be unique. Shown in portal list views and eval reports.
    """)
  displayName?: string;

  @doc("Description of what this test suite validates.")
  description?: string;

  @doc("""
    Test suite kind.
    Batch: requires a dataset reference; evaluators run against dataset rows.
    Continuous: evaluators only; data comes from live production traces.
    """)
  kind: TestSuiteKind;

  @doc("""
    Dataset reference for offline evaluation.
    Required when kind is batch. Must be null when kind is continuous.
    The referenced dataset must exist in the project's dataset registry.
    """)
  dataset?: DatasetReference;

  @doc("Evaluator configurations. At least one is required.")
  @minItems(1)
  evaluators: TestSuiteEvaluator[];

  @doc("""
    Name of the agent this test suite is associated with.
    Optional — allows test suites to exist before being linked to an agent,
    or to be used as shared baselines (e.g. safety checks).
    """)
  agentName?: string;

  @doc("""
    Whether this test suite is active.
    Disabled test suites are skipped by continuous eval rules and CI/CD gates.
    """)
  enabled?: boolean;

  @doc("Test suite's tags. Tags are fully mutable and can be used for filtering.")
  tags?: Record<string>;

  @doc("Test suite's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed.")
  properties?: Record<string>;

  @visibility(Lifecycle.Read)
  @doc("System metadata for the resource.")
  systemData: Record<string>;
}
