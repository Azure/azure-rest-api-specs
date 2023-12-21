import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Class representing detector definition")
@parentResource(Site)
model DiagnosticCategory is ProxyResource<DiagnosticCategoryProperties> {
  @doc("Diagnostic Category")
  @path
  @key("diagnosticCategory")
  @segment("diagnostics")
  name: string;
}

@armResourceOperations
interface Diagnostics {
  @doc("Description for Get Diagnostics Category")
  getSiteDiagnosticCategory is ArmResourceRead<DiagnosticCategory>;
  @doc("Description for Get Diagnostics Categories")
  listSiteDiagnosticCategories is ArmResourceListByParent<DiagnosticCategory>;
}
