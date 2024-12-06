import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Monitor;
/**
 * An Azure Monitor Workspace definition
 */
model AzureMonitorWorkspaceResource
  is Azure.ResourceManager.TrackedResource<AzureMonitorWorkspaceResourceProperties> {
  ...ResourceNameParameter<
    Resource = AzureMonitorWorkspaceResource,
    KeyName = "azureMonitorWorkspaceName",
    SegmentName = "accounts",
    NamePattern = "^(?!-)[a-zA-Z0-9-]+[^-]$"
  >;

  /**
   * Resource entity tag (ETag)
   */
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface AzureMonitorWorkspaceResources {
  /**
   * Returns the specified Azure Monitor Workspace
   */
  get is ArmResourceRead<AzureMonitorWorkspaceResource>;

  /**
   * Creates or updates an Azure Monitor Workspace
   */
  create is ArmResourceCreateOrReplaceSync<AzureMonitorWorkspaceResource>;

  /**
   * Updates part of an Azure Monitor Workspace
   */
  @parameterVisibility
  update is ArmCustomPatchSync<
    AzureMonitorWorkspaceResource,
    AzureMonitorWorkspaceResourceForUpdate
  >;

  /**
   * Deletes an Azure Monitor Workspace
   */
  delete is ArmResourceDeleteWithoutOkAsync<AzureMonitorWorkspaceResource>;

  /**
   * Lists all Azure Monitor Workspaces in the specified resource group
   */
  listByResourceGroup is ArmResourceListByParent<
    AzureMonitorWorkspaceResource,
    Response = AzureMonitorWorkspaceResourceListResult
  >;

  /**
   * Lists all Azure Monitor Workspaces in the specified subscription
   */
  listBySubscription is ArmListBySubscription<
    AzureMonitorWorkspaceResource,
    Response = AzureMonitorWorkspaceResourceListResult
  >;
}

@@doc(AzureMonitorWorkspaceResource.name,
  "The name of the Azure Monitor Workspace. The name is case insensitive"
);
@@doc(AzureMonitorWorkspaceResource.properties, "Resource properties");
@@doc(AzureMonitorWorkspaceResources.create::parameters.resource,
  "Properties that need to be specified to create a new Azure Monitor Workspace"
);
@@doc(AzureMonitorWorkspaceResources.update::parameters.properties,
  "The payload"
);
