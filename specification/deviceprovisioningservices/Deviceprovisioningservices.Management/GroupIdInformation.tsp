import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Devices;
/**
 * The group information for creating a private endpoint on a provisioning service
 */
model GroupIdInformation
  is Azure.ResourceManager.ProxyResource<GroupIdInformationProperties, false> {
  ...ResourceNameParameter<
    Resource = GroupIdInformation,
    KeyName = "groupId",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

@armResourceOperations
interface GroupIdInformations {
  /**
   * Get the specified private link resource for the given provisioning service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotDpsResource_GetPrivateLinkResources")
  getPrivateLinkResources is ArmResourceRead<GroupIdInformation>;

  /**
   * List private link resources for the given provisioning service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IotDpsResource_ListPrivateLinkResources")
  listPrivateLinkResources is ArmResourceListByParent<
    GroupIdInformation,
    Response = ArmResponse<PrivateLinkResources>
  >;
}

@@doc(GroupIdInformation.name, "The name of the private link resource");
@@doc(GroupIdInformation.properties,
  "The properties for a group information object"
);
