import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Access Control List resource definition.
 */
model AccessControlList
  is Azure.ResourceManager.TrackedResource<AccessControlListProperties, false> {
  ...ResourceNameParameter<
    Resource = AccessControlList,
    KeyName = "accessControlListName",
    SegmentName = "accessControlLists",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AccessControlLists {
  /**
   * Implements Access Control List GET method.
   */
  get is ArmResourceRead<AccessControlList>;

  /**
   * Implements Access Control List PUT method.
   */
  create is ArmResourceCreateOrReplaceAsync<AccessControlList>;

  /**
   * API to update certain properties of the Access Control List resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AccessControlList,
    PatchModel = AccessControlListPatch
  >;

  /**
   * Implements Access Control List DELETE method.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    AccessControlList,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Implements AccessControlLists list by resource group GET method.
   */
  listByResourceGroup is ArmResourceListByParent<AccessControlList>;

  /**
   * Implements AccessControlLists list by subscription GET method.
   */
  listBySubscription is ArmListBySubscription<AccessControlList>;

  /**
   * Implements the operation to the underlying resources.
   */
  updateAdministrativeState is ArmResourceActionAsync<
    AccessControlList,
    UpdateAdministrativeState,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;

  /**
   * Implements the operation to the underlying resources.
   */
  resync is ArmResourceActionAsync<
    AccessControlList,
    void,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;

  /**
   * Implements the operation to the underlying resources.
   */
  validateConfiguration is ArmResourceActionAsync<
    AccessControlList,
    void,
    ArmResponse<ValidateConfigurationResponse>
  >;
}

@@doc(AccessControlList.name, "Name of the Access Control List.");
@@doc(AccessControlList.properties, "Resource properties.");
@@doc(AccessControlLists.create::parameters.resource, "Request payload.");
@@doc(AccessControlLists.update::parameters.properties,
  "Access Control List properties to update."
);
@@doc(AccessControlLists.updateAdministrativeState::parameters.body,
  "Request payload."
);
