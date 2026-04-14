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

  @doc("DiagnosticDestination Type Unspecified")
  Unspecified: "Unspecified",
}

@doc("Rbac Inheritance Mode")
union RbacInheritanceMode {
  string,

  @doc("RbacInheritanceMode Type Enabled")
  Enabled: "Enabled",

  @doc("RbacInheritanceMode Type Disabled")
  Disabled: "Disabled",
}

@doc("Resource Visibility Mode")
union ResourceVisibilityMode {
  string,

  @doc("ResourceVisibilityMode Type Enabled")
  Enabled: "Enabled",

  @doc("ResourceVisibilityMode Type Disabled")
  Disabled: "Disabled",
}

@doc("Subnet Configuration")
model SubnetConfiguration {
  @renamedFrom(Microsoft.Mission.Versions.v2025_05_01_preview, "name")
  @doc("Subnet name.")
  subnetName: string;

  @renamedFrom(Microsoft.Mission.Versions.v2025_05_01_preview, "id")
  @doc("Subnet Resource ID.")
  @visibility(Lifecycle.Read)
  subnetResourceId?: SubnetResourceId;

  @doc("Network prefix size.")
  networkPrefixSize: int32;

  @doc("Subnet delegation.")
  subnetDelegation?: string;

  @doc("Address prefix.")
  @visibility(Lifecycle.Read)
  addressPrefix?: string;

  @renamedFrom(
    Microsoft.Mission.Versions.v2025_05_01_preview,
    "networkSecurityGroupId"
  )
  @doc("Network security group ID.")
  @visibility(Lifecycle.Read)
  networkSecurityGroupResourceId?: NsgResourceId;
}

