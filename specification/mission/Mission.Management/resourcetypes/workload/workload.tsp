// cspell:enableCompoundWords
// cspell:words managedonbehalfofconfiguration

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Workload Resource properties")
model WorkloadProperties {
  @doc("Provisioning State.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @doc("List of resource group ids.")
  resourceGroupCollection?: string[];

  @added(Microsoft.Mission.Versions.v2025_05_01_preview)
  @doc("Managed On Behalf Of Configuration.")
  @visibility(Lifecycle.Read)
  managedOnBehalfOfConfiguration?: CommonTypes.ManagedOnBehalfOfConfiguration;
}

@doc("Workload Patch Resource")
@withoutDefaultValues
model WorkloadPatchModel {
  @doc("Workload Patch properties")
  properties?: Update<WorkloadProperties>;

  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}
