import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.PortalServices;

// For more information about the proxy vs tracked, see https://armwiki.azurewebsites.net/rp_onboarding/tracked_vs_proxy_resources.html?q=proxy%20resource
// For more information about tenant resources, see https://azure.github.io/typespec-azure/docs/howtos/ARM/resource-type#tenant-resources
// For more information about singleton resources, see https://azure.github.io/typespec-azure/docs/howtos/ARM/resource-type#singleton-resource
@doc("The copilot settings tenant resource definition.")
@singleton
@tenantResource
model CopilotSettingsResource
  is Azure.ResourceManager.ProxyResource<CopilotSettingsProperties> {
  @doc("The default copilot settings, applying to entire tenant.")
  @segment("copilotSettings")
  @key
  @visibility(Lifecycle.Read)
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;

  /**
   * Describes the managed identities for an Azure resource.
   */
  ...ManagedSystemAssignedIdentityProperty;

  /**
   * The Azure Region where the resource lives (will be set to "global" for this global proxy resource)
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Backwards compatibility with existing spec"
  location?: string;
}

@armResourceOperations
interface CopilotSettings {
  get is ArmResourceRead<CopilotSettingsResource>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    CopilotSettingsResource,
    TenantBaseParameters
  >;
  update is ArmResourcePatchSync<
    CopilotSettingsResource,
    CopilotSettingsProperties
  >;
  delete is ArmResourceDeleteSync<
    CopilotSettingsResource,
    TenantBaseParameters
  >;
}
