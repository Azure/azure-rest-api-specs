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

// Common-types v5 emits this resource's id as arm-id, which is a known cross-version finding.
// Remove this note after 2025-10-01 is GA and becomes the v5 stable comparison baseline.
/**
 * Configuration Assignment
 */
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

@armResourceOperations
interface ConfigurationAssignmentOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /**
         * Resource provider name
         */
        @path
        @key
        @segment("providers")
        providerName: string,

        /**
         * Resource parent type
         */
        @path @key resourceParentType: string,

        /**
         * Resource parent name
         */
        @path @key resourceParentName: string,

        /**
         * Resource type
         */
        @path @key resourceType: string,

        /**
         * Resource name
         */
        @path @key resourceName: string,
      },
      {
        ...Extension.ExtensionProviderNamespace<ConfigurationAssignment>,
        ...ParentKeysOf<ConfigurationAssignment>,
      },
      {
        ...Extension.ExtensionProviderNamespace<ConfigurationAssignment>,
        ...KeysOf<ResourceNameParameter<
          Resource = ConfigurationAssignment,
          KeyName = "configurationAssignmentName",
          SegmentName = "configurationAssignments",
          NamePattern = ""
        >>,
      },
      "MaintenanceConfigurationAssignment"
    > {}

@armResourceOperations
interface ConfigurationAssignments {
  /**
   * Get configuration assignment for resource..
   */
  getParent is ConfigurationAssignmentOps.Read<
    ConfigurationAssignment,
    ErrorType = MaintenanceError
  >;

  /**
   * Register configuration for resource.
   */
  createOrUpdateParent is ConfigurationAssignmentOps.CreateOrUpdateSync<
    ConfigurationAssignment,
    ErrorType = MaintenanceError
  >;

  /**
   * Unregister configuration for resource.
   */
  deleteParent is ConfigurationAssignmentOps.DeleteSync<
    ConfigurationAssignment,
    Response =
      | ArmResponse<ConfigurationAssignment>
      | ArmDeletedNoContentResponse,
    ErrorType = MaintenanceError
  >;

  /**
   * List configurationAssignments for resource.
   */
  listParent is ConfigurationAssignmentOps.List<
    ConfigurationAssignment,
    Response = ArmResponse<ListConfigurationAssignmentsResult>,
    ErrorType = MaintenanceError
  >;
}

@armResourceOperations
interface ConfigurationAssignmentOperationGroupOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /**
         * Resource provider name
         */
        @path
        @key
        @segment("providers")
        providerName: string,

        /**
         * Resource parent type
         */
        @path @key resourceType: string,

        /**
         * Resource parent name
         */
        @path @key resourceName: string,
      },
      {
        ...Extension.ExtensionProviderNamespace<ConfigurationAssignment>,
        ...ParentKeysOf<ConfigurationAssignment>,
      },
      {
        ...Extension.ExtensionProviderNamespace<ConfigurationAssignment>,
        ...KeysOf<ResourceNameParameter<
          Resource = ConfigurationAssignment,
          KeyName = "configurationAssignmentName",
          SegmentName = "configurationAssignments",
          NamePattern = ""
        >>,
      },
      "MaintenanceGroupConfigurationAssignment"
    > {}

@armResourceOperations
interface ConfigurationAssignmentOperationGroup {
  /**
   * Get configuration assignment for resource..
   */
  get is ConfigurationAssignmentOperationGroupOps.Read<
    ConfigurationAssignment,
    ErrorType = MaintenanceError
  >;

  /**
   * Register configuration for resource.
   */
  createOrUpdate is ConfigurationAssignmentOperationGroupOps.CreateOrUpdateSync<
    ConfigurationAssignment,
    ErrorType = MaintenanceError
  >;

  /**
   * Unregister configuration for resource.
   */
  delete is ConfigurationAssignmentOperationGroupOps.DeleteSync<
    ConfigurationAssignment,
    Response =
      | ArmResponse<ConfigurationAssignment>
      | ArmDeletedNoContentResponse,
    ErrorType = MaintenanceError
  >;
}

@armResourceOperations
interface ConfigurationAssignmentsForSubscriptionOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
      },
      {
        ...Extension.ExtensionProviderNamespace<ConfigurationAssignment>,
        ...ParentKeysOf<ConfigurationAssignment>,
      },
      {
        ...Extension.ExtensionProviderNamespace<ConfigurationAssignment>,
        ...KeysOf<ResourceNameParameter<
          Resource = ConfigurationAssignment,
          KeyName = "configurationAssignmentName",
          SegmentName = "configurationAssignments",
          NamePattern = ""
        >>,
      },
      "MaintenanceSubscriptionConfigurationAssignment"
    > {}

@armResourceOperations
interface ConfigurationAssignmentsForSubscriptions {
  /**
   * Get configuration assignment for resource.
   */
  get is ConfigurationAssignmentsForSubscriptionOps.Read<
    ConfigurationAssignment,
    ErrorType = MaintenanceError
  >;

  /**
   * Register configuration for resource.
   */
  createOrUpdate is ConfigurationAssignmentsForSubscriptionOps.CreateOrUpdateSync<
    ConfigurationAssignment,
    ErrorType = MaintenanceError
  >;

