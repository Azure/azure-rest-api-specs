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
@subscriptionResource
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
      },
      KeysOf<ResourceNameParameter<
        Resource = ApplyUpdate,
        KeyName = "applyUpdateName",
        SegmentName = "applyUpdates",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ApplyUpdates {
  /**
   * Track maintenance updates to resource with parent
   */
  getParent is ApplyUpdateOps.Read<
    ApplyUpdate,
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
}
@armResourceOperations
interface ApplyUpdateOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** {resourceType} */
        @path @segment("{resourceType}") resourceName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = ApplyUpdate,
        KeyName = "applyUpdateName",
        SegmentName = "applyUpdates",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ApplyUpdateOperationGroup {
  /**
   * Track maintenance updates to resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplyUpdates_Get")
  get is ApplyUpdateOperationGroupOps.Read<
    ApplyUpdate,
    Parameters = {
      /**
       * Resource type
       */
      @path
      resourceType: string;
    }
  >;

  /**
   * Apply maintenance updates to resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplyUpdates_CreateOrUpdateOrCancel")
  createOrUpdateOrCancel is ApplyUpdateOperationGroupOps.CreateOrUpdateSync<
    ApplyUpdate,
    Parameters = {
      /**
       * Resource type
       */
      @path
      resourceType: string;
    }
  >;

  /**
   * Get Configuration records within a subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplyUpdates_List")
  list is ApplyUpdateOperationGroupOps.ListBySubscription<
    ApplyUpdate,
    Response = ArmResponse<ListApplyUpdate>,
    ErrorType = MaintenanceError
  >;
}

@@doc(ApplyUpdate.name, "applyUpdate Id");
@@doc(ApplyUpdate.properties, "Properties of the apply update");
@@doc(ApplyUpdateOperationGroup.createOrUpdateOrCancel::parameters.resource,
  "The ApplyUpdate"
);
