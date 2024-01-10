import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CertificateRegistration;
@doc("Source control configuration for an app.")
@singleton("web")
model SiteSourceControl is ProxyResource<SiteSourceControlProperties> {
  @key("sourcecontrol")
  @segment("sourcecontrols")
  name: string;
}

@armResourceOperations
@projectedName("client", "WebApps")
interface SiteSourceControls_WebApps {
  @doc("Description for Gets the source control configuration of an app.")
  getSourceControlSlot is ArmResourceRead<SiteSourceControl>;

  @doc("Description for Updates the source control configuration of an app.")
  createOrUpdateSourceControlSlot is ArmResourceCreateOrUpdateAsync<SiteSourceControl>;

  @doc("Description for Updates the source control configuration of an app.")
  updateSourceControlSlot is ArmCustomPatchSync<
    SiteSourceControl,
    SiteSourceControl
  >;

  @doc("Description for Deletes the source control configuration of an app.")
  deleteSourceControlSlot is ArmResourceDeleteSync<
    SiteSourceControl,
    {
      ...BaseParameters<SiteSourceControl>;

      @query("additionalFlags")
      additionalFlags?: string;
    }
  >;
}
