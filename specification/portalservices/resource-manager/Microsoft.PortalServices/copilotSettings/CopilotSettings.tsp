using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.PortalServices;

// For more information about the proxy vs tracked, see https://armwiki.azurewebsites.net/rp_onboarding/tracked_vs_proxy_resources.html?q=proxy%20resource
// For more information about tenant resources, see https://azure.github.io/typespec-azure/docs/howtos/ARM/resource-type#tenant-resources
// For more inforamtion about singleton resources, see https://azure.github.io/typespec-azure/docs/howtos/ARM/resource-type#singleton-resource
@doc("The copilot settings tenant resource definition.")
@singleton
@tenantResource
model CopilotSettingsResource is ProxyResource<CopilotSettingsProperties> {
  @doc("The default copilot settings, applying to entire tenant.")
  @segment("copilotSettings")
  @key
  @visibility(Lifecycle.Read)
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

@armResourceOperations
interface CopilotSettings {
  get is ArmResourceRead<CopilotSettingsResource>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<CopilotSettingsResource>;
  update is ArmCustomPatchSync<
    CopilotSettingsResource,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      CopilotSettingsResource,
      CopilotSettingsProperties
    >
  >;
  delete is ArmResourceDeleteSync<CopilotSettingsResource>;
}
