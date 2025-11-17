import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./PrivateLinkResource.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;

alias PrivateLinkOperations = PrivateLinks<PrivateLinkResource>;

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Gets a private link resource by a specified group name for a container registry.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Legacy.renamePathParameter(
    "privateLinkResourceName",
    "groupName"
  )
  getPrivateLinkResource is PrivateLinkOperations.Read<Registry>;

  /**
   * Lists the private link resources for a container registry.
   */
  @list
  listPrivateLinkResources is PrivateLinkOperations.ListByParent<
    Registry,
    Response = ArmResponse<PrivateLinkResourceListResult>
  >;
}

@@doc(PrivateLinkResource.name, "The name of the private link resource.");
@@doc(PrivateLinkResource.properties,
  "A resource that supports private link capabilities."
);
