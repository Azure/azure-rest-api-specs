import "@azure-tools/typespec-azure-resource-manager";
using Azure.ResourceManager;

namespace Microsoft.Compute.WorkloadManager;

/** Manages workload spaces. */
@armResourceOperations
interface WorkloadSpaces {
  /** Gets a workload space. */
  get is ArmResourceRead<WorkloadSpace>;

  /** Creates or replaces a workload space. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<WorkloadSpace>;

  /** Updates mutable workload space properties. */
  update is ArmCustomPatchAsync<WorkloadSpace, WorkloadSpaceUpdate>;

  /** Deletes a workload space and its owned resources. */
  delete is ArmResourceDeleteWithoutOkAsync<WorkloadSpace>;

  /** Lists workload spaces in a resource group. */
  listByResourceGroup is ArmResourceListByParent<WorkloadSpace>;

  /** Lists workload spaces in a subscription. */
  listBySubscription is ArmListBySubscription<WorkloadSpace>;
}

/** Manages runtime bindings within a workload space. */
@armResourceOperations
interface RuntimeBindings {
  /** Gets a runtime binding. */
  get is ArmResourceRead<RuntimeBinding>;

  /** Creates or replaces a runtime binding. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<RuntimeBinding>;

  /** Updates mutable runtime binding properties. */
  update is ArmCustomPatchAsync<RuntimeBinding, RuntimeBindingUpdate>;

  /** Deletes a runtime binding without deleting customer-owned referenced resources. */
  delete is ArmResourceDeleteWithoutOkAsync<RuntimeBinding>;

  /** Lists runtime bindings in a workload space. */
  listByWorkloadSpace is ArmResourceListByParent<RuntimeBinding>;
}

/** Manages runtime links within a workload space. */
@armResourceOperations
interface RuntimeLinks {
  /** Gets a runtime link. */
  get is ArmResourceRead<RuntimeLink>;

  /** Creates or replaces a runtime link. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<RuntimeLink>;

  /** Updates mutable runtime link properties. */
  update is ArmCustomPatchAsync<RuntimeLink, RuntimeLinkUpdate>;

  /** Deletes a runtime link without deleting its runtime bindings. */
  delete is ArmResourceDeleteWithoutOkAsync<RuntimeLink>;

  /** Lists runtime links in a workload space. */
  listByWorkloadSpace is ArmResourceListByParent<RuntimeLink>;
}

/** Manages capabilities within a workload space. */
@armResourceOperations
interface Capabilities {
  /** Gets a capability. */
  get is ArmResourceRead<Capability>;

  /** Creates or replaces a capability. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Capability>;

  /** Updates mutable capability properties. */
  update is ArmCustomPatchAsync<Capability, CapabilityUpdate>;

  /** Disables and deletes a capability. */
  delete is ArmResourceDeleteWithoutOkAsync<Capability>;

  /** Lists capabilities in a workload space. */
  listByWorkloadSpace is ArmResourceListByParent<Capability>;
}
