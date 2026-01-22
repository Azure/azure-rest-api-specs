import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiManagementServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * A private link resource
 */
model PrivateLinkResource is PrivateLink;
alias PrivateLinkOperations = PrivateLinks<PrivateLinkResource>;

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Gets the private link resources
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Legacy.renamePathParameter(
    "privateLinkResourceName",
    "privateLinkSubResourceName"
  )
  getPrivateLinkResource is PrivateLinkOperations.Read<ApiManagementServiceResource>;

  /**
   * Gets the private link resources
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/legacy-type-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listPrivateLinkResources is PrivateLinkOperations.ListSinglePageByParent<ApiManagementServiceResource>;
}
@@doc(PrivateLinkResource.properties, "Resource properties.");
