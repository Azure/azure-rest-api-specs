import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Insights;
@doc("The diagnostic setting resource.")
model DiagnosticSettingsResource is ExtensionResource<DiagnosticSettings> {
  @doc("The name of the diagnostic setting.")
  @key("name")
  @segment("diagnosticSettings")
  name: string;
}

@armResourceOperations
@projectedName("client", "DiagnosticSettings")
interface DiagnosticSettingsResources_DiagnosticSettings {
  @doc("Gets the active diagnostic settings for the specified resource.")
  get is ArmResourceRead<DiagnosticSettingsResource>;

  @doc("Creates or updates diagnostic settings for the specified resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DiagnosticSettingsResource>;

  @doc("Deletes existing diagnostic settings for the specified resource.")
  delete is ArmResourceDeleteSync<DiagnosticSettingsResource>;

  @doc("Gets the active diagnostic settings list for the specified resource.")
  list is ArmResourceListByParent<DiagnosticSettingsResource>;
}
