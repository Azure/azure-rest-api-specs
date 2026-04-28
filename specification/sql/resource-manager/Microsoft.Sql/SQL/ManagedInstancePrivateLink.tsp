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
@parentResource(ManagedInstance)
model ManagedInstancePrivateLink
  is Azure.ResourceManager.ProxyResource<ManagedInstancePrivateLinkProperties> {
  ...ResourceNameParameter<
    Resource = ManagedInstancePrivateLink,
    KeyName = "groupName",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
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

@@doc(ManagedInstancePrivateLink.name,
  "The name of the private link resource."
);
@@doc(ManagedInstancePrivateLink.properties,
  "The private link resource group id."
);
