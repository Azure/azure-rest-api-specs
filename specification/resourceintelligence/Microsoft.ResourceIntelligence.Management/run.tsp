import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./thread.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.ResourceIntelligence;

// ============================================
// RUN RESOURCE
// ============================================

/**
 * A single execution run on a thread. Tracks run status, timing, and results.
 */
@parentResource(Thread)
model Run is ProxyResource<RunProperties> {
  /**
   * The unique identifier of the run.
   */
  @key("runId")
  @segment("runs")
  @pattern("^(?!latest$)[a-zA-Z0-9-]{1,64}$")
  @path
  name: string;
}

/**
 * Properties of a Run resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Runs use a custom status field for lifecycle tracking; provisioningState is not applicable."
model RunProperties {
  /**
   * The lifecycle status of the run.
   */
  @visibility(Lifecycle.Read)
  status?: RunStatus;

  /**
   * The timestamp when the run started.
   */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /**
   * The timestamp when the run completed.
   */
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  /**
   * Error details if the run failed.
   */
  @visibility(Lifecycle.Read)
  error?: RunError;
}

/**
 * Error details for a failed run.
 */
model RunError {
  /**
   * The error code.
   */
  code: string;

  /**
   * The error message.
   */
  message: string;
}

// ============================================
// RUN OPERATIONS
// ============================================

@armResourceOperations
interface Runs {
  /**
   * Gets a run by ID.
   */
  get is ArmResourceRead<Run>;

  /**
   * Lists runs for a thread.
   */
  listByParent is ArmResourceListByParent<Run>;
}
