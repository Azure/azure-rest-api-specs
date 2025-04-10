import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * A Streaming Locator resource
 */
model StreamingLocator
  is Azure.ResourceManager.ProxyResource<StreamingLocatorProperties> {
  ...ResourceNameParameter<
    Resource = StreamingLocator,
    KeyName = "streamingLocatorName",
    SegmentName = "streamingLocators",
    NamePattern = ""
  >;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceSync<
    StreamingLocator,
    Response = ArmResourceCreatedSyncResponse<StreamingLocator>
  >;

  /**
   * Deletes a Streaming Locator in the Media Services account
   */
  delete is ArmResourceDeleteSync<StreamingLocator>;

  /**
   * Lists the Streaming Locators in the account
   */
  list is ArmResourceListByParent<
    StreamingLocator,
    Parameters = {
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
    },
    Response = ArmResponse<StreamingLocatorCollection>
  >;

  /**
   * List Content Keys used by this Streaming Locator
   */
  listContentKeys is ArmResourceActionSync<
    StreamingLocator,
    void,
    ArmResponse<ListContentKeysResponse>
  >;

  /**
   * List Paths supported by this Streaming Locator
   */
  listPaths is ArmResourceActionSync<
    StreamingLocator,
    void,
    ArmResponse<ListPathsResponse>
  >;
}

@@doc(StreamingLocator.name, "The Streaming Locator name.");
@@doc(StreamingLocator.properties, "Properties of the Streaming Locator.");
@@doc(StreamingLocators.create::parameters.resource, "The request parameters");
