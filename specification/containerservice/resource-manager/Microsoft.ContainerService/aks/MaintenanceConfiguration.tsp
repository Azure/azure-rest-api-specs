import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ContainerService;
/**
 * Planned maintenance configuration, used to configure when updates can be deployed to a Managed Cluster. See [planned maintenance](https://docs.microsoft.com/azure/aks/planned-maintenance) for more information about planned maintenance.
 */
@parentResource(ManagedCluster)
model MaintenanceConfiguration
  is Azure.ResourceManager.ProxyResource<MaintenanceConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = MaintenanceConfiguration,
    KeyName = "configName",
    SegmentName = "maintenanceConfigurations",
    NamePattern = ""
  >;
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
  listByManagedCluster is ArmResourceListByParent<MaintenanceConfiguration>;
}

@@doc(MaintenanceConfiguration.name,
  "The name of the maintenance configuration. Supported values are 'default', 'aksManagedAutoUpgradeSchedule', or 'aksManagedNodeOSUpgradeSchedule'."
);
@@doc(MaintenanceConfiguration.properties,
  "Properties of a default maintenance configuration."
);
@@doc(MaintenanceConfigurations.createOrUpdate::parameters.resource,
  "The maintenance configuration to create or update."
);
