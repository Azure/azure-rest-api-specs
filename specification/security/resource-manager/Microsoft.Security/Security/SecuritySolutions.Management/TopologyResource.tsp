import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
@tag("Topology")
interface TopologyResources {
  /**
   * Gets a specific topology component.
   */
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  get is ArmResourceRead<TopologyResource, Error = CloudError>;

  /**
   * Gets a list that allows to build a topology view of a subscription and location.
   */
  @Azure.ResourceManager.Legacy.renamePathParameter("location", "ascLocation")
  listByHomeRegion is Extension.ListByTarget<
    Extension.Subscription,
    TopologyResource,
    Response = ArmResponse<TopologyList>,
    Error = CloudError
  >;
}

@@doc(TopologyResource.name, "Name of a topology resources collection.");
@@doc(TopologyResource.properties, "");
