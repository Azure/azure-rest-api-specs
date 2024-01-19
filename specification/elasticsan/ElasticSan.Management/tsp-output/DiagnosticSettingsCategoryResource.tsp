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
@doc("The diagnostic settings category resource.")
model DiagnosticSettingsCategoryResource
  is ExtensionResource<DiagnosticSettingsCategory> {
  @doc("The name of the diagnostic setting.")
  @path
  @key("name")
  @segment("diagnosticSettingsCategories")
  name: string;
}

@armResourceOperations
interface DiagnosticSettingsCategoryResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the diagnostic settings category for the specified resource.")
  @operationId("DiagnosticSettingsCategory_Get")
  get is ArmResourceRead<DiagnosticSettingsCategoryResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the diagnostic settings categories for the specified resource.")
  @operationId("DiagnosticSettingsCategory_List")
  list is ArmResourceListByParent<DiagnosticSettingsCategoryResource>;
}
