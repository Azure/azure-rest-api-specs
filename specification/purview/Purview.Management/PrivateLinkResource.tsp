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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Account)
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
model PrivateLinkResource extends ProxyResource {
  @visibility(Lifecycle.Read)
  @path
  @key("groupId")
  @segment("privateLinkResources")
  name: string;

  properties?: PrivateLinkResourceProperties;
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

@@doc(PrivateLinkResource.name, "The private link resource name.");
@@doc(PrivateLinkResource.properties, "The private link resource properties.");
@@visibility(PrivateLinkResource.properties, Lifecycle.Read);
