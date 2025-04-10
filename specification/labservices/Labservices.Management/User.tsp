import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.LabServices;
/**
 * User of a lab that can register for and use virtual machines within the lab.
 */
@parentResource(Lab)
model User is Azure.ResourceManager.ProxyResource<UserProperties, false> {
  ...ResourceNameParameter<
    Resource = User,
    KeyName = "userName",
    SegmentName = "users",
    NamePattern = "^[-\\w\\\\._\\\\(\\\\)]+$"
  >;
}

@armResourceOperations
interface Users {
  /**
   * Returns the properties of a lab user.
   */
  get is ArmResourceRead<User>;

  /**
   * Operation to create or update a lab user.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    User,
    Response = ArmResourceUpdatedResponse<User> | ArmResourceCreatedResponse<User> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: User;
    })
  >;

  /**
   * Operation to update a lab user.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    User,
    PatchModel = UserUpdate,
    Response = ArmResponse<User> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: User;
    })
  >;

  /**
   * Operation to delete a user resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    User,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns a list of all users for a lab.
   */
  listByLab is ArmResourceListByParent<
    User,
    Parameters = {
      /**
       * The filter to apply to the operation.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<PagedUsers>
  >;

  /**
   * Operation to invite a user to a lab.
   */
  invite is ArmResourceActionAsync<User, InviteBody, OkResponse>;
}

@@maxLength(User.name, 100);
@@minLength(User.name, 1);
@@doc(User.name,
  "The name of the user that uniquely identifies it within containing lab. Used in resource URIs."
);
@@doc(User.properties, "User resource properties");
@@doc(Users.createOrUpdate::parameters.resource, "The request body.");
@@doc(Users.update::parameters.properties, "The request body.");
@@doc(Users.invite::parameters.body, "The request body.");
