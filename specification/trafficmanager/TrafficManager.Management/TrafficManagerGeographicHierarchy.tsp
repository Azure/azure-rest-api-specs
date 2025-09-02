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
@singleton("default")
@tenantResource
model TrafficManagerGeographicHierarchy
  is Azure.ResourceManager.ProxyResource<GeographicHierarchyProperties> {
  ...ResourceNameParameter<
    Resource = TrafficManagerGeographicHierarchy,
    KeyName = "trafficManagerGeographicHierarchy",
    SegmentName = "trafficManagerGeographicHierarchies",
    NamePattern = ""
  >;
}

@armResourceOperations
interface TrafficManagerGeographicHierarchies {
  /**
   * Gets the default Geographic Hierarchy used by the Geographic traffic routing method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("GeographicHierarchies_GetDefault")
  getDefault is ArmResourceRead<
    TrafficManagerGeographicHierarchy,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = CloudError
  >;
}

@@doc(TrafficManagerGeographicHierarchy.name, "");
@@doc(TrafficManagerGeographicHierarchy.properties,
  "The properties of the Geographic Hierarchy resource."
);
