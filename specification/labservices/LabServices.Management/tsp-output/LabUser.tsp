import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.LabServices;
@doc("User of a lab that can register for and use virtual machines within the lab.")
@parentResource(Lab)
model LabUser is ProxyResource<UserProperties> {
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
interface LabUsers {
  @doc("Returns the properties of a lab user.")
  get is ArmResourceRead<LabUser>;
  @doc("Operation to create or update a lab user.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LabUser>;
  @doc("Operation to update a lab user.")
  update is ArmResourcePatchAsync<LabUser, UserProperties>;
  @doc("Operation to delete a user resource.")
  delete is ArmResourceDeleteAsync<LabUser>;
  @doc("Returns a list of all users for a lab.")
  listByLab is ArmResourceListByParent<
    LabUser,
    {
      ...BaseParameters<LabUser>;

      @doc("The filter to apply to the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Operation to invite a user to a lab.")
  invite is ArmResourceActionAsync<LabUser, InviteBody, {}>;
}
