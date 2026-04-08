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

namespace Microsoft.Insights;
/**
 * A private link resource
 */
@parentResource(AzureMonitorPrivateLinkScope)
model PrivateLinkResource is PrivateLink;
alias PrivateLinkOperations = PrivateLinks<PrivateLinkResource>;

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Gets the private link resources that need to be created for a Azure Monitor PrivateLinkScope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/invalid-parameter-rename" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Legacy.renamePathParameter(
    "privateLinkResourceName",
    "groupName"
  )
  get is PrivateLinkOperations.Read<PrivateLinkResource>;

  /**
   * Gets the private link resources that need to be created for a Azure Monitor PrivateLinkScope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/invalid-parameter-rename" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/legacy-type-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Legacy.renamePathParameter(
    "privateLinkResourceName",
    "groupName"
  )
  listByPrivateLinkScope is PrivateLinkOperations.ListSinglePageByParent<PrivateLinkResource>;
}

@@doc(PrivateLinkResource.properties, "Resource properties.");
