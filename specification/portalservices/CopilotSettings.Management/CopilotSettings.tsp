import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
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
  @visibility("read")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
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
