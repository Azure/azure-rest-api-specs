import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EdgeMarketplace;
/**
 * A publisher who provides offers.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" ""
@extensionResource
model Publisher
  is Azure.ResourceManager.ExtensionResource<PublisherProperties> {
  ...ResourceNameParameter<
    Resource = Publisher,
    KeyName = "publisherName",
    SegmentName = "publishers",
    NamePattern = "^.*$"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/improper-subscription-list-operation" ""
@armResourceOperations
interface Publishers {
  /**
   * List Publisher resources in subscription
   */
  listBySubscription is ArmListBySubscription<
    Publisher,
    {
      /**
       * Filter the result list using the given expression.
       */
      @query("$filter")
      filter?: string;

      /**
       * The number of result items to return.
       */
      @query("$top")
      top?: int32;

      /**
       * The number of result items to skip.
       */
      @query("skip")
      skip?: int32;

      /**
       * The maximum number of result items per page.
       */
      @query("maxpagesize")
      maxPageSize?: int32;

      /**
       * Skip over when retrieving results.
       */
      @query("$skipToken")
      skipToken?: string;
    }
  >;

  /**
   * Get a Publisher
   */
  get is ArmResourceRead<
    Publisher,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters
  >;

  /**
   * List Publisher resources by parent
   */
  list is ArmResourceListByParent<
    Publisher,
    BaseParameters = Azure.ResourceManager.Foundations.ExtensionBaseParameters,
    Parameters = {
      /**
       * The number of result items to return.
       */
      @query("$top")
      $top?: int32;

      /**
       * The number of result items to skip.
       */
      @query("skip")
      skip?: int32;

      /**
       * The maximum number of result items per page.
       */
      @query("maxpagesize")
      maxpagesize?: int32;

      /**
       * Filter the result list using the given expression.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Skip over when retrieving results.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}

@@doc(Publisher.name, "Name of the publisher");
@@doc(Publisher.properties,
  "The resource-specific properties for this resource."
);
