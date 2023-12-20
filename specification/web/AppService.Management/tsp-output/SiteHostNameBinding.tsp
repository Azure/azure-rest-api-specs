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
@doc("A hostname binding object.")
@parentResource(WebSite)
model SiteHostNameBinding is ProxyResource<HostNameBindingProperties> {
  @doc("Hostname in the hostname binding.")
  @path
  @key("hostName")
  @segment("hostNameBindings")
  name: string;
}

@armResourceOperations
interface SiteHostNameBindings {
  @doc("Description for Get the named hostname binding for an app (or deployment slot, if specified).")
  getHostNameBinding is ArmResourceRead<SiteHostNameBinding>;
  @doc("Description for Creates a hostname binding for an app.")
  createOrUpdateHostNameBinding is ArmResourceCreateOrReplaceSync<SiteHostNameBinding>;
  @doc("Description for Deletes a hostname binding for an app.")
  deleteHostNameBinding is ArmResourceDeleteSync<SiteHostNameBinding>;
  @doc("Description for Get hostname bindings for an app or a deployment slot.")
  listHostNameBindings is ArmResourceListByParent<SiteHostNameBinding>;
}
