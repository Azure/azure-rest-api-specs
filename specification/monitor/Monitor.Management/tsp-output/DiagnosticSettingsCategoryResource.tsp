import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
/**
 * The diagnostic settings category resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(DiagnosticSettingsCategory)
model DiagnosticSettingsCategoryResource extends ExtensionResourceBase {
  /**
   * The name of the diagnostic setting.
   */
  @path
  @key("name")
  @segment("diagnosticSettingsCategories")
  @visibility("read")
  name: string;

  /**
   * The properties of a Diagnostic Settings Category.
   */
  @extension("x-ms-client-flatten", true)
  properties?: DiagnosticSettingsCategory;
}

@armResourceOperations
interface DiagnosticSettingsCategoryResources {
  /**
   * Gets the diagnostic settings category for the specified resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DiagnosticSettingsCategory_Get")
  get is ArmResourceRead<DiagnosticSettingsCategoryResource>;

  /**
   * Lists the diagnostic settings categories for the specified resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DiagnosticSettingsCategory_List")
  list is ArmResourceListByParent<DiagnosticSettingsCategoryResource>;
}
