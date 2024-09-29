import "../models/common.tsp";
import "../models/AccessControlList.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Access Control List resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@includeInapplicableMetadataInPayload(false)
model AccessControlList
  extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Name of the Access Control List.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("accessControlListName")
  @segment("accessControlLists")
  @visibility("read")
  name: string;

  /** The Access ControlList properties */
  properties: AccessControlListProperties;
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
  @parameterVisibility
  update is ArmCustomPatchAsync<AccessControlList, AccessControlListPatch>;

  /**
   * Implements Access Control List DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<AccessControlList>;

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
    CommonPostActionResponseForStateUpdate
  >;

  /**
   * Implements the operation to the underlying resources.
   */
  resync is ArmResourceActionAsync<
    AccessControlList,
    void,
    CommonPostActionResponseForStateUpdate
  >;

  /**
   * Implements the operation to the underlying resources.
   */
  validateConfiguration is ArmResourceActionAsync<
    AccessControlList,
    void,
    ValidateConfigurationResponse
  >;
}

@@doc(AccessControlLists.create::parameters.resource, "Request payload.");
@@doc(AccessControlLists.update::parameters.properties,
  "Access Control List properties to update."
);
@@doc(AccessControlLists.updateAdministrativeState::parameters.body,
  "Request payload."
);
