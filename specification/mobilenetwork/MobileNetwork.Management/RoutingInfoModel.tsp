import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PacketCoreControlPlane.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * Routing information
 */
@singleton("default")
@parentResource(PacketCoreControlPlane)
model RoutingInfoModel
  is Azure.ResourceManager.ProxyResource<RoutingInfoPropertiesFormat, false> {
  ...ResourceNameParameter<
    Resource = RoutingInfoModel,
    KeyName = "routingInfo",
    SegmentName = "routingInfo",
    NamePattern = ""
  >;
}

@armResourceOperations
interface RoutingInfoModels {
  /**
   * Get the routing information for the packet core.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RoutingInfo_Get")
  get is ArmResourceRead<RoutingInfoModel>;

  /**
   * List all of the routing information for the packet core.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RoutingInfo_List")
  list is ArmResourceListByParent<RoutingInfoModel>;
}

@@doc(RoutingInfoModel.name, "");
@@doc(RoutingInfoModel.properties, "Routing information properties");
