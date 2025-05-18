// cspell:enableCompoundWords
// cspell:words managedonbehalfofconfiguration

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "../shared/maintenancemodeconfiguration.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Specifies the destination of where to store diagnostic logs.")
union DiagnosticDestination {
  string,

  @doc("DiagnosticDestination Type CommunityOnly")
  CommunityOnly: "CommunityOnly",

  @doc("DiagnosticDestination Type EnclaveOnly")
  EnclaveOnly: "EnclaveOnly",

  @doc("DiagnosticDestination Type Both")
  Both: "Both",
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

@doc("Enclave Virtual Network Properties")
@withoutDefaultValues
model EnclaveVirtualNetworkPatchModel is EnclaveVirtualNetworkModel;

@doc("Virtual Enclave Default Settings")
model EnclaveDefaultSettingsModel {
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

@doc("Virtual Enclave Default Settings Patch Model")
@withoutDefaultValues
model EnclaveDefaultSettingsPatchModel is EnclaveDefaultSettingsModel;

@doc("Enclave Address Spaces")
model EnclaveAddressSpacesModel {
  @doc("Enclave Address Space")
  enclaveAddressSpace?: string;

  @doc("Managed Address Space")
  managedAddressSpace?: string;
}

@doc("Virtual Enclave Resource properties")
model VirtualEnclaveBaseModel {
  @doc("Provisioning State.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Enclave Address Spaces")
  @visibility(Lifecycle.Read)
  enclaveAddressSpaces?: EnclaveAddressSpacesModel;

  @doc("Community Resource Id.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  communityResourceId: CommunityResourceId;

  @doc("List of resource ids created by Virtual Enclave.")
  @visibility(Lifecycle.Read)
  resourceCollection?: armResourceIdentifier[];

  @doc("Managed resource group configuration.")
  @visibility(Lifecycle.Read)
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @added(Microsoft.Mission.Versions.v2025_05_01_preview)
  @doc("Managed On Behalf Of Configuration.")
  @visibility(Lifecycle.Read)
  managedOnBehalfOfConfiguration?: CommonTypes.ManagedOnBehalfOfConfiguration;

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
}

model VirtualEnclaveModel is VirtualEnclaveBaseModel {
  @doc("Enclave Virtual Network.")
  enclaveVirtualNetwork: EnclaveVirtualNetworkModel;

  @doc("Enclave Maintenance Mode configuration.")
  maintenanceModeConfiguration?: MaintenanceModeConfigurationModel;

  @doc("Enclave Default Settings")
  enclaveDefaultSettings?: EnclaveDefaultSettingsModel;
}

model VirtualEnclavePatchProperties is VirtualEnclaveBaseModel {
  @doc("Enclave Virtual Network Patch Model.")
  enclaveVirtualNetwork: EnclaveVirtualNetworkPatchModel;

  @doc("Enclave Maintenance Mode configuration Patch Model.")
  maintenanceModeConfiguration?: MaintenanceModeConfigurationPatchModel;

  @doc("Enclave Default Settings Patch Model")
  enclaveDefaultSettings?: EnclaveDefaultSettingsPatchModel;
}

@doc("Virtual Enclave Patch Model")
model VirtualEnclavePatchModel {
  @doc("Virtual Enclave Patch properties")
  properties?: Update<VirtualEnclavePatchProperties>;

  ...ManagedServiceIdentityProperty;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}
