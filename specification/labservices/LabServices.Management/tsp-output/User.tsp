import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.LabServices;
@doc("User of a lab that can register for and use virtual machines within the lab.")
@parentResource(Lab)
model User is ProxyResource<UserProperties> {
  @doc("The name of the user that uniquely identifies it within containing lab. Used in resource URIs.")
  @maxLength(100)
  @minLength(1)
  @pattern("^[-\\w\\\\._\\\\(\\\\)]+$")
  @path
  @key("userName")
  @segment("users")
  name: string;
}

@armResourceOperations
interface Users {
  @doc("Returns the properties of a lab user.")
  get is ArmResourceRead<User>;

  @doc("Operation to create or update a lab user.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<User>;

  @doc("Operation to update a lab user.")
  update is ArmCustomPatchAsync<
    User,
    UserUpdate,
    BaseParameters<User>,
    ArmLroLocationHeader
  >;

  @doc("Operation to delete a user resource.")
  delete is ArmResourceDeleteAsync<
    User,
    BaseParameters<User>,
    ArmLroLocationHeader
  >;

  @doc("Returns a list of all users for a lab.")
  listByLab is ArmResourceListByParent<
    User,
    {
      ...BaseParameters<User>;

      @doc("The filter to apply to the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;

  @doc("Operation to invite a user to a lab.")
  invite is ArmResourceActionAsync<
    User,
    InviteBody,
    void,
    BaseParameters<User>,
    ArmLroLocationHeader
  >;
}

@@projectedName(Users.createOrUpdate::parameters.resource, "json", "body");
@@extension(Users.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(Users.createOrUpdate::parameters.resource, "The request body.");
@@projectedName(Users.update::parameters.properties, "json", "body");
@@extension(Users.update::parameters.properties, "x-ms-client-name", "body");
@@doc(Users.update::parameters.properties, "The request body.");
@@doc(Users.invite::parameters.body, "The request body.");
