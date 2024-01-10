import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CertificateRegistration;
@doc("The source control OAuth token.")
@tenantResource
model SourceControl is ProxyResource<SourceControlProperties> {
  @doc("Type of source control")
  @key("sourceControlType")
  @segment("sourcecontrols")
  name: string;
}

@armResourceOperations
@projectedName("client", "")
interface SourceControls_ {
  @doc("Description for Gets source control token")
  getSourceControl is ArmResourceRead<SourceControl>;

  @doc("Description for Updates source control token")
  updateSourceControl is ArmResourceCreateOrReplaceSync<SourceControl>;

  @doc("Description for Gets the source controls available for Azure websites.")
  listSourceControls is ArmResourceListByParent<SourceControl>;
}
