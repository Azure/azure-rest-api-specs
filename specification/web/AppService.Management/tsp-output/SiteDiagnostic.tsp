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
@doc("Class representing detector definition")
@parentResource(WebSite)
model SiteDiagnostic is ProxyResource<DiagnosticCategoryProperties> {
  @doc("Diagnostic Category")
  @path
  @key("diagnosticCategory")
  @segment("diagnostics")
  name: string;
}

@armResourceOperations
interface SiteDiagnostics {
  @doc("Description for Get Diagnostics Category")
  getSiteDiagnosticCategory is ArmResourceRead<SiteDiagnostic>;
  @doc("Description for Get Diagnostics Categories")
  listSiteDiagnosticCategories is ArmResourceListByParent<SiteDiagnostic>;
}
