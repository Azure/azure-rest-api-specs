import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/provisioningstate.tsp";
import "../shared/resourceid.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@doc("EnclaveListItem Properties")
model EnclaveListItem {
  @doc("virtual enclave name.")
  name?: string;

  @doc("virtual enclaves resource id.")
  id?: VirtualEnclaveResourceId;

  @doc("creation datetime.")
  creationDatetime?: string;

  @doc("created by.")
  createdBy?: string;

  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Community Resource Properties")
model CommunityProperties {
  @doc("Community Description.")
  description?: string;

  @doc("Address Space.")
  addressSpace?: string;

  @doc("Dns Servers.")
  dnsServers?: string[];

  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("List of resource ids created by communities.")
  resourceCollection?: string[];

  @doc("List of virtual enclaves that a community contains.")
  virtualEnclaveList?: EnclaveListItem[];

  @doc("Dictionary of virtual enclaves that a community contains.")
  virtualEnclaveCollection?: Record<EnclaveListItem>;
}