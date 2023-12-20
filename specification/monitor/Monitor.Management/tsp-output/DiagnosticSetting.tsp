import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Monitor;
@doc("The diagnostic setting resource.")
model DiagnosticSetting is ExtensionResource<DiagnosticSettings> {
  @doc("The name of the diagnostic setting.")
  @path
  @key("name")
  @segment("diagnosticSettings")
  name: string;
}

@armResourceOperations
interface DiagnosticSettings {
  @doc("Gets the active diagnostic settings for the specified resource.")
  get is ArmResourceRead<DiagnosticSetting>;
  @doc("Creates or updates diagnostic settings for the specified resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DiagnosticSetting>;
  @doc("Deletes existing diagnostic settings for the specified resource.")
  delete is ArmResourceDeleteSync<DiagnosticSetting>;
  @doc("Gets the active diagnostic settings list for the specified resource.")
  list is ArmResourceListByParent<DiagnosticSetting>;
}
