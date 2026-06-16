import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * Represents a user who has access to one or more shares on the Data Box Edge/Gateway device.
 */
@parentResource(DataBoxEdgeDevice)
model User is Azure.ResourceManager.ProxyResource<UserProperties, false> {
  ...ResourceNameParameter<
    Resource = User,
    KeyName = "name",
    SegmentName = "users",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Users {
  /**
   * Gets the properties of the specified user.
   */
  get is ArmResourceRead<User, Error = CloudError>;

  /**
   * Creates a new user or updates an existing user's information on a Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    User,
    Response = ArmResourceUpdatedResponse<User> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = User> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = CloudError
  >;

  /**
   * Deletes the user on a databox edge/gateway device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    User,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all the users registered on a Data Box Edge/Data Box Gateway device.
   */
  listByDataBoxEdgeDevice is ArmResourceListByParent<
    User,
    Parameters = {
      /**
       * Specify $filter='Type eq <type>' to filter on user type property
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<UserList>,
    Error = CloudError
  >;
}

@@doc(User.name, "The user name.");
@@doc(User.properties, "The storage account credential properties.");
@@doc(Users.createOrUpdate::parameters.resource, "The user details.");
