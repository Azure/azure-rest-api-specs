import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DigitalTwinsDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DigitalTwins;
/**
 * The group information for creating a private endpoint on Digital Twin.
 */
@parentResource(DigitalTwinsDescription)
model GroupIdInformation
  is Azure.ResourceManager.ProxyResource<GroupIdInformationProperties, false> {
  ...ResourceNameParameter<
    Resource = GroupIdInformation,
    KeyName = "resourceId",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

@armResourceOperations
interface GroupIdInformations {
  /**
   * Get the specified private link resource for the given Digital Twin.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkResources_Get")
  get is ArmResourceRead<GroupIdInformation>;

  /**
   * List private link resources for given Digital Twin.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkResources_List")
  list is ArmResourceListByParent<
    GroupIdInformation,
    Response = ArmResponse<GroupIdInformationResponse>
  >;
}

@@doc(GroupIdInformation.name, "The name of the private link resource.");
@@doc(GroupIdInformation.properties, "The group information properties.");
