import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;

@parentResource(ResourceGroupLocationResource)
model TopologyResource
  is Azure.ResourceManager.ProxyResource<TopologyResourceProperties> {
  ...ResourceNameParameter<
    Resource = TopologyResource,
    KeyName = "topologyResourceName",
    SegmentName = "topologies",
    NamePattern = ""
  >;

  /**
   * Location where the resource is stored
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface TopologyResources {
  /**
   * Gets a specific topology component.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  @operationId("Topology_Get")
  get is ArmResourceRead<TopologyResource>;

  /**
   * Gets a list that allows to build a topology view of a subscription and location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  @operationId("Topology_ListByHomeRegion")
  listByHomeRegion is Extension.ListByTarget<
    Extension.Subscription,
    TopologyResource,
    Response = ArmResponse<TopologyList>
  >;
}

@@doc(TopologyResource.name, "Name of a topology resources collection.");
@@doc(TopologyResource.properties, "");
