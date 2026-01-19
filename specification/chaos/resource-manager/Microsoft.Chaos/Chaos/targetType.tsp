import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./targetType.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;

@armResourceOperations
interface TargetTypes {
  /**
   * Get a Target Type resources for given location.
   */
  get is ArmResourceRead<
    TargetType,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Get a list of Target Type resources for given location.
   */
  list is ArmResourceListByParent<
    TargetType,
    Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Parameters = {
      /**
       * String that sets the continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;
    },
    Response = TargetTypeListResult
  >;
}

@@doc(TargetType.name, "String that represents a Target Type resource name.");
@@doc(TargetType.properties, "The properties of the target type resource.");
