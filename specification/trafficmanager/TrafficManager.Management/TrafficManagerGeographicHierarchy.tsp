import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Class representing the Geographic hierarchy used with the Geographic traffic routing method.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
@singleton("default")
@tenantResource
model TrafficManagerGeographicHierarchy extends ProxyResource {
  properties?: GeographicHierarchyProperties;
}

@armResourceOperations
interface TrafficManagerGeographicHierarchies {
  /**
   * Gets the default Geographic Hierarchy used by the Geographic traffic routing method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  getDefault is ArmResourceRead<
    TrafficManagerGeographicHierarchy,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @path
      @segment("trafficManagerGeographicHierarchies")
      trafficManagerGeographicHierarchy: "default";
    },
    Error = CloudError
  >;
}

@@doc(TrafficManagerGeographicHierarchy.name, "");
@@doc(TrafficManagerGeographicHierarchy.properties,
  "The properties of the Geographic Hierarchy resource."
);
