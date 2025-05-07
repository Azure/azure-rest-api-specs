// cspell:enableCompoundWords
// cspell:words managedonbehalfofconfiguration

import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/governedserviceitem.tsp";
import "../shared/provisioningstate.tsp";
import "../shared/resourceid.tsp";
import "../shared/managedresourcegroupconfiguration.tsp";
import "../shared/roleassignmentitem.tsp";
import "../shared/managedonbehalfofconfiguration.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Azure Firewall SKU")
union FirewallSKU {
  @doc("FirewallSKU Basic")
  Basic: "Basic",

  @doc("FirwallSKU Standard")
  Standard: "Standard",

  @doc("FirewallSKU Premium")
  Premium: "Premium",

  string,
}

@doc("Identifier for governed services.")
union ServiceIdentifier {
  @doc("Service identifier for AKS")
  AKS: "AKS",

  @doc("Service identifier for App Service")
  AppService: "AppService",

  @doc("Service identifier for Azure Firewalls")
  AzureFirewalls: "AzureFirewalls",

  @doc("Service identifier for Container Registry")
  ContainerRegistry: "ContainerRegistry",

  @doc("Service identifier for CosmosDB")
  CosmosDB: "CosmosDB",

  @doc("Service identifier for Data Connectors")
  DataConnectors: "DataConnectors",

  @doc("Service identifier for Insights")
  Insights: "Insights",

  @doc("Service identifier for Key Vault")
  KeyVault: "KeyVault",

  @doc("Service identifier for Logic")
  Logic: "Logic",

  @doc("Service identifier for Microsoft SQL")
  MicrosoftSql: "MicrosoftSQL",

  @doc("Service identifier for Monitoring")
  Monitoring: "Monitoring",

  @doc("Service identifier for PostgreSQL")
  PostgreSql: "PostgreSQL",

  @doc("Service identifier for Private DNS Zones")
  PrivateDNSZones: "PrivateDNSZones",

  @doc("Service identifier for Service Bus")
  ServiceBus: "ServiceBus",

  @doc("Service identifier for Storage")
  Storage: "Storage",

  string,
}

@added(Microsoft.Mission.Versions.v2024_12_01_preview)
@doc("Approval Policy.")
union ApprovalPolicy {
  string,

  @doc("Approval will be required for the specified action.")
  Required: "Required",

  @doc("Approval will not be required for the specified action.")
  NotRequired: "NotRequired",
}

@added(Microsoft.Mission.Versions.v2024_12_01_preview)
@doc("Approver Metadata for approvals request.")
model MandatoryApprover {
  @doc("EntraId of the approver")
  approverEntraId: string;
}

@added(Microsoft.Mission.Versions.v2024_12_01_preview)
@doc("ApprovalSettings Properties")
model ApprovalSettingsDef {
  @doc("Approval required for endpoint creation (Required or NotRequired).")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endpointCreation?: ApprovalPolicy;

  @doc("Approval required for endpoint update (Required or NotRequired).")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endpointUpdate?: ApprovalPolicy;

  @doc("Approval required for endpoint deletion (Required or NotRequired).")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endpointDeletion?: ApprovalPolicy;

  @doc("Approval required for enclave connection creation (Required or NotRequired).")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  connectionCreation?: ApprovalPolicy;

  @doc("Approval required for enclave connection update (Required or NotRequired).")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  connectionUpdate?: ApprovalPolicy;

  @doc("Approval required for enclave connection deletion (Required or NotRequired).")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  connectionDeletion?: ApprovalPolicy;

  @doc("Approval required for virtual enclave creation (Required or NotRequired).")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  enclaveCreation?: ApprovalPolicy;

  @doc("Approval required for virtual enclave deletion (Required or NotRequired).")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  enclaveDeletion?: ApprovalPolicy;

  @doc("Approval required for toggling maintenance mode (Required or NotRequired).")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  maintenanceMode?: ApprovalPolicy;

  @doc("Approval required for deploying service catalog templates (Required or NotRequired).")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceCatalogDeployment?: ApprovalPolicy;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Notification will be sent on creation of an Approval Request")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  notificationOnApprovalCreation?: ApprovalPolicy;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Notification will be sent on any action taken (Approve/Reject) on an Approval Request")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  notificationOnApprovalAction?: ApprovalPolicy;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Notification will be sent on deletion of an Approval Request")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  notificationOnApprovalDeletion?: ApprovalPolicy;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @OpenAPI.extension("x-ms-identifiers", #["approverEntraId"])
  @doc("List of mandatory approvers for the approval request")
  mandatoryApprovers?: MandatoryApprover[];

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Minimum number of approvers required for the approval request")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  minimumApproversRequired?: int64;
}

