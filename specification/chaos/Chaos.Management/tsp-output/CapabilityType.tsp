import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./TargetType.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;
/**
 * Model that represents a Capability Type resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(TargetType)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(CapabilityTypeProperties)
model CapabilityType extends ProxyResourceBase {
  /**
   * String that represents a Capability Type resource name.
   */
  @pattern("^[a-zA-Z0-9\\-\\.]+-\\d\\.\\d$")
  @path
  @key("capabilityTypeName")
  @segment("capabilityTypes")
  @visibility("read")
  name: string;

  /**
   * The properties of the capability type resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: CapabilityTypeProperties;
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CapabilityTypes_List")
  list is ArmResourceListByParent<
    CapabilityType,
    {
      ...BaseParameters<CapabilityType>;

      /**
       * String that sets the continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;
    }
  >;
}
