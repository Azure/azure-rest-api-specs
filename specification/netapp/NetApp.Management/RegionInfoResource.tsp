import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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

@armResourceOperations
interface RegionInfoResources {
  /**
   * Provides storage to network proximity and logical zone mapping information.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetAppResourceRegionInfos_Get")
  get is ArmResourceRead<
    RegionInfoResource,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Provides region specific information.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetAppResourceRegionInfos_List")
  list is ArmResourceListByParent<
    RegionInfoResource,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<RegionInfosList>
  >;
}

@@doc(RegionInfoResource.name, "");
@@doc(RegionInfoResource.properties, "regionInfo properties");
