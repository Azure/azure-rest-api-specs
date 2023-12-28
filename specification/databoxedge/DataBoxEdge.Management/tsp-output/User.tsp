import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataBoxEdge;
@doc("Represents a user who has access to one or more shares on the Data Box Edge/Gateway device.")
@parentResource(DataBoxEdgeDevice)
model User is ProxyResource<UserProperties> {
  @doc("The user name.")
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
