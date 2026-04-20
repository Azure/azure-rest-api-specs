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

@armResourceOperations
interface ServerRunAsAccounts {
  /**
   * Get a ServerRunAsAccount
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServerRunAsAccountsController_Get")
  get is ArmResourceRead<ServerRunAsAccount>;

  /**
   * List ServerRunAsAccount resources by ServerSiteResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServerRunAsAccountsController_ListByServerSiteResource")
  listByServerSiteResource is ArmResourceListByParent<ServerRunAsAccount>;
}

@@doc(ServerRunAsAccount.name, " RunAsAccounts name");
@@doc(ServerRunAsAccount.properties,
  "The resource-specific properties for this resource."
);
