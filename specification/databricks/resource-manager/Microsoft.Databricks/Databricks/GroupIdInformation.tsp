import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Databricks;
/**
 * The group information for creating a private endpoint on a workspace
 */
@parentResource(Workspace)
model GroupIdInformation
  is Azure.ResourceManager.ProxyResource<GroupIdInformationProperties, false> {
  ...ResourceNameParameter<
    Resource = GroupIdInformation,
    KeyName = "groupId",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface GroupIdInformations {
  /**
   * Get the specified private link resource for the given group id (sub-resource)
   */
  @tag("PrivateLinkResources")
  @summary("Get the specified private link resource")
  get is ArmResourceRead<GroupIdInformation, Error = ErrorResponse>;

  /**
   * List private link resources for a given workspace
   */
  @tag("PrivateLinkResources")
  @summary("List private link resources")
  list is ArmResourceListByParent<
    GroupIdInformation,
    Response = ArmResponse<PrivateLinkResourcesList>,
    Error = ErrorResponse
  >;
}

@@doc(GroupIdInformation.name, "The name of the private link resource");
@@doc(GroupIdInformation.properties, "The group id properties.");
