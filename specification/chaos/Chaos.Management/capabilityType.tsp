import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./capabilityType.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;

@armResourceOperations
interface CapabilityTypes {
  /**
   * Get a Capability Type resource for given Target Type and location.
   */
  get is ArmResourceRead<CapabilityType>;

  /**
   * Get a list of Capability Type resources for given Target Type and location.
   */
  list is ArmResourceListByParent<
    CapabilityType,
    Parameters = {
      /**
       * String that sets the continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;
    },
    Response = CapabilityTypeListResult
  >;
}

@@doc(CapabilityType.name,
  "String that represents a Capability Type resource name."
);
@@doc(CapabilityType.properties,
  "The properties of the capability type resource."
);
