import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./TargetType.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.Chaos;
/**
 * Model that represents a Capability Type resource.
 */
@parentResource(TargetType)
model CapabilityType
  is Azure.ResourceManager.ProxyResource<CapabilityTypeProperties> {
  ...ResourceNameParameter<
    Resource = CapabilityType,
    KeyName = "capabilityTypeName",
    SegmentName = "capabilityTypes",
    NamePattern = "^[a-zA-Z0-9\\-\\.]+-\\d\\.\\d$"
  >;

  /**
   * Azure location of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing property implementation."
  location: azureLocation;
}

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
