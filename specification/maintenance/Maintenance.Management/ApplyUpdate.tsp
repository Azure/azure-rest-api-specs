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
        @path @segment("providers") providerName: string,
        @path resourceParentType: string,
        @path resourceParentName: string,
        @path resourceType: string,
        @path resourceName: string,
        ...Azure.ResourceManager.Legacy.Provider,
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
    ApplyUpdate
  >;
}
@armResourceOperations
interface ApplyUpdateOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        @path @segment("providers") providerName: string,
        @path resourceType: string,
        @path resourceName: string,
        ...Azure.ResourceManager.Legacy.Provider,
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
    ApplyUpdate
  >;

  /**
   * Apply maintenance updates to resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplyUpdates_CreateOrUpdateOrCancel")
  createOrUpdateOrCancel is ApplyUpdateOperationGroupOps.CreateOrUpdateSync<
    ApplyUpdate
  >;

  /**
   * Get Configuration records within a subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplyUpdates_List")
  list is ApplyUpdateOperationGroupOps.ResourceListByParent<
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
