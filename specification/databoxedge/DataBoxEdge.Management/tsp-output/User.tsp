import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
@doc("Represents a user who has access to one or more shares on the Data Box Edge/Gateway device.")
@parentResource(DataBoxEdgeDevice)
model User is ProxyResource<UserProperties> {
  @doc("The user name.")
  @path
  @key("name")
  @segment("users")
  name: string;
}

@armResourceOperations
interface Users {
  @doc("Gets the properties of the specified user.")
  get is ArmResourceRead<User>;

  @doc("Creates a new user or updates an existing user's information on a Data Box Edge/Data Box Gateway device.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<User>;

  @doc("Deletes the user on a databox edge/gateway device.")
  delete is ArmResourceDeleteAsync<User>;

  @doc("Gets all the users registered on a Data Box Edge/Data Box Gateway device.")
  listByDataBoxEdgeDevice is ArmResourceListByParent<
    User,
    {
      ...BaseParameters<User>;

      @doc("Specify $filter='Type eq <type>' to filter on user type property")
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@projectedName(Users.createOrUpdate::parameters.resource, "json", "user");
@@extension(Users.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "user"
);
@@doc(Users.createOrUpdate::parameters.resource, "The user details.");
