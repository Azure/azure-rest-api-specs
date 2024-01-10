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
@doc("Class representing detector definition")
@parentResource(Site)
model DiagnosticCategory is ProxyResource<DiagnosticCategoryProperties> {
  @doc("Diagnostic Category")
  @key("diagnosticCategory")
  @segment("diagnostics")
  name: string;
}

@armResourceOperations
@projectedName("client", "Diagnostics")
interface DiagnosticCategories_Diagnostics {
  @doc("Description for Get Diagnostics Category")
  getSiteDiagnosticCategory is ArmResourceRead<DiagnosticCategory>;

  @doc("Description for Get Diagnostics Categories")
  listSiteDiagnosticCategories is ArmResourceListByParent<DiagnosticCategory>;
}
