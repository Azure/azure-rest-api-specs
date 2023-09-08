import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/provisioningstate.tsp";
import "../community/community.tsp";
import "../shared/resourceid.tsp";
import "../shared/managedresourcegroupconfiguration.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Enclave Virtual Network Properties")
model EnclaveVirtualNetwork {
  @doc("Network Size.")
  networkSize: string;

  @doc("Custom CIDR Range.")
  customCidrRange?: string;
}

@doc("Virtual Enclave Default Settings")
model EnclaveDefaultSettings {
  @doc("Key Vault Resource Id.")
  keyVaultResourceId?: KeyVaultResourceId;

  @doc("Log Analytics Resource Id.")
  logAnalyticsResourceId?: LogAnalyticsResourceId;

  @doc("Storage Account Resource Id.")
  storageAccountResourceId?: StorageAccountResourceId;
}

@doc("Virtual Enclave Resource properties")
model VirtualEnclaveProperties {
  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @removed(Microsoft.Mission.Versions.v2023_08_01_preview)
  @doc("Virtual Enclave Description.")
  description?: string;

  @doc("Provisioning State.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Virtual Network.")
  enclaveVirtualNetwork: EnclaveVirtualNetwork;

  @doc("Community Resource Id.")
  communityResourceId: CommunityResourceId;

  @doc("Default Settings")
  enclaveDefaultSettings?: EnclaveDefaultSettings;

  @doc("List of resource ids created by Virtual Enclave.")
  resourceCollection?: string[];

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @added(Microsoft.Mission.Versions.v2023_08_01_preview)
  @madeOptional(Microsoft.Mission.Versions.v2023_08_01_preview)
  @doc("Managed resource group configuration.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;
}
