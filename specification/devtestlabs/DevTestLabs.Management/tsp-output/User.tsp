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

namespace Microsoft.DevTestLab;
@doc("Profile of a lab user.")
@parentResource(Lab)
model User is TrackedResource<UserProperties> {
  @doc("The name of the user profile.")
  @path
  @key("name")
  @segment("users")
  name: string;
}

@armResourceOperations
interface Users {
  @doc("Get user profile.")
  get is ArmResourceRead<
    User,
    {
      ...BaseParameters<User>;

      @doc("Specify the $expand query. Example: 'properties($select=identity)'")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("Create or replace an existing user profile. This operation can take a while to complete.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<User>;

  @doc("Allows modifying tags of user profiles. All other properties will be ignored.")
  update is ArmCustomPatchSync<User, UserFragment>;

  @doc("Delete user profile. This operation can take a while to complete.")
  delete is ArmResourceDeleteAsync<User>;

  @doc("List user profiles in a given lab.")
  list is ArmResourceListByParent<
    User,
    {
      ...BaseParameters<User>;

      @doc("Specify the $expand query. Example: 'properties($select=identity)'")
      @query("$expand")
      $expand?: string;

      @doc("The filter to apply to the operation. Example: '$filter=contains(name,'myName')")
      @query("$filter")
      $filter?: string;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'")
      @query("$top")
      $top?: int32;

      @doc("The ordering expression for the results, using OData notation. Example: '$orderby=name desc'")
      @query("$orderby")
      $orderby?: string;
    }
  >;
}

@@projectedName(Users.createOrUpdate::parameters.resource, "json", "user");
@@extension(Users.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "user"
);
@@doc(Users.createOrUpdate::parameters.resource, "Profile of a lab user.");
@@projectedName(Users.update::parameters.properties, "json", "user");
@@extension(Users.update::parameters.properties, "x-ms-client-name", "user");
@@doc(Users.update::parameters.properties, "Profile of a lab user.");
