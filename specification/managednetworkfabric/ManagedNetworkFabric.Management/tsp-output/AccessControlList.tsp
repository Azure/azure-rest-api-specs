import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Access Control List resource definition.
 */
model AccessControlList is TrackedResource<AccessControlListProperties> {
  /**
   * Name of the Access Control List.
   */
  @path
  @key("accessControlListName")
  @segment("accessControlLists")
  name: string;
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
  create is ArmResourceCreateOrReplaceAsync<
    AccessControlList,
    BaseParameters<AccessControlList>,
    ArmAsyncOperationHeader
  >;

  /**
   * API to update certain properties of the Access Control List resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    AccessControlList,
    AccessControlListPatch,
    BaseParameters<AccessControlList>,
    ArmLroLocationHeader
  >;

  /**
   * Implements Access Control List DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    AccessControlList,
    BaseParameters<AccessControlList>,
    ArmAsyncOperationHeader
  >;

  /**
   * Implements AccessControlLists list by resource group GET method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AccessControlLists_ListByResourceGroup")
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
    CommonPostActionResponseForStateUpdate,
    BaseParameters<AccessControlList>,
    ArmLroLocationHeader
  >;

  /**
   * Implements the operation to the underlying resources.
   */
  resync is ArmResourceActionAsync<
    AccessControlList,
    void,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<AccessControlList>,
    ArmLroLocationHeader
  >;

  /**
   * Implements the operation to the underlying resources.
   */
  validateConfiguration is ArmResourceActionAsync<
    AccessControlList,
    void,
    ValidateConfigurationResponse,
    BaseParameters<AccessControlList>,
    ArmLroLocationHeader
  >;
}

@@projectedName(AccessControlLists.create::parameters.resource, "json", "body");
@@extension(AccessControlLists.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(AccessControlLists.create::parameters.resource, "Request payload.");
@@projectedName(AccessControlLists.update::parameters.properties,
  "json",
  "body"
);
@@extension(AccessControlLists.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(AccessControlLists.update::parameters.properties,
  "Access Control List properties to update."
);
@@doc(AccessControlLists.updateAdministrativeState::parameters.body,
  "Request payload."
);
