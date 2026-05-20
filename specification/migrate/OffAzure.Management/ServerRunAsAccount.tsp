import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServerSiteResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * A run as account resource belonging to a site resource.
 */
@parentResource(ServerSiteResource)
model ServerRunAsAccount
  is Azure.ResourceManager.ProxyResource<RunAsAccountProperties> {
  ...ResourceNameParameter<
    Resource = ServerRunAsAccount,
    KeyName = "accountName",
    SegmentName = "runAsAccounts"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface ServerRunAsAccounts {
  /**
   * Get a ServerRunAsAccount
   */
  @tag("ServerRunAsAccountsController")
  get is ArmResourceRead<ServerRunAsAccount>;

  /**
   * List ServerRunAsAccount resources by ServerSiteResource
   */
  @tag("ServerRunAsAccountsController")
  listByServerSiteResource is ArmResourceListByParent<ServerRunAsAccount>;
}

@@doc(ServerRunAsAccount.name, " RunAsAccounts name");
@@doc(ServerRunAsAccount.properties,
  "The resource-specific properties for this resource."
);
