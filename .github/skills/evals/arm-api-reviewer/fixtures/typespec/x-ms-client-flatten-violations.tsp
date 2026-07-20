// TypeSpec fixture: x-ms-client-flatten violations (TSP-EXT-FLATTEN)
// Seeded violations:
//   - @extension("x-ms-client-flatten", true) on a new API property (FORBIDDEN -- do not flatten new APIs)
//   - @extension("x-ms-client-flatten", true) on a pre-existing property (FORBIDDEN -- use @flattenProperty)
// Compliant patterns (positive controls -- should NOT be flagged):
//   - @flattenProperty on a pre-existing property (backward-compat only)
//   - No flattening on a new property (preferred)

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
  title: "Virtual Machine Service",
})
@versioned(Versions)
namespace Microsoft.VirtualMachineService;

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
  /** The provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  // Violation #1: @extension("x-ms-client-flatten", true) on a new API property is FORBIDDEN.
  // For new APIs, do not flatten at all. Remove both the @extension and any flattening intent.
  /** Network interface configuration (new property -- do not flatten). */
  @extension("x-ms-client-flatten", true)
  networkConfig?: NetworkConfig;

  // Violation #2: @extension("x-ms-client-flatten", true) on a pre-existing property is FORBIDDEN.
  // For backward-compat with a pre-existing flattened property, use @flattenProperty instead.
  /** Storage profile (pre-existing, flattened for backward compat -- must use @flattenProperty). */
  @extension("x-ms-client-flatten", true)
  storageProfile?: StorageProfile;

  // Positive control #1: @flattenProperty for backward compat is correct -- should NOT be flagged.
  /** Hardware profile (pre-existing, preserved via @flattenProperty). */
  @flattenProperty
  hardwareProfile?: HardwareProfile;

  // Positive control #2: nested property without flattening is correct for new APIs -- should NOT be flagged.
  /** OS profile (new property, kept nested). */
  osProfile?: OsProfile;
}

/** Network interface configuration. */
model NetworkConfig {
  /** The virtual network name. */
  vnetName?: string;

  /** The subnet name. */
  subnetName?: string;
}

/** Storage profile for a VM. */
model StorageProfile {
  /** OS disk size in GB. */
  osDiskSizeGB?: int32;

  /** Data disk count. */
  dataDiskCount?: int32;
}

/** Hardware profile for a VM. */
model HardwareProfile {
  /** The VM size SKU. */
  vmSize?: string;
}

/** OS profile for a VM. */
model OsProfile {
  /** Computer name. */
  computerName?: string;

  /** Admin username. */
  adminUsername?: string;
}

@armResourceOperations
interface VirtualMachines {
  get is ArmResourceRead<VirtualMachine>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VirtualMachine>;
  update is ArmResourcePatchAsync<VirtualMachine, VirtualMachineProperties>;
  delete is ArmResourceDeleteAsync<VirtualMachine>;
  listByResourceGroup is ArmResourceListByParent<VirtualMachine>;
  listBySubscription is ArmListBySubscription<VirtualMachine>;
}

interface Operations extends Azure.ResourceManager.Operations {}
