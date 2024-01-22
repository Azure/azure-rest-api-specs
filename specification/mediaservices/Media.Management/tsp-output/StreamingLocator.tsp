import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MediaService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * A Streaming Locator resource
 */
@parentResource(MediaService)
model StreamingLocator is ProxyResource<StreamingLocatorProperties> {
  /**
   * The Streaming Locator name.
   */
  @path
  @key("streamingLocatorName")
  @segment("streamingLocators")
  name: string;
}

@armResourceOperations
interface StreamingLocators {
  /**
   * Get the details of a Streaming Locator in the Media Services account
   */
  get is ArmResourceRead<StreamingLocator>;

  /**
   * Create a Streaming Locator in the Media Services account
   */
  create is ArmResourceCreateOrReplaceSync<StreamingLocator>;

  /**
   * Deletes a Streaming Locator in the Media Services account
   */
  delete is ArmResourceDeleteSync<StreamingLocator>;

  /**
   * Lists the Streaming Locators in the account
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("StreamingLocators_List")
  list is ArmResourceListByParent<
    StreamingLocator,
    {
      ...BaseParameters<StreamingLocator>;

      /**
       * Restricts the set of items returned.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Specifies a non-negative integer n that limits the number of items returned from a collection. The service returns the number of available items up to but not greater than the specified value n.
       */
      @query("$top")
      $top?: int32;

      /**
       * Specifies the key by which the result collection should be ordered.
       */
      @query("$orderby")
      $orderby?: string;
    }
  >;

  /**
   * List Content Keys used by this Streaming Locator
   */
  listContentKeys is ArmResourceActionSync<
    StreamingLocator,
    void,
    ListContentKeysResponse
  >;

  /**
   * List Paths supported by this Streaming Locator
   */
  listPaths is ArmResourceActionSync<StreamingLocator, void, ListPathsResponse>;
}

@@projectedName(StreamingLocators.create::parameters.resource,
  "json",
  "parameters"
);
@@extension(StreamingLocators.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(StreamingLocators.create::parameters.resource, "The request parameters");
