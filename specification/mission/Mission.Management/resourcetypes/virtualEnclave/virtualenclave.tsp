// cspell:enableCompoundWords
// cspell:words managedonbehalfofconfiguration

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
import "../shared/managedonbehalfofconfiguration.tsp";

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
model EnclaveVirtualNetworkModel {
  @doc("Network Name.")
  name?: string;

  @doc("Network Size.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkSize?: string;

  @doc("Custom CIDR Range.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  customCidrRange?: string;

  @doc("Subnet Configurations.")
  subnetConfigurations?: SubnetConfiguration[];

  @doc("Allow Subnet Communication.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  allowSubnetCommunication?: boolean = false;

  @doc("Connect to Azure Services (True or False).")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  connectToAzureServices?: boolean = false;
}

@doc("Virtual Enclave Default Settings")
model EnclaveDefaultSettings {
  @doc("Key Vault Resource Id.")
  @visibility(Lifecycle.Read)
  keyVaultResourceId?: KeyVaultResourceId;

  @doc("Storage Account Resource Id.")
  @visibility(Lifecycle.Read)
  storageAccountResourceId?: StorageAccountResourceId;

  @doc("Log Analytics Resource Ids.")
  @visibility(Lifecycle.Read)
  logAnalyticsResourceIdCollection?: LogAnalyticsResourceId[];

  @doc("Diagnostic Destination.")
  diagnosticDestination?: DiagnosticDestination = DiagnosticDestination.EnclaveOnly;
}

@doc("Enclave Address Spaces")
model EnclaveAddressSpacesModel {
  @doc("Enclave Address Space")
  enclaveAddressSpace?: string;

  @doc("Managed Address Space")
  managedAddressSpace?: string;
}

@doc("Maintenance Mode")
model MaintenanceModeConfigurationModel {
  @doc("Current mode of Maintenance Mode Configuration")
  mode: "On" | "CanNotDelete" | "Off" | "General" | "Advanced" | string = "Off";

  @doc("The user, group or service principal object affected by Maintenance Mode")
  principals?: Principal[] = #[];

  @doc("Justification for entering or exiting Maintenance Mode")
  justification?: "Networking" | "Governance" | "Off" | string = "Off";
}

@doc("Virtual Enclave Resource properties")
model VirtualEnclaveModel {
  @doc("Provisioning State.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Virtual Network.")
  enclaveVirtualNetwork: EnclaveVirtualNetworkModel;

  @visibility(Lifecycle.Read)
  @doc("Enclave Address Spaces")
  enclaveAddressSpaces?: EnclaveAddressSpacesModel;

  @doc("Community Resource Id.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  communityResourceId: CommunityResourceIdScalar;

  @doc("List of resource ids created by Virtual Enclave.")
  @visibility(Lifecycle.Read)
  resourceCollection?: armResourceIdentifier[];

  @doc("Managed resource group configuration.")
  @visibility(Lifecycle.Read)
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @added(Microsoft.Mission.Versions.v2025_05_01_preview)
  @visibility(Lifecycle.Read)
  @doc("Managed On Behalf Of Configuration.")
  managedOnBehalfOfConfiguration?: ManagedOnBehalfOfConfiguration;

  @doc("Deploy Bastion service (True or False).")
  bastionEnabled?: boolean = false;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Enclave role assignments")
  enclaveRoleAssignments?: RoleAssignmentItem[];

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Workload role assignments")
  workloadRoleAssignments?: RoleAssignmentItem[];

  @added(Microsoft.Mission.Versions.v2025_05_01_preview)
  @doc("Enclave specific policies")
  governedServiceList?: GovernedServiceItem[];

  @doc("Maintenance Mode configuration.")
  maintenanceModeConfiguration?: MaintenanceModeConfigurationModel;

  @doc("Default Settings")
  enclaveDefaultSettings?: EnclaveDefaultSettings;
}

@doc("Virtual Enclave Patch Model")
@withoutDefaultValues
model VirtualEnclavePatchModel {
  @doc("Virtual Enclave Patch properties")
  properties?: Update<VirtualEnclaveModel>;

  ...ManagedServiceIdentityProperty;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}
