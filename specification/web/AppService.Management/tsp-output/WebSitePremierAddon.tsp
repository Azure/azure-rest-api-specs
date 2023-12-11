import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WebSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Premier add-on.")
@parentResource(WebSite)
model WebSitePremierAddon is TrackedResource<PremierAddOnProperties> {
  @doc("Add-on name.")
  @path
  @key("premierAddOnName")
  @segment("premieraddons")
  name: string;
}

@armResourceOperations
interface WebSitePremierAddons {
  @doc("Description for Gets a named add-on of an app.")
  getPremierAddOn is ArmResourceRead<WebSitePremierAddon>;
  @doc("Description for Updates a named add-on of an app.")
  addPremierAddOn is ArmResourceCreateOrReplaceSync<WebSitePremierAddon>;
  @doc("Description for Updates a named add-on of an app.")
  updatePremierAddOn is ArmResourcePatchSync<
    WebSitePremierAddon,
    PremierAddOnProperties
  >;
  @doc("Description for Delete a premier add-on from an app.")
  deletePremierAddOn is ArmResourceDeleteSync<WebSitePremierAddon>;
}
