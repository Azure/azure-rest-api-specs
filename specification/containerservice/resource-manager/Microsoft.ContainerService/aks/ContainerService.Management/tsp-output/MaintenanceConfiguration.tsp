import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;
/**
 * See [planned maintenance](https://docs.microsoft.com/azure/aks/planned-maintenance) for more information about planned maintenance.
 */
@parentResource(ManagedCluster)
model MaintenanceConfiguration
  is ProxyResource<MaintenanceConfigurationProperties> {
  /**
   * The name of the maintenance configuration.
   */
  @path
  @key("configName")
  @segment("maintenanceConfigurations")
  name: string;
}

@armResourceOperations
interface MaintenanceConfigurations {
  /**
   * Gets the specified maintenance configuration of a managed cluster.
   */
  get is ArmResourceRead<MaintenanceConfiguration>;

  /**
   * Creates or updates a maintenance configuration in the specified managed cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<MaintenanceConfiguration>;

  /**
   * Deletes a maintenance configuration.
   */
  delete is ArmResourceDeleteSync<MaintenanceConfiguration>;

  /**
   * Gets a list of maintenance configurations in the specified managed cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MaintenanceConfigurations_ListByManagedCluster")
  listByManagedCluster is ArmResourceListByParent<MaintenanceConfiguration>;
}

@@projectedName(MaintenanceConfigurations.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(MaintenanceConfigurations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(MaintenanceConfigurations.createOrUpdate::parameters.resource,
  "The maintenance configuration to create or update."
);
