import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A private link resource
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Server)
@Azure.ResourceManager.Legacy.feature(Features.PrivateLinkResources)
model PrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResource,
    KeyName = "groupName",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
@Azure.ResourceManager.Legacy.feature(Features.PrivateLinkResources)
interface PrivateLinkResources {
  /**
   * Gets a private link resource for SQL server.
   */
  get is ArmResourceRead<PrivateLinkResource>;

  /**
   * Gets the private link resources for SQL server.
   */
  listByServer is ArmResourceListByParent<PrivateLinkResource>;
}

@@doc(PrivateLinkResource.name, "The name of the private link resource.");
@@doc(PrivateLinkResource.properties, "The private link resource group id.");
