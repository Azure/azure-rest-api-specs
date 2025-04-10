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
@subscriptionResource
model ConfigurationAssignment
  is Azure.ResourceManager.ProxyResource<ConfigurationAssignmentProperties> {
  ...ResourceNameParameter<
    Resource = ConfigurationAssignment,
    KeyName = "configurationAssignmentName",
    SegmentName = "configurationAssignments",
    NamePattern = ""
  >;

  /**
   * Location of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  location?: string;
}

@armResourceOperations
interface ConfigurationAssignmentOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** {resourceParentType} */
        @path @segment("{resourceParentType}") resourceParentName: string,

        /** {resourceType} */
        @path @segment("{resourceType}") resourceName: string,

        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = ConfigurationAssignment,
        KeyName = "configurationAssignmentName",
        SegmentName = "configurationAssignments",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ConfigurationAssignments {
  /**
   * Get configuration assignment for resource..
   */
  getParent is ConfigurationAssignmentOps.Read<
    ConfigurationAssignment,
    Parameters = {
      /**
       * Resource parent type
       */
      @path
      resourceParentType: string;

      /**
       * Resource type
       */
      @path
      resourceType: string;
    }
  >;

  /**
   * Register configuration for resource.
   */
  createOrUpdateParent is ConfigurationAssignmentOps.CreateOrUpdateSync<
    ConfigurationAssignment,
    Parameters = {
      /**
       * Resource parent type
       */
      @path
      resourceParentType: string;

      /**
       * Resource type
       */
      @path
      resourceType: string;
    }
  >;

  /**
   * Unregister configuration for resource.
   */
  deleteParent is ConfigurationAssignmentOps.DeleteSync<
    ConfigurationAssignment,
    Parameters = {
      /**
       * Resource parent type
       */
      @path
      resourceParentType: string;

      /**
       * Resource type
       */
      @path
      resourceType: string;
    },
    Response = ArmResponse<ConfigurationAssignment> | ArmDeletedNoContentResponse
  >;

  /**
   * List configurationAssignments for resource.
   */
  listParent is ConfigurationAssignmentOps.List<
    ConfigurationAssignment,
    Parameters = {
      /**
       * Resource parent type
       */
      @path
      resourceParentType: string;

      /**
       * Resource type
       */
      @path
      resourceType: string;
    },
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
        ...Azure.ResourceManager.Legacy.Provider,

        /** {resourceType} */
        @path @segment("{resourceType}") resourceName: string,

        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = ConfigurationAssignment,
        KeyName = "configurationAssignmentName",
        SegmentName = "configurationAssignments",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ConfigurationAssignmentOperationGroup {
  /**
   * Get configuration assignment for resource..
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationAssignments_Get")
  get is ConfigurationAssignmentOperationGroupOps.Read<
    ConfigurationAssignment,
    Parameters = {
      /**
       * Resource type
       */
      @path
      resourceType: string;
    }
  >;

  /**
   * Register configuration for resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationAssignments_CreateOrUpdate")
  createOrUpdate is ConfigurationAssignmentOperationGroupOps.CreateOrUpdateSync<
    ConfigurationAssignment,
    Parameters = {
      /**
       * Resource type
       */
      @path
      resourceType: string;
    }
  >;

  /**
   * Unregister configuration for resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationAssignments_Delete")
  delete is ConfigurationAssignmentOperationGroupOps.DeleteSync<
    ConfigurationAssignment,
    Parameters = {
      /**
       * Resource type
       */
      @path
      resourceType: string;
    },
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
      >>
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationAssignmentsWithinSubscription_List")
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
      >>
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
