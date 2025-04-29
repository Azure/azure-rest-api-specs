import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Maintenance;
/**
 * Maintenance configuration record type
 */
@subscriptionResource
model MaintenanceConfiguration
  is Azure.ResourceManager.TrackedResource<MaintenanceConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = MaintenanceConfiguration,
    KeyName = "resourceName",
    SegmentName = "publicMaintenanceConfigurations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface MaintenanceConfigurationOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = MaintenanceConfiguration,
        KeyName = "resourceName",
        SegmentName = "publicMaintenanceConfigurations",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface MaintenanceConfigurations {
  /**
   * Get Public Maintenance Configuration record
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PublicMaintenanceConfigurations_Get")
  get is MaintenanceConfigurationOps.Read<MaintenanceConfiguration>;

  /**
   * Get Public Maintenance Configuration records
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PublicMaintenanceConfigurations_List")
  list is MaintenanceConfigurationOps.List<
    MaintenanceConfiguration,
    Response = ArmResponse<ListMaintenanceConfigurationsResult>
  >;
}
@armResourceOperations
interface MaintenanceConfigurationOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = MaintenanceConfiguration,
        KeyName = "resourceName",
        SegmentName = "maintenanceConfigurations",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface MaintenanceConfigurationOperationGroup {
  /**
   * Get Configuration record
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MaintenanceConfigurations_Get")
  get is MaintenanceConfigurationOperationGroupOps.Read<MaintenanceConfiguration>;

  /**
   * Create or Update configuration record
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MaintenanceConfigurations_CreateOrUpdate")
  createOrUpdate is MaintenanceConfigurationOperationGroupOps.CreateOrUpdateSync<MaintenanceConfiguration>;

  /**
   * Patch configuration record
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("MaintenanceConfigurations_Update")
  update is MaintenanceConfigurationOperationGroupOps.CustomPatchSync<
    MaintenanceConfiguration,
    PatchModel = MaintenanceConfiguration
  >;

  /**
   * Delete Configuration record
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MaintenanceConfigurations_Delete")
  delete is MaintenanceConfigurationOperationGroupOps.DeleteSync<
    MaintenanceConfiguration,
    Response = ArmResponse<MaintenanceConfiguration> | ArmDeletedNoContentResponse
  >;

  /**
   * Get Configuration records within a subscription and resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MaintenanceConfigurationsForResourceGroup_List")
  list is MaintenanceConfigurationOperationGroupOps.List<
    MaintenanceConfiguration,
    Response = ArmResponse<ListMaintenanceConfigurationsResult>
  >;

  /**
   * Get Configuration records within a subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MaintenanceConfigurations_List")
  maintenanceConfigurationsList is MaintenanceConfigurationOperationGroupOps.ListBySubscription<
    MaintenanceConfiguration,
    Response = ArmResponse<ListMaintenanceConfigurationsResult>
  >;
}

@@doc(MaintenanceConfiguration.name, "Maintenance Configuration Name");
@@doc(MaintenanceConfiguration.properties,
  "Gets or sets properties of the resource"
);
@@doc(MaintenanceConfigurationOperationGroup.createOrUpdate::parameters.resource,
  "The configuration"
);
@@doc(MaintenanceConfigurationOperationGroup.update::parameters.properties,
  "The configuration"
);
