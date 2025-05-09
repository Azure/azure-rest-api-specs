import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Monitor;

@doc("An Azure Monitor Workspace definition.")
model AzureMonitorWorkspace
  is TrackedResource<AzureMonitorWorkspaceProperties> {
  @doc("The name of the Azure Monitor workspace. The name is case insensitive.")
  @pattern("^(?!-)[a-zA-Z0-9-]+[^-]$")
  @key("azureMonitorWorkspaceName")
  @path
  @segment("accounts")
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "ETag is not included in TrackedResource."
  @doc("Resource entity tag (ETag)")
  @visibility(Lifecycle.Read)
  etag?: string;
}

@doc("Properties that need to be specified to create a new workspace.")
model AzureMonitorWorkspaceProperties {
  @doc("The immutable ID of the Azure Monitor workspace. This property is read-only.")
  @visibility(Lifecycle.Read)
  accountId?: string;

  @doc("Information about metrics for the Azure Monitor workspace")
  metrics?: Metrics;

  @doc("The provisioning state of the Azure Monitor workspace. Set to Succeeded if everything is healthy.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The Data Collection Rule and Endpoint used for ingestion by default.")
  @visibility(Lifecycle.Read)
  defaultIngestionSettings?: IngestionSettings;

  @doc("List of private endpoint connections.")
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("Gets or sets allow or disallow public network access to workspace")
  @visibility(Lifecycle.Read)
  publicNetworkAccess?: PublicNetworkAccess;
}

@doc("Information about metrics for the workspace")
model Metrics {
  @doc("The Prometheus query endpoint for the workspace")
  @visibility(Lifecycle.Read)
  prometheusQueryEndpoint?: string;

  @doc("An internal identifier for the metrics container. Only to be used by the system")
  @visibility(Lifecycle.Read)
  internalId?: string;
}

@doc("Settings for data ingestion")
model IngestionSettings {
  @doc("The Azure resource Id of the default data collection rule for this workspace.")
  @visibility(Lifecycle.Read)
  dataCollectionRuleResourceId?: string;

  @doc("The Azure resource Id of the default data collection endpoint for this workspace.")
  @visibility(Lifecycle.Read)
  dataCollectionEndpointResourceId?: string;
}

@doc("State of the public network access.")
union PublicNetworkAccess {
  string,

  @doc("The public network access is enabled")
  Enabled: "Enabled",

  @doc("The public network access is disabled")
  Disabled: "Disabled",
}

@armResourceOperations
interface AzureMonitorWorkspaces {
  @doc("Returns the specific Azure Monitor workspace")
  get is ArmResourceRead<AzureMonitorWorkspace>;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @doc("Create or update a workspace")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    AzureMonitorWorkspace,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  @doc("Updates part of a workspace")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AzureMonitorWorkspace,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      AzureMonitorWorkspace,
      AzureMonitorWorkspaceProperties
    >
  >;
  @doc("Delete a workspace")
  delete is ArmResourceDeleteWithoutOkAsync<AzureMonitorWorkspace>;
  @doc("Lists all workspaces in the specified resource group")
  listByResourceGroup is ArmResourceListByParent<AzureMonitorWorkspace>;
  @doc("Lists all workspaces in the specified subscription")
  listBySubscription is ArmListBySubscription<AzureMonitorWorkspace>;
}