@doc("Enclave Virtual Network Properties")
model EnclaveVirtualNetworkModel {
  @renamedFrom(Microsoft.Mission.Versions.v2025_05_01_preview, "name")
  @doc("Network Name.")
  networkName?: string;

  @doc("Network Size.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkSize?: string;

  @doc("Custom CIDR Range.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  customCidrRange?: string;

  @doc("Subnet Configurations.")
  @identifiers(#[])
  subnetConfigurations?: SubnetConfiguration[];

  @doc("Allow Subnet Communication.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  allowSubnetCommunication?: boolean = false;

  @removed(Microsoft.Mission.Versions.v2025_05_01_preview)
  @doc("Connect to Azure Services (True or False).")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  connectToAzureServices?: boolean = false;
}

@doc("Virtual Enclave Default Settings")
model EnclaveDefaultSettingsPatchModel
  is UpdateableProperties<OmitDefaults<EnclaveDefaultSettingsModel>>;

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

@doc("Enclave Address Spaces")
model EnclaveAddressSpacesModel {
  @doc("Enclave Address Space")
  enclaveAddressSpace?: string;

  @doc("Managed Address Space")
  managedAddressSpace?: string;
}

@added(Microsoft.Mission.Versions.v2025_11_01_preview)
@doc("Virtual Enclave ApprovalSettings Properties for 2025-11-01-preview and later versions")
model VirtualEnclaveApprovalSettings {
  @doc("Approval configuration for enclave endpoint updates.")
  enclaveEndpointUpdate?: ApprovalSettingConfiguration;

  @doc("Approval configuration for connection creation.")
  connectionCreation?: ApprovalSettingConfiguration;

  @doc("Approval configuration for connection updates.")
  connectionUpdate?: ApprovalSettingConfiguration;

  @doc("Approval configuration for enclave maintenance mode.")
  enclaveMaintenanceMode?: ApprovalSettingConfiguration;
}

@added(Microsoft.Mission.Versions.v2025_11_01_preview)
@doc("Virtual Enclave ApprovalSettings Patch Properties")
model VirtualEnclaveApprovalSettingsPatchProperties
  is UpdateableProperties<OmitDefaults<VirtualEnclaveApprovalSettings>>;

@doc("Virtual Enclave Resource properties")
model VirtualEnclaveBaseModel {
  @doc("Provisioning State.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Virtual Network.")
  enclaveVirtualNetwork: EnclaveVirtualNetworkModel;

  @doc("Enclave Address Spaces")
  @visibility(Lifecycle.Read)
  enclaveAddressSpaces?: EnclaveAddressSpacesModel;

  @doc("Community Resource Id.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  communityResourceId: CommunityResourceId;

  @doc("List of resource ids created by Virtual Enclave.")
  @visibility(Lifecycle.Read)
  resourceCollection?: armResourceIdentifier[];

  @renamedFrom(
    Microsoft.Mission.Versions.v2025_05_01_preview,
    "managedResourceGroupConfiguration"
  )
  @typeChangedFrom(
    Microsoft.Mission.Versions.v2025_05_01_preview,
    ManagedResourceGroupConfiguration
  )
  @doc("Managed resource group name.")
  @visibility(Lifecycle.Read)
  managedResourceGroupName?: string;

  @added(Microsoft.Mission.Versions.v2025_05_01_preview)
  @doc("Managed On Behalf Of Configuration.")
  @visibility(Lifecycle.Read)
  managedOnBehalfOfConfiguration?: CommonTypes.ManagedOnBehalfOfConfiguration;

  @doc("Deploy Bastion service (True or False).")
  bastionEnabled?: boolean = false;

  @added(Microsoft.Mission.Versions.v2025_11_01_preview)
  @doc("Specifies whether resources in the workload resource group(s) are visible through standard RBAC")
  workloadResourceVisibility?: ResourceVisibilityMode = ResourceVisibilityMode.Disabled;

  @added(Microsoft.Mission.Versions.v2025_11_01_preview)
  @doc("Controls whether standard Azure RBAC role inheritance applies to the workload resource group(s)")
  rbacInheritance?: RbacInheritanceMode = RbacInheritanceMode.Disabled;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Enclave role assignments")
  @identifiers(#[])
  enclaveRoleAssignments?: RoleAssignmentItem[];

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Workload role assignments")
  @identifiers(#[])
  workloadRoleAssignments?: RoleAssignmentItem[];

  @added(Microsoft.Mission.Versions.v2025_05_01_preview)
  @doc("Enclave specific policies")
  @identifiers(#[])
  governedServiceList?: GovernedServiceItem[];
}

@doc("Virtual Enclave Resource properties")
model VirtualEnclaveProperties is VirtualEnclaveBaseModel {
  @doc("Enclave default settings.")
  enclaveDefaultSettings?: EnclaveDefaultSettingsModel;

  @doc("Maintenance Mode configuration.")
  maintenanceModeConfiguration?: MaintenanceModeConfigurationModel;

  @added(Microsoft.Mission.Versions.v2025_11_01_preview)
  @doc("DedicatedHub Resource ID.")
  dedicatedHubResourceId?: DedicatedHubResourceId;

  @added(Microsoft.Mission.Versions.v2025_11_01_preview)
  @doc("Approval requirements for various actions on the enclave's resources.")
  approvalSettings?: VirtualEnclaveApprovalSettings;

  @added(Microsoft.Mission.Versions.v2026_01_01_preview)
  @doc("Virtual Enclave Monitoring Settings for diagnostic and virtual network flow logs")
  monitoringSettings?: MonitoringSettingsModel;
}

@doc("Virtual Enclave Patchable Properties")
model VirtualEnclavePatchProperties
  is UpdateableProperties<OmitDefaults<VirtualEnclaveBaseModel>> {
  @doc("Enclave default settings.")
  enclaveDefaultSettings?: EnclaveDefaultSettingsPatchModel;

  @doc("Maintenance Mode configuration.")
  maintenanceModeConfiguration?: MaintenanceModeConfigurationPatchModel;

  @added(Microsoft.Mission.Versions.v2025_11_01_preview)
  @doc("DedicatedHub Resource ID.")
  dedicatedHubResourceId?: DedicatedHubResourceId;

  @added(Microsoft.Mission.Versions.v2025_11_01_preview)
  @doc("Approval requirements for various actions on the enclave's resources.")
  approvalSettings?: VirtualEnclaveApprovalSettingsPatchProperties;

  @added(Microsoft.Mission.Versions.v2026_01_01_preview)
  @doc("Virtual Enclave Monitoring Settings for diagnostic and virtual network flow logs")
  monitoringSettings?: MonitoringSettingsPatchModel;
}

@doc("Virtual Enclave Patch Model")
model VirtualEnclavePatchModel {
  @doc("Virtual Enclave Patch properties")
  properties?: VirtualEnclavePatchProperties;

  ...ManagedServiceIdentityProperty;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}
