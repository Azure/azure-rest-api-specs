import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Http;
using Rest;
using Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Managed Operations control plane service" })
@doc("Managed Operations API.")
@versioned(Microsoft.ManagedOps.Versions)
namespace Microsoft.ManagedOps;

@doc("The Managed Operations resource.")
@subscriptionResource
model ManagedOp is ProxyResource<ManagedOpsProperties> {
  /** Fix the name of the resource to ensure it is a singleton */
  @doc("Name of the resource.")
  @key("managedOpsName")
  @pattern("default")
  @segment("managedOps")
  @path
  name: string;
}

@doc("Properties of the ManagedOps resource.")
model ManagedOpsProperties {
  @doc("Product plan details of this resource.")
  @removed(Versions.v2026_01_06_preview)
  @renamedFrom(Versions.v2026_01_06_preview, "sku")
  @visibility(Lifecycle.Read)
  oldSku?: Sku;

  @doc("Product plan details of this resource.")
  @added(Versions.v2026_01_06_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sku?: Sku;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Desired configuration input by the user.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  desiredConfiguration: DesiredConfiguration;

  @doc("Services provisioned by this resource.")
  @visibility(Lifecycle.Read)
  services?: ServiceInformation;

  @doc("Policy assignments created for managing services.")
  @visibility(Lifecycle.Read)
  policyAssignmentProperties?: PolicyAssignmentProperties;
}

@doc("Services provisioned by this resource.")
model ServiceInformation {
  @doc("Change Tracking and Inventory service information.")
  @visibility(Lifecycle.Read)
  changeTrackingAndInventory?: ChangeTrackingInformation;

  @doc("Azure Monitor Insights service information.")
  @visibility(Lifecycle.Read)
  azureMonitorInsights?: AzureMonitorInformation;

  @doc("Azure Update Manager service information.")
  @visibility(Lifecycle.Read)
  azureUpdateManager?: UpdateManagerInformation;

  @doc("Azure Policy and Machine Configuration service information.")
  @visibility(Lifecycle.Read)
  azurePolicyAndMachineConfiguration?: GuestConfigurationInformation;

  @doc("Defender for Servers service information.")
  @visibility(Lifecycle.Read)
  defenderForServers?: DefenderForServersInformation;

  @doc("Defender for Cloud's Cloud security posture management (CSPM) service information.")
  @visibility(Lifecycle.Read)
  defenderCspm?: DefenderCspmInformation;
}

@doc("Policy assignments created for managing services.")
model PolicyAssignmentProperties {
  @doc("Policy initiative assignment ID.")
  policyInitiativeAssignmentId: armResourceIdentifier<[
    {
      type: "Microsoft.Authorization/policyassignments";
    }
  ]>;
}

@doc("The enablement state of a service.")
union EnablementState {
  string,

  @doc("Service is enabled.")
  Enabled: "Enabled",

  @doc("Service enablement is in progress.")
  InProgress: "InProgress",

  @doc("Service enablement has failed.")
  Failed: "Failed",

  @doc("Service is disabled.")
  Disabled: "Disabled",
}

@doc("Change Tracking and Inventory service information.")
model ChangeTrackingInformation {
  @doc("ID of Data Collection Rule (DCR) associated with this service.")
  dcrId: armResourceIdentifier<[
    {
      type: "Microsoft.Insights/dataCollectionRules";
    }
  ]>;

  @doc("Indicates whether the service is enabled.")
  enablementStatus: EnablementState;

  @doc("Optional error message if the service is in Failed state.")
  @added(Versions.v2026_01_06_preview)
  errorDetails?: ErrorDetails;
}

@doc("Azure Monitor Insights service information.")
model AzureMonitorInformation {
  @doc("ID of Data Collection Rule (DCR) associated with this service.")
  dcrId: armResourceIdentifier<[
    {
      type: "Microsoft.Insights/dataCollectionRules";
    }
  ]>;

  @doc("Indicates whether the service is enabled.")
  enablementStatus: EnablementState;

  @doc("Optional error message if the service is in Failed state.")
  @added(Versions.v2026_01_06_preview)
  errorDetails?: ErrorDetails;
}

@doc("Azure Update Manager service information.")
model UpdateManagerInformation {
  @doc("Indicates whether the service is enabled.")
  enablementStatus: EnablementState;

  @doc("Optional error message if the service is in Failed state.")
  @added(Versions.v2026_01_06_preview)
  errorDetails?: ErrorDetails;
}

@doc("Azure Policy and Machine Configuration service information.")
model GuestConfigurationInformation {
  @doc("Indicates whether the service is enabled.")
  enablementStatus: EnablementState;

  @doc("Optional error message if the service is in Failed state.")
  @added(Versions.v2026_01_06_preview)
  errorDetails?: ErrorDetails;
}

@doc("Defender for Servers service information.")
model DefenderForServersInformation {
  @doc("Indicates whether the service is enabled.")
  enablementStatus: EnablementState;

  @doc("Optional error message if the service is in Failed state.")
  @added(Versions.v2026_01_06_preview)
  errorDetails?: ErrorDetails;
}

@doc("Defender Cloud Security Posture Management (CSPM) service information.")
model DefenderCspmInformation {
  @doc("Indicates whether the service is enabled.")
  enablementStatus: EnablementState;

  @doc("Optional error message if the service is in Failed state.")
  @added(Versions.v2026_01_06_preview)
  errorDetails?: ErrorDetails;
}

@doc("The name of the SKU.")
@added(Versions.v2026_01_06_preview)
union SkuName {
  string,

  @doc("ManagedOps SKU.")
  ManagedOps: "ManagedOps",
}

@doc("The pricing tier of the SKU.")
@added(Versions.v2026_01_06_preview)
union SkuTier {
  string,

  @doc("Essential tier.")
  Essential: "Essential",
}

@doc("Specifies the service plan for this resource.")
model Sku {
  // Original properties for 2025-07-28-preview (no defaults)
  @added(Versions.v2026_01_06_preview)
  @doc("Name of the SKU.")
  name: SkuName = SkuName.ManagedOps;

  @added(Versions.v2026_01_06_preview)
  @doc("Pricing tier of the SKU.")
  tier: SkuTier = SkuTier.Essential;

  // Properties with defaults for 2026-01-06-preview
  @removed(Versions.v2026_01_06_preview)
  @renamedFrom(Versions.v2026_01_06_preview, "name")
  @doc("Name of the SKU.")
  skuName: string;

  @removed(Versions.v2026_01_06_preview)
  @renamedFrom(Versions.v2026_01_06_preview, "tier")
  @doc("Pricing tier of the SKU.")
  skuTier: string;
}

@doc("Desired configuration input by the user.")
model DesiredConfiguration {
  @doc("Configuration for the Change Tracking and Inventory service.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  changeTrackingAndInventory: ChangeTrackingConfiguration;

  @doc("Configuration for the Azure Monitor Insights service.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  azureMonitorInsights: AzureMonitorConfiguration;

  @doc("User assigned Managed Identity used to perform operations on machines managed by Ops360.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  userAssignedManagedIdentityId: armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;

  // Properties with defaults for 2026-01-06-preview
  @added(Versions.v2026_01_06_preview)
  @doc("Desired enablement state of the Defender For Servers service.")
  @visibility(Lifecycle.Read, Lifecycle.Update, Lifecycle.Create)
  defenderForServers?: DesiredEnablementState = DesiredEnablementState.Disable;

  @added(Versions.v2026_01_06_preview)
  @doc("Desired enablement state of the Defender Cloud Security Posture Management (CSPM) service.")
  @visibility(Lifecycle.Read, Lifecycle.Update, Lifecycle.Create)
  defenderCspm?: DesiredEnablementState = DesiredEnablementState.Disable;

  // Original properties for 2025-07-28-preview (no defaults)
  @removed(Versions.v2026_01_06_preview)
  @renamedFrom(Versions.v2026_01_06_preview, "defenderForServers")
  @doc("Desired enablement state of the Defender For Servers service.")
  @visibility(Lifecycle.Read, Lifecycle.Update, Lifecycle.Create)
  oldDefenderForServers?: DesiredEnablementState;

  @removed(Versions.v2026_01_06_preview)
  @renamedFrom(Versions.v2026_01_06_preview, "defenderCspm")
  @doc("Desired enablement state of the Defender Cloud Security Posture Management (CSPM) service.")
  @visibility(Lifecycle.Read, Lifecycle.Update, Lifecycle.Create)
  oldDefenderCspm?: DesiredEnablementState;
}

@doc("The desired enablement state of a service.")
union DesiredEnablementState {
  string,

  @doc("Enable the service.")
  Enable: "Enable",

  @doc("Disable the service.")
  Disable: "Disable",
}

@doc("Configuration for the Change Tracking and Inventory service.")
model ChangeTrackingConfiguration {
  @doc("Log analytics workspace resource ID used by the service.")
  logAnalyticsWorkspaceId: armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;
}

@doc("Configuration for the Azure Monitor Insights service.")
model AzureMonitorConfiguration {
  @doc("Azure monitor workspace resource ID used by the service.")
  azureMonitorWorkspaceId: armResourceIdentifier<[
    {
      type: "Microsoft.Monitor/accounts";
    }
  ]>;
}

@doc("Details of an error encountered during enabling a service.")
@added(Versions.v2026_01_06_preview)
model ErrorDetails {
  @doc("Error code.")
  code: string;

  @doc("Detailed error message.")
  message: string;
}

@doc("The provisioning state of a resource.")
@lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The resource has begun provisioning.")
  Provisioning: "Provisioning",

  @doc("The resource is being deleted.")
  Deleting: "Deleting",

  @doc("The resource has been accepted for provisioning.")
  @added(Versions.v2026_01_06_preview)
  Accepted: "Accepted",
}

@doc("ManagedOps model for update operations")
model ManagedOpUpdate {
  @doc("Updatable properties in the ManagedOps resource.")
  properties?: ManagedOpUpdateProperties;
}

@doc("Updatable properties in the ManagedOps resource.")
model ManagedOpUpdateProperties {
  @doc("Desired configuration input by the user.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  desiredConfiguration?: DesiredConfigurationUpdate;
}

@doc("Updatable parameters in the Desired configuration input.")
model DesiredConfigurationUpdate {
  @doc("Desired enablement state of the Defender For Servers service.")
  @visibility(Lifecycle.Read, Lifecycle.Update, Lifecycle.Create)
  defenderForServers?: DesiredEnablementState;

  @doc("Desired enablement state of the Defender Cloud Security Posture Management (CSPM) service.")
  @visibility(Lifecycle.Read, Lifecycle.Update, Lifecycle.Create)
  defenderCspm?: DesiredEnablementState;
}

/** The operations that can be performed on our resource */
@armResourceOperations(ManagedOp)
interface ManagedOps {
  @doc("Gets the information of the ManagedOps instance.")
  get is ArmResourceRead<ManagedOp>;

  @doc("Creates or updates the ManagedOps instance.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedOp>;

  @doc("List all ManagedOps instances in the subscription.")
  list is ArmListBySubscription<ManagedOp>;

  @doc("Updates the ManagedOps instance with the supplied fields.")
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<ManagedOp, ManagedOpUpdate>;

  @doc("Deletes the ManagedOps instance.")
  delete is ArmResourceDeleteWithoutOkAsync<ManagedOp>;
}
