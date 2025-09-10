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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@singleton("default")
@tenantResource
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
@OpenAPI.extension("x-ms-azure-resource", true)
model TrafficManagerGeographicHierarchy extends ProxyResource {
  properties?: GeographicHierarchyProperties;
}

alias TrafficManagerGeographicHierarchyOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...Azure.ResourceManager.Legacy.Provider<TrafficManagerGeographicHierarchy>;
  },
  {
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @segment("trafficManagerGeographicHierarchies")
    @key("trafficManagerGeographicHierarchy")
    trafficManagerGeographicHierarchy: "default";
  },
  ErrorType = CloudError
>;

@armResourceOperations
interface TrafficManagerGeographicHierarchies {
  /**
   * Gets the default Geographic Hierarchy used by the Geographic traffic routing method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GeographicHierarchies_GetDefault")
  getDefault is TrafficManagerGeographicHierarchyOps.Read<TrafficManagerGeographicHierarchy>;
}

@@doc(TrafficManagerGeographicHierarchy.name, "");
@@doc(TrafficManagerGeographicHierarchy.properties,
  "The properties of the Geographic Hierarchy resource."
);
