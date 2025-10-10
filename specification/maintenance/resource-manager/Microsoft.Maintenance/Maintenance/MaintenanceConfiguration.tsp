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
model MaintenanceConfiguration
  is Azure.ResourceManager.ProxyResource<MaintenanceConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = MaintenanceConfiguration,
    KeyName = "resourceName",
    SegmentName = "publicMaintenanceConfigurations",
    NamePattern = ""
  >;

  /**
   * Gets or sets location of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;

  /**
   * Gets or sets tags of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

@armResourceOperations
interface MaintenanceConfigurationOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
      },
      {
        ...Extension.ExtensionProviderNamespace<MaintenanceConfiguration>,
        ...ParentKeysOf<MaintenanceConfiguration>,
      },
      {
        ...Extension.ExtensionProviderNamespace<MaintenanceConfiguration>,
        ...KeysOf<ResourceNameParameter<
          Resource = MaintenanceConfiguration,
          KeyName = "resourceName",
          SegmentName = "publicMaintenanceConfigurations",
          NamePattern = ""
        >>,
      }
    > {}

@armResourceOperations
interface MaintenanceConfigurations {
  /**
   * Get Public Maintenance Configuration record
   */
  get is MaintenanceConfigurationOps.Read<
    MaintenanceConfiguration,
    ErrorType = MaintenanceError
  >;

  /**
   * Get Public Maintenance Configuration records
   */
  list is Extension.ListByTarget<
    Extension.Subscription,
    MaintenanceConfiguration,
    Response = ArmResponse<ListMaintenanceConfigurationsResult>,
    Error = MaintenanceError
  >;
}
@armResourceOperations
interface MaintenanceConfigurationOperationGroupOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
      },
      {
        ...Extension.ExtensionProviderNamespace<MaintenanceConfiguration>,
        ...ParentKeysOf<MaintenanceConfiguration>,
      },
      {
        ...Extension.ExtensionProviderNamespace<MaintenanceConfiguration>,
        ...KeysOf<ResourceNameParameter<
          Resource = MaintenanceConfiguration,
          KeyName = "resourceName",
          SegmentName = "maintenanceConfigurations",
          NamePattern = ""
        >>,
      }
    > {}

@armResourceOperations
interface MaintenanceConfigurationOperationGroup {
  /**
   * Get Configuration record
   */
  get is MaintenanceConfigurationOperationGroupOps.Read<
    MaintenanceConfiguration,
    ErrorType = MaintenanceError
  >;

  /**
   * Create or Update configuration record
   */
  createOrUpdate is MaintenanceConfigurationOperationGroupOps.CreateOrUpdateSync<
    MaintenanceConfiguration,
    ErrorType = MaintenanceError
  >;

  /**
   * Patch configuration record
   */
  @patch(#{ implicitOptionality: false })
  update is MaintenanceConfigurationOperationGroupOps.CustomPatchSync<
    MaintenanceConfiguration,
    PatchModel = MaintenanceConfiguration,
    ErrorType = MaintenanceError
  >;

  /**
   * Delete Configuration record
   */
  delete is MaintenanceConfigurationOperationGroupOps.DeleteSync<
    MaintenanceConfiguration,
    Response = ArmResponse<MaintenanceConfiguration> | ArmDeletedNoContentResponse,
    ErrorType = MaintenanceError
  >;

  /**
   * Get Configuration records within a subscription and resource group
   */
  @segment("maintenanceConfigurations")
  list is Extension.ListByTarget<
    Extension.ResourceGroup,
    MaintenanceConfiguration,
    Response = ArmResponse<ListMaintenanceConfigurationsResult>,
    Error = MaintenanceError
  >;

  /**
   * Get Configuration records within a subscription
   */
  @segment("maintenanceConfigurations")
  maintenanceConfigurationsList is Extension.ListByTarget<
    Extension.Subscription,
    MaintenanceConfiguration,
    Response = ArmResponse<ListMaintenanceConfigurationsResult>,
    Error = MaintenanceError
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
