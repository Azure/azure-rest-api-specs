import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CertificateRegistration;
@doc("A hostname binding object.")
@parentResource(Site)
model HostNameBinding is ProxyResource<HostNameBindingProperties> {
  @doc("Hostname in the hostname binding.")
  @key("hostName")
  @segment("hostNameBindings")
  name: string;
}

@armResourceOperations
@projectedName("client", "WebApps")
interface HostNameBindings_WebApps {
  @doc("Description for Get the named hostname binding for an app (or deployment slot, if specified).")
  getHostNameBinding is ArmResourceRead<HostNameBinding>;

  @doc("Description for Creates a hostname binding for an app.")
  createOrUpdateHostNameBinding is ArmResourceCreateOrReplaceSync<HostNameBinding>;

  @doc("Description for Deletes a hostname binding for an app.")
  deleteHostNameBinding is ArmResourceDeleteSync<HostNameBinding>;

  @doc("Description for Get hostname bindings for an app or a deployment slot.")
  listHostNameBindings is ArmResourceListByParent<HostNameBinding>;
}
