import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Information about the Maintenance Configuration resource.
 */
@parentResource(ManagedEnvironment)
model MaintenanceConfigurationResource
  is Azure.ResourceManager.ProxyResource<ScheduledEntries> {
  ...ResourceNameParameter<
    Resource = MaintenanceConfigurationResource,
    KeyName = "configName",
    SegmentName = "maintenanceConfigurations",
    NamePattern = "^[-\\w\\._\\(\\)]+$"
  >;
}

alias MaintenanceConfigurationResourceOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the managed environment. */
    @path
    @segment("managedEnvironments")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    environmentName: string;
  },
  {
    /** Name of the Maintenance Configuration. */
    @path
    @segment("maintenanceConfigurations")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    configName: string;
  }
>;

alias MaintenanceConfigurationResourceCustomErrorOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the managed environment. */
    @path
    @segment("managedEnvironments")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    environmentName: string;
  },
  {
    /** Name of the Maintenance Configuration. */
    @path
    @segment("maintenanceConfigurations")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    configName: string;
  },
  ErrorType = DefaultErrorResponse
>;

@armResourceOperations
interface MaintenanceConfigurations {
  /**
   * Gets the maintenance configuration of a ManagedEnvironment .
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MaintenanceConfigurations_Get")
  get is MaintenanceConfigurationResourceOps.Read<MaintenanceConfigurationResource>;

  /**
   * Create or update the maintenance configuration for Managed Environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MaintenanceConfigurations_CreateOrUpdate")
  createOrUpdate is MaintenanceConfigurationResourceCustomErrorOps.CreateOrUpdateSync<MaintenanceConfigurationResource>;

  /**
   * Deletes the maintenance configuration of a ManagedEnvironment .
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MaintenanceConfigurations_Delete")
  delete is MaintenanceConfigurationResourceCustomErrorOps.DeleteSync<MaintenanceConfigurationResource>;

  /**
   * Gets all maintenance configurations in the specified Managed Environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MaintenanceConfigurations_List")
  list is MaintenanceConfigurationResourceCustomErrorOps.List<
    MaintenanceConfigurationResource,
    Response = ArmResponse<MaintenanceConfigurationCollection>
  >;
}

@@doc(MaintenanceConfigurationResource.name,
  "The name of the maintenance configuration."
);
@@doc(MaintenanceConfigurationResource.properties,
  "The resource-specific properties for this resource."
);
@@doc(MaintenanceConfigurations.createOrUpdate::parameters.resource,
  "Parameters to set the maintenance configuration for ManagedEnvironment ."
);
