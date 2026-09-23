import "./models.tsp";
import "../service.tsp";

using Azure.ResourceManager;

namespace Microsoft.Monitor {
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
}
