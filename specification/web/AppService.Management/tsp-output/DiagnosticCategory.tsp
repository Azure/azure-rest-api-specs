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
/**
 * Class representing detector definition
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Site)
@includeInapplicableMetadataInPayload(false)
model DiagnosticCategory extends ProxyOnlyResource {
  /**
   * Diagnostic Category
   */
  @path
  @key("diagnosticCategory")
  @segment("diagnostics")
  @visibility("read")
  name: string;

  /**
   * DiagnosticCategory resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: DiagnosticCategoryProperties;
}

@armResourceOperations
interface DiagnosticCategories {
  /**
   * Description for Get Diagnostics Category
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Diagnostics_GetSiteDiagnosticCategory")
  getSiteDiagnosticCategory is ArmResourceRead<DiagnosticCategory>;

  /**
   * Description for Get Diagnostics Categories
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Diagnostics_ListSiteDiagnosticCategories")
  listSiteDiagnosticCategories is ArmResourceListByParent<DiagnosticCategory>;
}
