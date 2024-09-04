import "@typespec/rest";
import "@typespec/versioning";
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

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Specifies the destination of where to store diagnostic logs.")
union DiagnosticDestination {
  @doc("DiagnosticDestination Type CommunityOnly")
  CommunityOnly: "CommunityOnly",

  @doc("DiagnosticDestination Type EnclaveOnly")
  EnclaveOnly: "EnclaveOnly",

  @doc("DiagnosticDestination Type Both")
  Both: "Both",

  string,
}

@doc("Subnet Configuration")
@added(Microsoft.Mission.Versions.v2024_06_01_preview)
model SubnetConfiguration {
  @doc("Subnet name.")
  name: string;

  @doc("Subnet ID.")
  @visibility("read")
  id?: Azure.Core.armResourceIdentifier;

  @doc("Network prefix size.")
  networkPrefixSize: int32;

  @doc("Subnet delegation.")
  subnetDelegation?: string;

  @doc("Address prefix.")
  @visibility("read")
  addressPrefix?: string;

  @doc("Network security group ID.")
  @visibility("read")
  networkSecurityGroupId?: Azure.Core.armResourceIdentifier;
}

@doc("Enclave Virtual Network Properties")
model EnclaveVirtualNetwork {
  @doc("Network Name.")
  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  name?: string;

  @doc("Network Size.")
  networkSize: string;

  @doc("Custom CIDR Range.")
  customCidrRange?: string;

  @doc("Subnet Configurations.")
  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  subnetConfigurations?: SubnetConfiguration[];

  @doc("Allow Subnet Communication.")
  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  allowSubnetCommunication?: boolean;

  @added(Microsoft.Mission.Versions.v2024_01_01_preview)
  @doc("Connect to Azure Services (True or False).")
  connectToAzureServices?: boolean;
}

@doc("Virtual Enclave Default Settings")
model EnclaveDefaultSettings {
  @doc("Key Vault Resource Id.")
  keyVaultResourceId?: KeyVaultResourceId;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @removed(Microsoft.Mission.Versions.v2024_01_01_preview)
  @doc("Log Analytics Resource Id.")
  logAnalyticsResourceId?: LogAnalyticsResourceId;

  @doc("Storage Account Resource Id.")
  storageAccountResourceId?: StorageAccountResourceId;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "Adding required property is a breaking change."
  @added(Microsoft.Mission.Versions.v2024_01_01_preview)
  @doc("Log Analytics Resource Ids.")
  logAnalyticsResourceIdCollection?: LogAnalyticsResourceId[];

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "Adding required property is a breaking change."
  @added(Microsoft.Mission.Versions.v2024_01_01_preview)
  @doc("Diagnostic Destination.")
  diagnosticDestination?: DiagnosticDestination;
}

@doc("Enclave Address Spaces")
model EnclaveAddressSpaces {
  @madeOptional(Microsoft.Mission.Versions.v2024_06_01_preview)
  @doc("Enclave Address Space")
  enclaveAddressSpace?: string;

  @madeOptional(Microsoft.Mission.Versions.v2024_06_01_preview)
  @doc("Managed Address Space")
  managedAddressSpace?: string;
}

@added(Microsoft.Mission.Versions.v2024_06_01_preview)
@doc("Principal for Maintenance Mode")
model Principal {
  @doc("The object id associated with the principal")
  id: string;

  @doc("The type of the object id. We currently allow users, groups, and service principals")
  type: "User" | "Group" | "ServicePrincipal" | string;
}

@added(Microsoft.Mission.Versions.v2024_06_01_preview)
@doc("Maintenance Mode")
model MaintenanceModeConfiguration {
  @doc("Current mode of Maintenance Mode Configuration")
  mode: "On" | "CanNotDelete" | "Off" | string;

  @doc("The user, group or service principal object affected by Maintenance Mode")
  principals?: Principal[];

  @doc("Justification for entering or exiting Maintenance Mode")
  justification?: "Networking" | "Governance" | "Off" | string;
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

  @added(Microsoft.Mission.Versions.v2023_08_01_preview)
  @visibility("read")
  @doc("Enclave Address Spaces")
  enclaveAddressSpaces?: EnclaveAddressSpaces;

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

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  @doc("Maintenance Mode configuration.")
  maintenanceModeConfiguration?: MaintenanceModeConfiguration;

  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  @doc("Deploy Bastion service (True or False).")
  bastionEnabled?: boolean;
}
