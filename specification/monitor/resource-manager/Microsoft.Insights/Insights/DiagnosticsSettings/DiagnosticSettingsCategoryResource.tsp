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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @tag("DiagnosticSettingsCategories")
  get is Extension.Read<
    Extension.ScopeParameter,
    DiagnosticSettingsCategoryResource,
    Error = ErrorResponse
  >;

  /**
   * Lists the diagnostic settings categories for the specified resource.
   */
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
