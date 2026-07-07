import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
/**
 * The diagnostic settings category resource.
 */
@extensionResource
model DiagnosticSettingsCategoryResource
  is Azure.ResourceManager.ExtensionResource<DiagnosticSettingsCategory> {
  ...ResourceNameParameter<
    Resource = DiagnosticSettingsCategoryResource,
    KeyName = "name",
    SegmentName = "diagnosticSettingsCategories",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface DiagnosticSettingsCategoryResources {
  /**
   * Gets the diagnostic settings category for the specified resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiagnosticSettingsCategory_Get")
  @tag("DiagnosticSettingsCategories")
  get is Extension.Read<
    Extension.ScopeParameter,
    DiagnosticSettingsCategoryResource,
    Error = ErrorResponse
  >;

  /**
   * Lists the diagnostic settings categories for the specified resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiagnosticSettingsCategory_List")
  @tag("DiagnosticSettingsCategories")
  list is Extension.ListByTarget<
    Extension.ScopeParameter,
    DiagnosticSettingsCategoryResource,
    Response = ArmResponse<DiagnosticSettingsCategoryResourceCollection>,
    Error = ErrorResponse
  >;
}

@@doc(
  DiagnosticSettingsCategoryResource.name,
  "The name of the diagnostic setting."
);
@@doc(
  DiagnosticSettingsCategoryResource.properties,
  "The properties of a Diagnostic Settings Category."
);
