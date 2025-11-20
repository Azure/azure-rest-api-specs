import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using Rest;
using Azure.ResourceManager;

namespace Microsoft.NetApp;
/**
 * Information regarding regionInfo Item.
 */
@singleton("default")
@parentResource(SubscriptionLocationResource)
model RegionInfoResource is Azure.ResourceManager.ProxyResource<RegionInfo> {
  ...ResourceNameParameter<
    Resource = RegionInfoResource,
    KeyName = "regionInfo",
    SegmentName = "regionInfos",
    NamePattern = ""
  >;
}

/**
 * List of regionInfo resources
 */
model RegionInfosList is Azure.Core.Page<RegionInfoResource>;

@armResourceOperations
interface RegionInfoResources {
  /**
   * Provides storage to network proximity and logical zone mapping information.
   */
  get is ArmResourceRead<
    RegionInfoResource,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Provides region specific information.
   */
  list is ArmResourceListByParent<
    RegionInfoResource,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<RegionInfosList>
  >;
}

@@doc(RegionInfoResource.name, "");
@@doc(RegionInfoResource.properties, "regionInfo properties");
