import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
namespace SecuritySolutionsAPI;

@parentResource(ArmLocationResource)
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
  location: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
@tag("Topology")
interface TopologyResources {
  /**
   * Gets a specific topology component.
   */
  get is ArmResourceRead<
    TopologyResource,
    BaseParameters = {
      ...CommonTypes.ApiVersionParameter;

      // unless tenant or extension
      ...CommonTypes.SubscriptionIdParameter;

      // unless tenant, subscription, location, or extension
      ...CommonTypes.ResourceGroupNameParameter;
    },
    Error = CloudError
  >;

  /**
   * Gets a list that allows to build a topology view of a subscription and location.
   */
  listByHomeRegion is Azure.ResourceManager.Extension.ListByTarget<
    Azure.ResourceManager.Extension.Subscription,
    TopologyResource,
    Response = ArmResponse<TopologyList>,
    Error = CloudError
  >;
}

@@doc(TopologyResource.name, "Name of a topology resources collection.");
@@doc(TopologyResource.properties, "");
