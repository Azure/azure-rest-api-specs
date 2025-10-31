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
 * Apply Update request
 */
model ApplyUpdate
  is Azure.ResourceManager.ProxyResource<ApplyUpdateProperties> {
  ...ResourceNameParameter<
    Resource = ApplyUpdate,
    KeyName = "applyUpdateName",
    SegmentName = "applyUpdates",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ApplyUpdateOps
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
      {},
      {
        ...Extension.ExtensionProviderNamespace<ApplyUpdate>,
        ...KeysOf<ResourceNameParameter<
          Resource = ApplyUpdate,
          KeyName = "applyUpdateName",
          SegmentName = "applyUpdates",
          NamePattern = ""
        >>,
      }
    > {}

@armResourceOperations
interface ApplyUpdates {
  /**
   * Track maintenance updates to resource with parent
   */
  getParent is ApplyUpdateOps.Read<ApplyUpdate, ErrorType = MaintenanceError>;
}

@armResourceOperations
interface ApplyUpdateOperationGroupOps
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
      {},
      {
        ...Extension.ExtensionProviderNamespace<ApplyUpdate>,
        ...KeysOf<ResourceNameParameter<
          Resource = ApplyUpdate,
          KeyName = "applyUpdateName",
          SegmentName = "applyUpdates",
          NamePattern = ""
        >>,
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ApplyUpdateOperationGroup {
  /**
   * Track maintenance updates to resource
   */
  get is ApplyUpdateOperationGroupOps.Read<
    ApplyUpdate,
    ErrorType = MaintenanceError
  >;

  /**
   * Apply maintenance updates to resource
   */
  createOrUpdateOrCancel is ApplyUpdateOperationGroupOps.CreateOrUpdateSync<
    ApplyUpdate,
    ErrorType = MaintenanceError
  >;

  /**
   * Get Configuration records within a subscription
   */
  list is Extension.ListByTarget<
    Extension.Subscription,
    ApplyUpdate,
    Response = ArmResponse<ListApplyUpdate>,
    Error = MaintenanceError
  >;
}

@@doc(ApplyUpdate.name, "applyUpdate Id");
@@doc(ApplyUpdate.properties, "Properties of the apply update");
@@doc(ApplyUpdateOperationGroup.createOrUpdateOrCancel::parameters.resource,
  "The ApplyUpdate"
);
