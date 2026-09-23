import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A private link resource
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(ManagedInstance)
@Azure.ResourceManager.Legacy.feature(
  Features.ManagedInstancePrivateLinkResources
)
model ManagedInstancePrivateLink
  is Azure.ResourceManager.ProxyResource<ManagedInstancePrivateLinkProperties> {
  ...ResourceNameParameter<
    Resource = ManagedInstancePrivateLink,
    KeyName = "groupName",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
@Azure.ResourceManager.Legacy.feature(
  Features.ManagedInstancePrivateLinkResources
)
interface ManagedInstancePrivateLinks {
  /**
   * Gets a private link resource for SQL server.
   */
  @tag("ManagedInstancePrivateLinkResources")
  get is ArmResourceRead<ManagedInstancePrivateLink>;

  /**
   * Gets the private link resources for SQL server.
   */
  @tag("ManagedInstancePrivateLinkResources")
  listByManagedInstance is ArmResourceListByParent<ManagedInstancePrivateLink>;
}

@@doc(
  ManagedInstancePrivateLink.name,
  "The name of the private link resource."
);
@@doc(
  ManagedInstancePrivateLink.properties,
  "The private link resource group id."
);
