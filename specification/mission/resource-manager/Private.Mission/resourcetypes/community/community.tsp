import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/provisioningstate.tsp";
import "../shared/resourceid.tsp";
import "../shared/managedresourcegroupconfiguration.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@doc("Community Resource Properties")
model CommunityProperties {
  @doc("Address Space.")
  addressSpace?: string;

  @doc("Dns Servers.")
  dnsServers?: string[];

  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("List of resource ids created by communities.")
  resourceCollection?: string[];

  @doc("Managed resource group configuration.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;
}
