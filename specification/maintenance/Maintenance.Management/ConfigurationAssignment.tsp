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
 * Configuration Assignment
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Private.armResourceInternal(
  ConfigurationAssignmentProperties
)
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
model ConfigurationAssignment extends Foundations.ProxyResource {
  ...ResourceNameParameter<
    Resource = ConfigurationAssignment,
    KeyName = "configurationAssignmentName",
    SegmentName = "configurationAssignments",
    NamePattern = ""
  >;

  /**
   * Location of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;

  /**
   * Properties of the configuration assignment
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(true)
  properties?: ConfigurationAssignmentProperties;
}

@armResourceOperations
interface ConfigurationAssignmentOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /**
         * Resource provider name
         */
        @path @segment("providers") providerName: string,

        /**
         * Resource parent type
         */
        @path resourceParentType: string,

        /**
         * Resource parent name
         */
        @path resourceParentName: string,

        /**
         * Resource type
         */
        @path resourceType: string,

        /**
         * Resource name
         */
        @path resourceName: string,

        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = ConfigurationAssignment,
        KeyName = "configurationAssignmentName",
        SegmentName = "configurationAssignments",
        NamePattern = ""
      >>,
      MaintenanceError
    > {}

@armResourceOperations
interface ConfigurationAssignments {
  /**
   * Get configuration assignment for resource..
   */
  getParent is ConfigurationAssignmentOps.Read<ConfigurationAssignment>;

  /**
   * Register configuration for resource.
   */
  createOrUpdateParent is ConfigurationAssignmentOps.CreateOrUpdateSync<ConfigurationAssignment>;

  /**
   * Unregister configuration for resource.
   */
  deleteParent is ConfigurationAssignmentOps.DeleteSync<
    ConfigurationAssignment,
    Response = ArmResponse<ConfigurationAssignment> | ArmDeletedNoContentResponse
  >;

  /**
   * List configurationAssignments for resource.
   */
  listParent is ConfigurationAssignmentOps.List<
    ConfigurationAssignment,
    Response = ArmResponse<ListConfigurationAssignmentsResult>
  >;
}
@armResourceOperations
interface ConfigurationAssignmentOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /**
         * Resource provider name
         */
        @path @segment("providers") providerName: string,

        /**
         * Resource parent type
         */
        @path resourceType: string,

        /**
         * Resource parent name
         */
        @path resourceName: string,

        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = ConfigurationAssignment,
        KeyName = "configurationAssignmentName",
        SegmentName = "configurationAssignments",
        NamePattern = ""
      >>,
      MaintenanceError
    > {}

@armResourceOperations
interface ConfigurationAssignmentOperationGroup {
  /**
   * Get configuration assignment for resource..
   */
  get is ConfigurationAssignmentOperationGroupOps.Read<ConfigurationAssignment>;

  /**
   * Register configuration for resource.
   */
  createOrUpdate is ConfigurationAssignmentOperationGroupOps.CreateOrUpdateSync<ConfigurationAssignment>;

  /**
   * Unregister configuration for resource.
   */
  delete is ConfigurationAssignmentOperationGroupOps.DeleteSync<
    ConfigurationAssignment,
    Response = ArmResponse<ConfigurationAssignment> | ArmDeletedNoContentResponse
  >;
}
@armResourceOperations
interface ConfigurationAssignmentsForSubscriptionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = ConfigurationAssignment,
        KeyName = "configurationAssignmentName",
        SegmentName = "configurationAssignments",
        NamePattern = ""
      >>,
      MaintenanceError
    > {}

@armResourceOperations
interface ConfigurationAssignmentsForSubscriptions {
  /**
   * Get configuration assignment for resource.
   */
  get is ConfigurationAssignmentsForSubscriptionOps.Read<ConfigurationAssignment>;

  /**
   * Register configuration for resource.
   */
  createOrUpdate is ConfigurationAssignmentsForSubscriptionOps.CreateOrUpdateSync<ConfigurationAssignment>;

  /**
   * Register configuration for resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ConfigurationAssignmentsForSubscriptionOps.CustomPatchSync<
    ConfigurationAssignment,
    PatchModel = ConfigurationAssignment
  >;

  /**
   * Unregister configuration for resource.
   */
  delete is ConfigurationAssignmentsForSubscriptionOps.DeleteSync<
    ConfigurationAssignment,
    Response = ArmResponse<ConfigurationAssignment> | ArmDeletedNoContentResponse
  >;

  /**
   * [UNSUPPORTED] Get configuration assignment within a subscription. This API is not implemented yet.
   */
  list is ConfigurationAssignmentsForSubscriptionOps.List<
    ConfigurationAssignment,
    Response = ArmResponse<ListConfigurationAssignmentsResult>
  >;
}
@armResourceOperations
interface ConfigurationAssignmentsForResourceGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = ConfigurationAssignment,
        KeyName = "configurationAssignmentName",
        SegmentName = "configurationAssignments",
        NamePattern = "^.+$"
      >>,
      MaintenanceError
    > {}

@armResourceOperations
interface ConfigurationAssignmentsForResourceGroup {
  /**
   * Get configuration assignment for resource..
   */
  get is ConfigurationAssignmentsForResourceGroupOps.Read<ConfigurationAssignment>;

  /**
   * Register configuration for resource.
   */
  createOrUpdate is ConfigurationAssignmentsForResourceGroupOps.CreateOrUpdateSync<ConfigurationAssignment>;

  /**
   * Register configuration for resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ConfigurationAssignmentsForResourceGroupOps.CustomPatchSync<
    ConfigurationAssignment,
    PatchModel = ConfigurationAssignment
  >;

  /**
   * Unregister configuration for resource.
   */
  delete is ConfigurationAssignmentsForResourceGroupOps.DeleteSync<
    ConfigurationAssignment,
    Response = ArmResponse<ConfigurationAssignment> | ArmDeletedNoContentResponse
  >;
}

@@doc(ConfigurationAssignment.name, "Configuration assignment name");
@@doc(ConfigurationAssignment.properties,
  "Properties of the configuration assignment"
);
@@doc(ConfigurationAssignments.createOrUpdateParent::parameters.resource,
  "The configurationAssignment"
);
@@doc(ConfigurationAssignmentOperationGroup.createOrUpdate::parameters.resource,
  "The configurationAssignment"
);
@@doc(ConfigurationAssignmentsForSubscriptions.createOrUpdate::parameters.resource,
  "The configurationAssignment"
);
@@doc(ConfigurationAssignmentsForSubscriptions.update::parameters.properties,
  "The configurationAssignment"
);
@@doc(ConfigurationAssignmentsForResourceGroup.createOrUpdate::parameters.resource,
  "The configurationAssignment"
);
@@doc(ConfigurationAssignmentsForResourceGroup.update::parameters.properties,
  "The configurationAssignment"
);
