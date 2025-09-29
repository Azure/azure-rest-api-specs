import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "./models.tsp";
import "./service.tsp";

using Azure.ResourceManager;

namespace Microsoft.Monitor {
  @armResourceOperations
  interface AzureMonitorWorkspaces {
    /**
     * Returns the specified Azure Monitor Workspace
     */
    get is ArmResourceRead<AzureMonitorWorkspaceResource>;

    /**
     * Creates or updates an Azure Monitor Workspace
     */
    createOrUpdate is ArmResourceCreateOrReplaceSync<AzureMonitorWorkspaceResource>;

    /**
     * Updates part of an Azure Monitor Workspace
     */
    update is ArmResourcePatchSync<
      AzureMonitorWorkspaceResource,
      AzureMonitorWorkspace
    >;

    /**
     * Deletes an Azure Monitor Workspace
     */
    delete is ArmResourceDeleteWithoutOkAsync<AzureMonitorWorkspaceResource>;

    /**
     * Lists all Azure Monitor Workspaces in the specified resource group
     */
    listByResourceGroup is ArmResourceListByParent<AzureMonitorWorkspaceResource>;

    /**
     * Lists all Azure Monitor Workspaces in the specified subscription
     */
    listBySubscription is ArmListBySubscription<AzureMonitorWorkspaceResource>;
  }

  #suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Metrics container is always present with the Azure Monitor Workspace and cannot be deleted"
  @armResourceOperations
  interface MetricsContainers {
    /**
     * Gets metrics container settings for a monitoring account.
     */
    get is ArmResourceRead<MacMetricsContainerResource>;

    /**
     * Creates or updates metrics container settings for a monitoring account.
     */
    createOrUpdate is ArmResourceCreateOrReplaceSync<MacMetricsContainerResource>;

    /**
     * Lists metrics containers for a monitoring account.
     */
    listByAzureMonitorWorkspace is ArmResourceListByParent<MacMetricsContainerResource>;
  }

  @@doc(AzureMonitorWorkspaceResource.name,
    "The name of the Azure Monitor Workspace. The name is case insensitive"
  );
  @@doc(AzureMonitorWorkspaceResource.properties, "Resource properties");
  @@doc(AzureMonitorWorkspaces.createOrUpdate::parameters.resource,
    "Properties that need to be specified to create a new Azure Monitor Workspace"
  );
}
