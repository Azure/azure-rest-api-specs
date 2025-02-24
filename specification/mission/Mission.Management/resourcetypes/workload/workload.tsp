import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/provisioningstate.tsp";
import "../shared/resourceid.tsp";
import "../virtualEnclave/virtualenclave.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Workload Resource properties")
model WorkloadProperties {
  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @removed(Microsoft.Mission.Versions.v2023_08_01_preview)
  @doc("Workload Description.")
  description?: string;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @removed(Microsoft.Mission.Versions.v2023_08_01_preview)
  @doc("Virtual Enclave Resource Id.")
  enclaveResourceId?: VirtualEnclaveResourceId;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @removed(Microsoft.Mission.Versions.v2023_11_01_preview)
  @doc("Managed Resource Groups.")
  managedResourceGroups?: string[];

  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @added(Microsoft.Mission.Versions.v2023_11_01_preview)
  @removed(Microsoft.Mission.Versions.v2024_06_01_preview)
  @doc("Managed resource group configuration.")
  managedResourceGroupConfiguration: ManagedResourceGroupConfiguration;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  @doc("List of resource group ids.")
  resourceGroupCollection?: string[];
}
