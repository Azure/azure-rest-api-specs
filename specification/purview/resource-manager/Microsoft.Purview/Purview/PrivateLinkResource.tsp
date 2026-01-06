import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Purview;
/**
 * A privately linkable resource.
 */
@parentResource(Account)
model PrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResource,
    KeyName = "groupId",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Gets a privately linkable resources for an account with given group identifier
   */
  @summary("Gets a privately linkable resources for an account with given group identifier.")
  getByGroupId is ArmResourceRead<
    PrivateLinkResource,
    Error = ErrorResponseModel
  >;

  /**
   * Gets a list of privately linkable resources for an account
   */
  @summary("Gets a list of privately linkable resources for an account.")
  listByAccount is ArmResourceListByParent<
    PrivateLinkResource,
    Response = ArmResponse<PrivateLinkResourceList>,
    Error = ErrorResponseModel
  >;
}

@@doc(PrivateLinkResource.name, "The group identifier.");
@@doc(PrivateLinkResource.properties, "The private link resource properties.");
