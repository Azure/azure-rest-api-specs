import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Monitor;
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
interface DiagnosticSettingsCategory {
  @doc("Gets the diagnostic settings category for the specified resource.")
  get is ArmResourceRead<DiagnosticSettingsCategoryResource>;
  @doc("Lists the diagnostic settings categories for the specified resource.")
  list is ArmResourceListByParent<DiagnosticSettingsCategoryResource>;
}
