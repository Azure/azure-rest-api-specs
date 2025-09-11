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

@armProviderNamespace
namespace Microsoft.PortalServices;

// For more information about the proxy vs tracked, see https://armwiki.azurewebsites.net/rp_onboarding/tracked_vs_proxy_resources.html?q=proxy%20resource
// For more information about tenant resources, see https://azure.github.io/typespec-azure/docs/howtos/ARM/resource-type#tenant-resources
// For more inforamtion about singleton resources, see https://azure.github.io/typespec-azure/docs/howtos/ARM/resource-type#singleton-resource
@doc("The Azure Portal settings tenant resource definition.")
@singleton
@tenantResource
model SettingsResource
  is Azure.ResourceManager.ProxyResource<SettingsProperties> {
  @doc("Azure Portal settings that apply to the entire tenant.")
  @segment("settings")
  @key
  @visibility(Lifecycle.Read)
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

@armResourceOperations
interface Settings {
  @doc("Get Azure Portal settings for the tenant.")
  get is ArmResourceRead<SettingsResource>;

  @doc("Create or update Azure Portal settings to apply to the entire tenant.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    SettingsResource,
    TenantBaseParameters
  >;

  @doc("Update Azure Portal settings to apply to the entire tenant.")
  update is ArmResourcePatchSync<SettingsResource, SettingsProperties>;

  @doc("Remove tenant-wide Azure Portal settings.")
  delete is ArmResourceDeleteSync<SettingsResource, TenantBaseParameters>;
}
