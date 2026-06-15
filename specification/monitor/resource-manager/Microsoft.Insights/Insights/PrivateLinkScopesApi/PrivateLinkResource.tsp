import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AzureMonitorPrivateLinkScope.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PrivateLinkScopesApi;
/**
 * A private link resource
 */
model PrivateLinkResource is PrivateLink;
alias PrivateLinkOperations = PrivateLinks<PrivateLinkResource>;

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Gets the private link resources that need to be created for a Azure Monitor PrivateLinkScope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy private link operation"
  #suppress "@azure-tools/typespec-azure-resource-manager/invalid-parameter-rename" "preserve existing wire parameter name"
  @Azure.ResourceManager.Legacy.renamePathParameter(
    "privateLinkResourceName",
    "groupName"
  )
  get is PrivateLinkOperations.Read<AzureMonitorPrivateLinkScope>;

  /**
   * Gets the private link resources that need to be created for a Azure Monitor PrivateLinkScope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy operation returns a single page"
  #suppress "@azure-tools/typespec-azure-resource-manager/invalid-parameter-rename" "preserve existing wire parameter name"
  #suppress "@azure-tools/typespec-azure-resource-manager/legacy-type-usage" "legacy operation returns a single page"
  @Azure.ResourceManager.Legacy.renamePathParameter(
    "privateLinkResourceName",
    "groupName"
  )
  listByPrivateLinkScope is PrivateLinkOperations.ListSinglePageByParent<AzureMonitorPrivateLinkScope>;
}

@@doc(PrivateLinkResource.properties, "Resource properties.");
