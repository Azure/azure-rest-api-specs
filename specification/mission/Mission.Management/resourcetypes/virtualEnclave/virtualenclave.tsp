import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/provisioningstate.tsp";
import "../community/community.tsp";
import "../shared/resourceid.tsp";
import "../shared/managedresourcegroupconfiguration.tsp";
import "../shared/principal.tsp";
import "../shared/roleassignmentitem.tsp";

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
  @visibility(Lifecycle.Read)
  id?: SubnetResourceId;

  @doc("Network prefix size.")
  networkPrefixSize: int32;

  @doc("Subnet delegation.")
  subnetDelegation?: string;

  @doc("Address prefix.")
  @visibility(Lifecycle.Read)
  addressPrefix?: string;

  @doc("Network security group ID.")
  @visibility(Lifecycle.Read)
  networkSecurityGroupId?: NsgResourceId;
}

@doc("Enclave Virtual Network Properties")
model EnclaveVirtualNetwork {
  @doc("Network Name.")
  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  name?: string;

  @doc("Network Size.")
  networkSize?: string;

  @doc("Custom CIDR Range.")
  customCidrRange?: string;

  @doc("Subnet Configurations.")
  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  subnetConfigurations?: SubnetConfiguration[];

  @doc("Allow Subnet Communication.")
  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  allowSubnetCommunication?: boolean;

  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  @doc("Connect to Azure Services (True or False).")
  connectToAzureServices?: boolean;
}

@doc("Virtual Enclave Default Settings")
model EnclaveDefaultSettings {
  @doc("Key Vault Resource Id.")
  keyVaultResourceId?: KeyVaultResourceId;

  @doc("Storage Account Resource Id.")
  storageAccountResourceId?: StorageAccountResourceId;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "Adding required property is a breaking change."
  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  @doc("Log Analytics Resource Ids.")
  logAnalyticsResourceIdCollection?: LogAnalyticsResourceId[];

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "Adding required property is a breaking change."
  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  @doc("Diagnostic Destination.")
  diagnosticDestination?: DiagnosticDestination;
}

@doc("Enclave Address Spaces")
model EnclaveAddressSpaces {
  @doc("Enclave Address Space")
  enclaveAddressSpace?: string;

  @doc("Managed Address Space")
  managedAddressSpace?: string;
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
  @doc("Provisioning State.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Virtual Network.")
  enclaveVirtualNetwork: EnclaveVirtualNetwork;

  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  @visibility(Lifecycle.Read)
  @doc("Enclave Address Spaces")
  enclaveAddressSpaces?: EnclaveAddressSpaces;

  @doc("Community Resource Id.")
  communityResourceId: CommunityResourceId;

  @doc("Default Settings")
  enclaveDefaultSettings?: EnclaveDefaultSettings;

  @doc("List of resource ids created by Virtual Enclave.")
  resourceCollection?: armResourceIdentifier[];

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @doc("Managed resource group configuration.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @doc("Maintenance Mode configuration.")
  maintenanceModeConfiguration?: MaintenanceModeConfiguration;

  @doc("Deploy Bastion service (True or False).")
  bastionEnabled?: boolean;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @madeOptional(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Enclave role assignments")
  enclaveRoleAssignments?: RoleAssignmentItem[];

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @madeOptional(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Workload role assignments")
  workloadRoleAssignments?: RoleAssignmentItem[];
}

@doc("Virtual Enclave Patch properties")
model VirtualEnclavePatchProperties is VirtualEnclaveProperties;

@doc("Virtual Enclave Patch Resource")
model VirtualEnclavePatchResource {
  @doc("Virtual Enclave Patch properties")
  properties?: Update<VirtualEnclavePatchProperties>;

  ...ManagedServiceIdentityProperty;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}