  /**
   * Register configuration for resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ConfigurationAssignmentsForSubscriptionOps.CustomPatchSync<
    ConfigurationAssignment,
    PatchModel = ConfigurationAssignment,
    ErrorType = MaintenanceError
  >;

  /**
   * Unregister configuration for resource.
   */
  delete is ConfigurationAssignmentsForSubscriptionOps.DeleteSync<
    ConfigurationAssignment,
    Response =
      | ArmResponse<ConfigurationAssignment>
      | ArmDeletedNoContentResponse,
    ErrorType = MaintenanceError
  >;

  /**
   * [UNSUPPORTED] Get configuration assignment within a subscription. This API is not implemented yet.
   */
  list is ConfigurationAssignmentsForSubscriptionOps.List<
    ConfigurationAssignment,
    Response = ArmResponse<ListConfigurationAssignmentsResult>,
    ErrorType = MaintenanceError
  >;
}
/** Scope parameters shared by resource-group configuration assignment operations. */
model ConfigurationAssignmentsForResourceGroupScopeParameters {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;
}

/** Parent resource parameters shared by resource-group configuration assignment operations. */
model ConfigurationAssignmentsForResourceGroupParentParameters {
  ...Extension.ExtensionProviderNamespace<ConfigurationAssignment>;
  ...ParentKeysOf<ConfigurationAssignment>;
}

/** Configuration assignment name parameters used by the GET operation. */
model ConfigurationAssignmentsForResourceGroupReadNameParameters {
  ...Extension.ExtensionProviderNamespace<ConfigurationAssignment>;
  ...KeysOf<ResourceNameParameter<
    Resource = ConfigurationAssignment,
    KeyName = "configurationAssignmentName",
    SegmentName = "configurationAssignments",
    NamePattern = "^.+$"
  >>;
}

/** Configuration assignment name parameters used by write operations. */
model ConfigurationAssignmentsForResourceGroupWriteNameParameters {
  ...Extension.ExtensionProviderNamespace<ConfigurationAssignment>;

  // Stable 2023-04-01 omits the name pattern on PUT, PATCH, and DELETE.
  // Omit the name pattern on writes to match that contract while GET retains `^.+$`.
  ...KeysOf<ResourceNameParameter<
    Resource = ConfigurationAssignment,
    KeyName = "configurationAssignmentName",
    SegmentName = "configurationAssignments",
    NamePattern = ""
  >>;
}

/** GET operations retain the `^.+$` name pattern from the existing contract. */
@armResourceOperations
interface ConfigurationAssignmentsForResourceGroupReadOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      ConfigurationAssignmentsForResourceGroupScopeParameters,
      ConfigurationAssignmentsForResourceGroupParentParameters,
      ConfigurationAssignmentsForResourceGroupReadNameParameters
    > {}

/** Write operations omit the name pattern to match the stable 2023-04-01 contract. */
@armResourceOperations
interface ConfigurationAssignmentsForResourceGroupWriteOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      ConfigurationAssignmentsForResourceGroupScopeParameters,
      ConfigurationAssignmentsForResourceGroupParentParameters,
      ConfigurationAssignmentsForResourceGroupWriteNameParameters
    > {}

@armResourceOperations
interface ConfigurationAssignmentsForResourceGroup {
  /**
   * Get configuration assignment for resource..
   */
  get is ConfigurationAssignmentsForResourceGroupReadOps.Read<
    ConfigurationAssignment,
    ErrorType = MaintenanceError
  >;

  /**
   * Register configuration for resource.
   */
  createOrUpdate is ConfigurationAssignmentsForResourceGroupWriteOps.CreateOrUpdateSync<
    ConfigurationAssignment,
    ErrorType = MaintenanceError
  >;

  /**
   * Register configuration for resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ConfigurationAssignmentsForResourceGroupWriteOps.CustomPatchSync<
    ConfigurationAssignment,
    PatchModel = ConfigurationAssignment,
    ErrorType = MaintenanceError
  >;

  /**
   * Unregister configuration for resource.
   */
  delete is ConfigurationAssignmentsForResourceGroupWriteOps.DeleteSync<
    ConfigurationAssignment,
    Response =
      | ArmResponse<ConfigurationAssignment>
      | ArmDeletedNoContentResponse,
    ErrorType = MaintenanceError
  >;
}

@@doc(ConfigurationAssignment.name, "Configuration assignment name");
@@doc(
  ConfigurationAssignment.properties,
  "Properties of the configuration assignment"
);
@@doc(
  ConfigurationAssignments.createOrUpdateParent::parameters.resource,
  "The configurationAssignment"
);
@@doc(
  ConfigurationAssignmentOperationGroup.createOrUpdate::parameters.resource,
  "The configurationAssignment"
);
@@doc(
  ConfigurationAssignmentsForSubscriptions.createOrUpdate::parameters.resource,
  "The configurationAssignment"
);
@@doc(
  ConfigurationAssignmentsForSubscriptions.update::parameters.properties,
  "The configurationAssignment"
);
@@doc(
  ConfigurationAssignmentsForResourceGroup.createOrUpdate::parameters.resource,
  "The configurationAssignment"
);
@@doc(
  ConfigurationAssignmentsForResourceGroup.update::parameters.properties,
  "The configurationAssignment"
);
