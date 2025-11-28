import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;
/**
 * Model that represents a Target Type resource.
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model TargetType is ProxyResource<TargetTypeProperties> {
  /**
   * String that represents a Target Type resource name.
   */
  @pattern("^[a-zA-Z0-9_\\-\\.]+$")
  @path
  @key("targetTypeName")
  @segment("targetTypes")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface TargetTypes {
  /**
   * Get a Target Type resources for given location.
   */
  get is ArmResourceRead<TargetType>;

  /**
   * Get a list of Target Type resources for given location.
   */
  list is ArmResourceListByParent<
    TargetType,
    {
      ...SubscriptionBaseParameters;

      /**
       * String that sets the continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
}
