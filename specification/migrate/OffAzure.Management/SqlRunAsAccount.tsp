import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzure;
/**
 * A runasaccount resource belonging to a site resource.
 */
@parentResource(SqlSite)
model SqlRunAsAccount
  is Azure.ResourceManager.ProxyResource<RunAsAccountProperties> {
  ...ResourceNameParameter<
    Resource = SqlRunAsAccount,
    KeyName = "accountName",
    SegmentName = "runAsAccounts"
  >;
}

@armResourceOperations
interface SqlRunAsAccounts {
  /**
   * Get a SqlRunAsAccount
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlRunAsAccountsController_Get")
  get is ArmResourceRead<SqlRunAsAccount>;

  /**
   * List SqlRunAsAccount resources by SqlSite
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlRunAsAccountsController_ListBySqlSite")
  listBySqlSite is ArmResourceListByParent<SqlRunAsAccount>;
}

@@doc(SqlRunAsAccount.name, "SQL RunAsAccounts name");
@@doc(SqlRunAsAccount.properties,
  "The resource-specific properties for this resource."
);
