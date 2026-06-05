// TypeSpec fixture: x-ms-long-running-operation violations (TSP-EXT-LRO)
// Seeded violations:
//   - Custom PUT operation with @extension("x-ms-long-running-operation", true) (FORBIDDEN -- use ArmResourceCreateOrReplaceAsync)
//   - Custom DELETE operation with @extension("x-ms-long-running-operation", true) and
//     @extension("x-ms-long-running-operation-options", ...) (FORBIDDEN -- use ArmResourceDeleteAsync)
// Compliant patterns (positive controls -- should NOT be flagged):
//   - ArmResourceCreateOrReplaceAsync for async PUT
//   - ArmResourceDeleteAsync for async DELETE
//   - ArmResourceActionAsync for async POST action

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
  title: "Compute Service",
})
@versioned(Versions)
namespace Microsoft.ComputeService;

/** API versions */
enum Versions {
  /** 2025-01-01 version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2025_01_01: "2025-01-01",
}

@segment("virtualMachines")
model VirtualMachine is TrackedResource<VirtualMachineProperties> {
  @key("vmName")
  @pattern("^[a-zA-Z0-9-]{1,64}$")
  name: string;
}

/** Properties of a virtual machine. */
model VirtualMachineProperties {
  /** The VM size. */
  vmSize?: string;

  /** The provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

/** Request body for a restart action. */
model RestartRequest {
  /** Whether to force the restart. */
  force?: boolean;
}

@segment("disks")
model Disk is TrackedResource<DiskProperties> {
  @key("diskName")
  @pattern("^[a-zA-Z0-9-]{1,80}$")
  name: string;
}

/** Properties of a disk. */
model DiskProperties {
  /** Disk size in GB. */
  diskSizeGB?: int32;

  /** The provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@armResourceOperations
interface VirtualMachines {
  // Positive control #1: ArmResourceCreateOrReplaceAsync is correct -- should NOT be flagged.
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VirtualMachine>;

  get is ArmResourceRead<VirtualMachine>;
  update is ArmResourcePatchAsync<VirtualMachine, VirtualMachineProperties>;

  // Positive control #2: ArmResourceDeleteAsync is correct -- should NOT be flagged.
  delete is ArmResourceDeleteAsync<VirtualMachine>;

  listByResourceGroup is ArmResourceListByParent<VirtualMachine>;
  listBySubscription is ArmListBySubscription<VirtualMachine>;

  // Positive control #3: ArmResourceActionAsync is correct -- should NOT be flagged.
  restart is ArmResourceActionAsync<VirtualMachine, RestartRequest, void>;
}

@armResourceOperations
interface Disks {
  get is ArmResourceRead<Disk>;

  // Violation #1: manual createOrUpdate with @extension("x-ms-long-running-operation", true) is FORBIDDEN.
  // Correct fix: use ArmResourceCreateOrReplaceAsync<Disk> instead.
  @put
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ComputeService/disks/{diskName}")
  @extension("x-ms-long-running-operation", true)
  createOrUpdate(
    @path subscriptionId: string,
    @path resourceGroupName: string,
    @path diskName: string,
    @body body: Disk,
  ): Disk | ArmAcceptedLroResponse;

  // Violation #2: manual delete with @extension("x-ms-long-running-operation", true) and
  // @extension("x-ms-long-running-operation-options", ...) is FORBIDDEN.
  // Correct fix: use ArmResourceDeleteAsync<Disk> instead.
  @delete
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ComputeService/disks/{diskName}")
  @extension("x-ms-long-running-operation", true)
  @extension("x-ms-long-running-operation-options", #{ "final-state-via": "azure-async-operation" })
  delete(
    @path subscriptionId: string,
    @path resourceGroupName: string,
    @path diskName: string,
  ): ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse;

  listByResourceGroup is ArmResourceListByParent<Disk>;
  listBySubscription is ArmListBySubscription<Disk>;
}

interface Operations extends Azure.ResourceManager.Operations {}
