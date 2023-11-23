import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
// FIXME: Setting has no properties property
@doc("The Setting.")
model Setting is ProxyResource<{}> {
  @doc("The setting name. Supports - Anomalies, EyesOn, EntityAnalytics, Ueba")
  @path
  @key("settingsName")
  @segment("settings")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface Settings {
  @doc("Gets a setting.")
  get is ArmResourceRead<Setting>;
  @doc("Updates setting.")
  update is ArmResourceCreateOrReplaceSync<Setting>;
  @doc("Delete setting of the product.")
  delete is ArmResourceDeleteSync<Setting>;
  @doc("List of all the settings")
  list is ArmResourceListByParent<Setting>;
}
