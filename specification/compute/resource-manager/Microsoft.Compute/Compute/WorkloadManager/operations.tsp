import "@azure-tools/typespec-azure-resource-manager";
using Azure.ResourceManager;

namespace Microsoft.Compute.WorkloadManager;

@armResourceOperations
interface WorkloadSpaces {
  get is ArmResourceRead<WorkloadSpace>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<WorkloadSpace>;
  update is ArmResourcePatchAsync<WorkloadSpace, TrackedResourceUpdate>;
  delete is ArmResourceDeleteWithoutOkAsync<WorkloadSpace>;
  listByResourceGroup is ArmResourceListByParent<WorkloadSpace>;
  listBySubscription is ArmListBySubscription<WorkloadSpace>;
}

@armResourceOperations
interface RuntimeBindings {
  get is ArmResourceRead<RuntimeBinding>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<RuntimeBinding>;
  update is ArmResourcePatchAsync<RuntimeBinding, TrackedResourceUpdate>;
  delete is ArmResourceDeleteWithoutOkAsync<RuntimeBinding>;
  listByWorkloadSpace is ArmResourceListByParent<RuntimeBinding>;
}

@armResourceOperations
interface RuntimeLinks {
  get is ArmResourceRead<RuntimeLink>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<RuntimeLink>;
  update is ArmResourcePatchAsync<RuntimeLink, TrackedResourceUpdate>;
  delete is ArmResourceDeleteWithoutOkAsync<RuntimeLink>;
  listByWorkloadSpace is ArmResourceListByParent<RuntimeLink>;
}

@armResourceOperations
interface Capabilities {
  get is ArmResourceRead<Capability>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Capability>;
  update is ArmResourcePatchAsync<Capability, TrackedResourceUpdate>;
  delete is ArmResourceDeleteWithoutOkAsync<Capability>;
  listByWorkloadSpace is ArmResourceListByParent<Capability>;
}
