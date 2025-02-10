import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../shared/provisioningstate.tsp";
import "../shared/resourceid.tsp";
import "../shared/managedresourcegroupconfiguration.tsp";
import "../shared/roleassignmentitem.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

#suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
@removed(Microsoft.Mission.Versions.v2023_08_01_preview)
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

@added(Microsoft.Mission.Versions.v2024_06_01_preview)
@doc("GovernedServiceItem Properties")
model GovernedServiceItem {
  @doc("service id")
  id: ServiceIdentifier;

  @doc("service name")
  @visibility("read")
  name?: string;

  @doc("governance option for this service (Allow, Deny, ExceptionOnly, or NotApplicable).")
  option?: "Allow" | "Deny" | "ExceptionOnly" | "NotApplicable" | string;

  @doc("initiative enforcement (Enabled or Disabled).")
  enforcement?: "Enabled" | "Disabled" | string;

  @doc("policies set to auditOnly (True or False).")
  auditOnly?: boolean;

  @doc("initiatives associated with this service")
  @visibility("read")
  initiatives?: string[];
}

@added(Microsoft.Mission.Versions.v2024_11_01_preview)
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

@added(Microsoft.Mission.Versions.v2024_11_01_preview)
@doc("ApprovalSettings Properties")
model ApprovalSettings {
  @doc("Approval required for endpoint creation (Required or NotRequired).")
  endpointCreation?: ApprovalPolicy;

  @doc("Approval required for endpoint update (Required or NotRequired).")
  endpointUpdate?: ApprovalPolicy;

  @doc("Approval required for endpoint deletion (Required or NotRequired).")
  endpointDeletion?: ApprovalPolicy;

  @doc("Approval required for enclave connection creation (Required or NotRequired).")
  connectionCreation?: ApprovalPolicy;

  @doc("Approval required for enclave connection update (Required or NotRequired).")
  connectionUpdate?: ApprovalPolicy;

  @doc("Behavior of enclave connection update workflow after endpoint update is approved (Automatic or Manual).")
  connectionUpdateMode?: "Automatic" | "Manual" | string;

  @doc("Approval required for enclave connection deletion (Required or NotRequired).")
  connectionDeletion?: ApprovalPolicy;

  @doc("Approval required for virtual enclave creation (Required or NotRequired).")
  enclaveCreation?: ApprovalPolicy;

  @doc("Approval required for virtual enclave deletion (Required or NotRequired).")
  enclaveDeletion?: ApprovalPolicy;

  @doc("Approval required for toggling maintenance mode (Required or NotRequired).")
  maintenanceMode?: ApprovalPolicy;

  @doc("Approval required for deploying service catalog templates (Required or NotRequired).")
  serviceCatalogDeployment?: ApprovalPolicy;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Notification will be sent on creation of an Approval Request")
  notificationOnApprovalCreation?: ApprovalPolicy;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Notification will be sent on any action taken (Approve/Reject) on an Approval Request")
  notificationOnApprovalAction?: ApprovalPolicy;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Notification will be sent on deletion of an Approval Request")
  notificationOnApprovalDeletion?: ApprovalPolicy;

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @OpenAPI.extension("x-ms-identifiers", ["approverEntraId"])
  @doc("List of mandatory approvers for the approval request")
  mandatoryApprovers?: MandatoryApprover[];

  @added(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Minimum number of approvers required for the approval request")
  minimumApproversRequired?: int64;
}

@doc("Community Resource Properties")
model CommunityProperties {
  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @removed(Microsoft.Mission.Versions.v2023_08_01_preview)
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

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @removed(Microsoft.Mission.Versions.v2023_08_01_preview)
  @doc("List of virtual enclaves that a community contains.")
  virtualEnclaveList?: EnclaveListItem[];

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @removed(Microsoft.Mission.Versions.v2023_08_01_preview)
  @doc("Dictionary of virtual enclaves that a community contains.")
  virtualEnclaveCollection?: Record<EnclaveListItem>;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @added(Microsoft.Mission.Versions.v2023_08_01_preview)
  @madeOptional(Microsoft.Mission.Versions.v2023_08_01_preview)
  @doc("Managed resource group configuration.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "New version does not have any breaking change."
  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  @madeOptional(Microsoft.Mission.Versions.v2024_06_01_preview)
  @doc("List of services governed by a community.")
  governedServiceList?: GovernedServiceItem[];

  @added(Microsoft.Mission.Versions.v2024_10_01_preview)
  @madeOptional(Microsoft.Mission.Versions.v2024_10_01_preview)
  @doc("Community role assignments")
  communityRoleAssignments?: RoleAssignmentItem[];

  @added(Microsoft.Mission.Versions.v2024_11_01_preview)
  @doc("Approval requirements for various actions on the community's resources.")
  approvalSettings?: ApprovalSettings;

  @added(Microsoft.Mission.Versions.v2024_11_01_preview)
  @doc("Maintenance Mode configuration.")
  maintenanceModeConfiguration?: MaintenanceModeConfiguration;
}
