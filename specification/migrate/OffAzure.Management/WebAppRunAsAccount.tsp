import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WebAppSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * Run as account REST Resource.
 */
@parentResource(WebAppSite)
model WebAppRunAsAccount
  is Azure.ResourceManager.ProxyResource<RunAsAccountProperties> {
  ...ResourceNameParameter<
    Resource = WebAppRunAsAccount,
    KeyName = "accountName",
    SegmentName = "runasaccounts"
  >;
}

@armResourceOperations
interface WebAppRunAsAccounts {
  /**
   * Method to get run as account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebAppRunAsAccountsController_Get")
  get is ArmResourceRead<WebAppRunAsAccount>;

  /**
   * Method to get all run as accounts.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebAppRunAsAccountsController_ListByWebAppSite")
  listByWebAppSite is ArmResourceListByParent<WebAppRunAsAccount>;
}

@@doc(WebAppRunAsAccount.name, "Run as account ARM name.");
@@doc(WebAppRunAsAccount.properties,
  "The resource-specific properties for this resource."
);
