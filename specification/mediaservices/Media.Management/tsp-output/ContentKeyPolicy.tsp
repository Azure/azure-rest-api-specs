import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MediaService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Media;
@doc("A Content Key Policy resource.")
@parentResource(MediaService)
model ContentKeyPolicy is ProxyResource<ContentKeyPolicyProperties> {
  @doc("The Content Key Policy name.")
  @key("contentKeyPolicyName")
  @segment("contentKeyPolicies")
  name: string;
}

@armResourceOperations
interface ContentKeyPolicies {
  @doc("Get the details of a Content Key Policy in the Media Services account")
  get is ArmResourceRead<ContentKeyPolicy>;
  @doc("Create or update a Content Key Policy in the Media Services account")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ContentKeyPolicy>;
  @doc("Updates an existing Content Key Policy in the Media Services account")
  update is ArmCustomPatchSync<ContentKeyPolicy, ContentKeyPolicy>;
  @doc("Deletes a Content Key Policy in the Media Services account")
  delete is ArmResourceDeleteSync<ContentKeyPolicy>;
  @doc("Lists the Content Key Policies in the account")
  list is ArmResourceListByParent<
    ContentKeyPolicy,
    {
      ...BaseParameters<ContentKeyPolicy>;

      @doc("Restricts the set of items returned.")
      @query("$filter")
      $filter?: string;

      @doc("Specifies a non-negative integer n that limits the number of items returned from a collection. The service returns the number of available items up to but not greater than the specified value n.")
      @query("$top")
      $top?: int32;

      @doc("Specifies the key by which the result collection should be ordered.")
      @query("$orderby")
      $orderby?: string;
    }
  >;
  @doc("Get a Content Key Policy including secret values")
  getPolicyPropertiesWithSecrets is ArmResourceActionSync<
    ContentKeyPolicy,
    void,
    ContentKeyPolicyProperties
  >;
}
