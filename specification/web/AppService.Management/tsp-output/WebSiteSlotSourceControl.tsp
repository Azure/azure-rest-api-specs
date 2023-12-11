import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Source control configuration for an app.")
@parentResource(WebSiteSlot)
@singleton("web")
model WebSiteSlotSourceControl is ProxyResource<SiteSourceControlProperties> {
  @key("web")
  @segment("sourcecontrols")
  name: string;
}

@armResourceOperations
interface WebSiteSlotSourceControls {
  @doc("Description for Gets the source control configuration of an app.")
  getSourceControlSlot is ArmResourceRead<WebSiteSlotSourceControl>;
  @doc("Description for Updates the source control configuration of an app.")
  createOrUpdateSourceControlSlot is ArmResourceCreateOrUpdateAsync<WebSiteSlotSourceControl>;
  @doc("Description for Updates the source control configuration of an app.")
  updateSourceControlSlot is ArmResourcePatchSync<
    WebSiteSlotSourceControl,
    SiteSourceControlProperties
  >;
  @doc("Description for Deletes the source control configuration of an app.")
  deleteSourceControlSlot is ArmResourceDeleteSync<
    WebSiteSlotSourceControl,
    {
      ...BaseParameters<WebSiteSlotSourceControl>;

      @query("additionalFlags")
      additionalFlags?: string;
    }
  >;
}