@added(Microsoft.Mission.Versions.v2024_12_01_preview)
@doc("ApprovalSettings Properties")
model ApprovalSettings is ApprovalSettingsDef {
  @doc("Behavior of enclave connection update workflow after endpoint update is approved (Automatic or Manual).")
  connectionUpdateMode?: "Automatic" | "Manual" | string = "Automatic";
}

@added(Microsoft.Mission.Versions.v2024_12_01_preview)
@doc("ApprovalSettings Properties")
model ApprovalSettingsPatch is ApprovalSettingsDef {
  @doc("Behavior of enclave connection update workflow after endpoint update is approved (Automatic or Manual).")
  connectionUpdateMode?: "Automatic" | "Manual" | string;
}

@doc("Community Resource Properties")
model CommunityPropertiesDef {
  @doc("Address Space.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  addressSpace?: string;

  @doc("Dns Servers.")
  dnsServers?: string[];

  @doc("Provisioning State.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("List of resource ids created by communities.")
  @visibility(Lifecycle.Read)
  resourceCollection?: string[];

  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  @visibility(Lifecycle.Read)
  @doc("Managed resource group configuration.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @added(Microsoft.Mission.Versions.v2025_05_01_preview)
  @visibility(Lifecycle.Read)
  @doc("Managed On Behalf Of Configuration.")
  managedOnBehalfOfConfiguration?: ManagedOnBehalfOfConfiguration;

  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  @doc("List of services governed by a community.")
  governedServiceList?: GovernedServiceItem[];

  @added(Microsoft.Mission.Versions.v2025_05_01_preview)
  @doc("Allow enclaves to override community policies")
  allowEnclavePolicyOverride?: boolean;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Community role assignments")
  communityRoleAssignments?: RoleAssignmentItem[];
}

@doc("Community Resource Properties")
model CommunityProperties is CommunityPropertiesDef {
  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Approval requirements for various actions on the community's resources.")
  approvalSettings?: ApprovalSettings;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Maintenance Mode configuration.")
  maintenanceModeConfiguration?: MaintenanceModeConfiguration;

  @added(Microsoft.Mission.Versions.v2025_05_01_preview)
  @doc("SKU of the community's Azure Firewall (Basic, Standard, Premium). Standard is the default")
  firewallSku?: FirewallSKU = FirewallSKU.Standard;
}

@doc("Community Resource Properties")
model CommunityPatchProperties is CommunityPropertiesDef {
  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Approval requirements for various actions on the community's resources.")
  approvalSettings?: ApprovalSettingsPatch;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Maintenance Mode configuration.")
  maintenanceModeConfiguration?: MaintenanceModeConfigurationPatch;

  @added(Microsoft.Mission.Versions.v2025_05_01_preview)
  @doc("SKU of the community's Azure Firewall (Basic, Standard, Premium). Standard is the default")
  firewallSku?: FirewallSKU;
}

@doc("Community Patch Resource")
model CommunityPatchResource {
  @doc("Community Patch properties")
  properties?: Update<CommunityPatchProperties>;

  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
  ...ManagedServiceIdentityProperty;
}
