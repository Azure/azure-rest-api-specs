import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MediaServicesAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Media;
@doc("A Streaming Locator resource")
@parentResource(MediaServicesAccount)
model StreamingLocator is ProxyResource<StreamingLocatorProperties> {
  @doc("The Streaming Locator name.")
  @path
  @key("streamingLocatorName")
  @segment("streamingLocators")
  name: string;
}

@armResourceOperations
interface StreamingLocators {
  @doc("Get the details of a Streaming Locator in the Media Services account")
  get is ArmResourceRead<StreamingLocator>;
  @doc("Create a Streaming Locator in the Media Services account")
  create is ArmResourceCreateOrReplaceSync<StreamingLocator>;
  @doc("Deletes a Streaming Locator in the Media Services account")
  delete is ArmResourceDeleteSync<StreamingLocator>;
  @doc("Lists the Streaming Locators in the account")
  list is ArmResourceListByParent<
    StreamingLocator,
    {
      ...BaseParameters<StreamingLocator>;

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
  @doc("List Content Keys used by this Streaming Locator")
  listContentKeys is ArmResourceActionSync<
    StreamingLocator,
    void,
    ListContentKeysResponse
  >;
  @doc("List Paths supported by this Streaming Locator")
  listPaths is ArmResourceActionSync<StreamingLocator, void, ListPathsResponse>;
}
