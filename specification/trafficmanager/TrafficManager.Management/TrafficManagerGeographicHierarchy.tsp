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
@tenantResource
model TrafficManagerGeographicHierarchy
  is Azure.ResourceManager.ProxyResource<GeographicHierarchyProperties> {
  /** Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName} */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  id?: Azure.Core.armResourceIdentifier;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @key("trafficManagerGeographicHierarchy")
  @segment("trafficManagerGeographicHierarchies")
  @pattern("^[a-zA-Z0-9-_.]+$")
  @path
  name: string;

  /** The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts" */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type?: Azure.Core.armResourceType;

  /** Azure Resource Manager metadata containing createdBy and modifiedBy information. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  systemData?: Azure.ResourceManager.CommonTypes.SystemData;
}

alias TrafficManagerGeographicHierarchyOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...Azure.ResourceManager.Legacy.Provider<TrafficManagerGeographicHierarchy>;
  },
  {
    /**
     * The name of the Geographic Hierarchy resource. Must be 'default'.
     */
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
  getDefault is TrafficManagerGeographicHierarchyOps.Read<TrafficManagerGeographicHierarchy>;
}

@@doc(TrafficManagerGeographicHierarchy.name, "");
@@doc(TrafficManagerGeographicHierarchy.properties,
  "The properties of the Geographic Hierarchy resource."
);
