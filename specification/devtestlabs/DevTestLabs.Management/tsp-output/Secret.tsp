import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./User.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevTestLabs;
@doc("A secret.")
@parentResource(User)
model Secret is TrackedResource<SecretProperties> {
  @doc("The name of the secret.")
  @key("name")
  @segment("secrets")
  name: string;
}

@armResourceOperations
interface Secrets {
  @doc("Get secret.")
  get is ArmResourceRead<
    Secret,
    {
      ...BaseParameters<Secret>;

      @doc("Specify the $expand query. Example: 'properties($select=value)'")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Create or replace an existing secret. This operation can take a while to complete.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Secret>;
  @doc("Allows modifying tags of secrets. All other properties will be ignored.")
  update is ArmCustomPatchSync<Secret, SecretFragment>;
  @doc("Delete secret.")
  delete is ArmResourceDeleteSync<Secret>;
  @doc("List secrets in a given user profile.")
  list is ArmResourceListByParent<
    Secret,
    {
      ...BaseParameters<Secret>;

      @doc("Specify the $expand query. Example: 'properties($select=value)'")
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
