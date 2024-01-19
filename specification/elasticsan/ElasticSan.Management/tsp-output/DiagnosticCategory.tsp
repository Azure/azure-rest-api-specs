import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
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
interface DiagnosticCategories {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get Diagnostics Category")
  @operationId("Diagnostics_GetSiteDiagnosticCategory")
  getSiteDiagnosticCategory is ArmResourceRead<DiagnosticCategory>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get Diagnostics Categories")
  @operationId("Diagnostics_ListSiteDiagnosticCategories")
  listSiteDiagnosticCategories is ArmResourceListByParent<DiagnosticCategory>;
}
