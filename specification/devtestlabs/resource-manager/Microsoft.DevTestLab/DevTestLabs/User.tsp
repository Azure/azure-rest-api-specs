import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A user profile.
 */
@parentResource(Lab)
model User is Azure.ResourceManager.ProxyResource<UserProperties, false> {
  ...ResourceNameParameter<
    Resource = User,
    KeyName = "userName",
    SegmentName = "users",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface Users {
  /**
   * Get user profile.
   */
  get is ArmResourceRead<
    User,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=identity)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing user profile. This operation can take a while to complete.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    User,
    LroHeaders = ArmLroLocationHeader<FinalResult = User> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of user profiles. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Already contains tags"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<User, PatchModel = UserFragment>;

  /**
   * Delete user profile. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    User,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List user profiles in a given lab.
   */
  list is ArmResourceListByParent<
    User,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=identity)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<UserList>
  >;
}

@@doc(User.name, "The name of the user profile.");
@@doc(User.properties, "The properties of the resource.");
@@doc(Users.createOrUpdate::parameters.resource, "Profile of a lab user.");
@@doc(Users.update::parameters.properties, "Profile of a lab user.");
