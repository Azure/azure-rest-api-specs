import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "./models.tsp";
import "./service.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Monitor {
  /**
   * An Azure Monitor Workspace definition
   */
  model AzureMonitorWorkspaceResource
    is Azure.ResourceManager.TrackedResource<AzureMonitorWorkspaceProperties> {
    ...ResourceNameParameter<
      Resource = AzureMonitorWorkspaceResource,
      KeyName = "azureMonitorWorkspaceName",
      SegmentName = "accounts",
      NamePattern = "^(?!-)[a-zA-Z0-9-]+[^-]$"
    >;
  }

  /**
   * Metrics container resource for an Azure Monitor Workspace.
   */
  @parentResource(AzureMonitorWorkspaceResource)
  model MetricsContainerResource
    is Azure.ResourceManager.ProxyResource<MetricsContainer> {
    ...ResourceNameParameter<
      Resource = MetricsContainer,
      KeyName = "metricsContainerName",
      SegmentName = "metricsContainers",
      /**
       * The name of the metrics container. Always 'default'.
       */
      NamePattern = "^default$"
    >;
  }

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
      AzureMonitorWorkspaceProperties
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
    get is ArmResourceRead<MetricsContainerResource>;

    /**
     * Creates or updates metrics container settings for a monitoring account.
     */
    createOrUpdate is ArmResourceCreateOrReplaceSync<MetricsContainerResource>;

    /**
     * Lists metrics containers for a monitoring account.
     */
    listByAzureMonitorWorkspace is ArmResourceListByParent<MetricsContainerResource>;
  }

  @armResourceOperations
  interface ExportRules {
    /**
     * Gets an export rule for an Azure Monitor Workspace
     */
    get is ArmResourceRead<ExportRuleResource>;

    /**
     * Creates or updates an export rule for an Azure Monitor Workspace
     */
    createOrUpdate is ArmResourceCreateOrReplaceSync<ExportRuleResource>;

    /**
     * Deletes an export rule from an Azure Monitor Workspace
     */
    delete is ArmResourceDeleteWithoutOkAsync<ExportRuleResource>;

    /**
     * Lists all export rules for an Azure Monitor Workspace
     */
    listByAzureMonitorWorkspace is ArmResourceListByParent<ExportRuleResource>;
  }

  @@doc(AzureMonitorWorkspaceResource.name,
    "The name of the Azure Monitor Workspace. The name is case insensitive"
  );
  @@doc(AzureMonitorWorkspaceResource.properties, "Resource properties");
  @@doc(AzureMonitorWorkspaces.createOrUpdate::parameters.resource,
    "Properties that need to be specified to create a new Azure Monitor Workspace"
  );

  @@doc(ExportRuleResource.name,
    "The name of the export rule. The name is case insensitive"
  );
  @@doc(ExportRuleResource.properties, "Export rule properties");
  @@doc(ExportRules.createOrUpdate::parameters.resource,
    "Properties that need to be specified to create a new export rule"
  );
}
