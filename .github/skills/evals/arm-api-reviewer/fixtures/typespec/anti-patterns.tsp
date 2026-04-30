// TypeSpec fixture: Anti-patterns
// Seeded violations:
//   - Using {} instead of void for POST action body (no-empty-model)
//   - #suppress for no-empty-model instead of using void
//   - @flattenProperty on new API
//   - Default value on property that flows into PATCH model (RPC-Patch-V1-10)
//   - | null on a new property (not needed for new additions)
//   - enum values with underscores (In_Progress) instead of PascalCase

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Workflow Service",
})
@versioned(Versions)
namespace Microsoft.WorkflowService;

/** API versions */
enum Versions {
  /** 2025-01-01 version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2025_01_01: "2025-01-01",
}

@segment("workflows")
model Workflow is TrackedResource<WorkflowProperties> {
  @key("workflowName")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  name: string;
}

/** Properties of a workflow resource. */
model WorkflowProperties {
  /** The display name of the workflow. */
  displayName?: string;

  /** The provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  // Violation: default value flows into PATCH model (RPC-Patch-V1-10)
  /** The allocation method for IP addresses. */
  ipAllocationMethod?: IpAllocationMethod = IpAllocationMethod.Static;

  // Violation: | null on a new property (not needed for new additions)
  /** The description of the workflow. */
  description?: string | null;

  // Violation: @flattenProperty on new API
  /** Advanced configuration settings. */
  @flattenProperty
  advancedConfig?: AdvancedConfig;
}

/** The IP allocation method. */
union IpAllocationMethod {
  string,

  /** Static IP allocation. */
  Static: "Static",

  /** Dynamic IP allocation. */
  Dynamic: "Dynamic",
}

// Violation: enum values use underscores instead of PascalCase
/** The execution state of a workflow run. */
union ExecutionState {
  string,

  // Violation: underscore in union member value
  In_Progress: "In_Progress",

  /** Completed successfully. */
  Completed: "Completed",

  /** Failed. */
  FAILED: "FAILED",
}

/** Advanced configuration. */
model AdvancedConfig {
  /** Maximum retry count. */
  maxRetries?: int32;

  /** Timeout in seconds. */
  timeoutSeconds?: int32;
}

@armResourceOperations
interface Workflows {
  get is ArmResourceRead<Workflow>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Workflow>;
  update is ArmResourcePatchAsync<Workflow, WorkflowProperties>;
  delete is ArmResourceDeleteAsync<Workflow>;
  listByResourceGroup is ArmResourceListByParent<Workflow>;
  listBySubscription is ArmListBySubscription<Workflow>;

  // Violation: using {} instead of void for POST action body
  #suppress "@azure-tools/typespec-azure-core/no-empty-model" "Empty body needed"
  restart is ArmResourceActionAsync<Workflow, {}, void>;
}

interface Operations extends Azure.ResourceManager.Operations {}
