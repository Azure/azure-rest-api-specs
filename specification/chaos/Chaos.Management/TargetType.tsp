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
// @locationResource
@subscriptionResource
model TargetType is ProxyResource<TargetTypeProperties> {
  /**
   * String that represents a Target Type resource name.
   */
  @pattern("^[a-zA-Z0-9_\\-\\.]+$")
  @path
  @key("targetTypeName")
  @segment("targetTypes")
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("TargetTypes_List")
  list is ArmResourceListByParent<
    TargetType,
    {
      ...BaseParameters<TargetType>;

      /**
       * String that represents a Location resource name.
       */
      @path
      @segment("locations")
      locationName: string;

      /**
       * String that sets the continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
}
