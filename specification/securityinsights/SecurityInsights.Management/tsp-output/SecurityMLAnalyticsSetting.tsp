import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
// FIXME: SecurityMLAnalyticsSetting has no properties property
@doc("Security ML Analytics Setting")
model SecurityMLAnalyticsSetting is ProxyResource<{}> {
  @doc("Security ML Analytics Settings resource name")
  @path
  @key("settingsResourceName")
  @segment("securityMLAnalyticsSettings")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface SecurityMLAnalyticsSettings {
  @doc("Gets the Security ML Analytics Settings.")
  get is ArmResourceRead<SecurityMLAnalyticsSetting>;
  @doc("Creates or updates the Security ML Analytics Settings.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SecurityMLAnalyticsSetting>;
  @doc("Delete the Security ML Analytics Settings.")
  delete is ArmResourceDeleteSync<SecurityMLAnalyticsSetting>;
  @doc("Gets all Security ML Analytics Settings.")
  list is ArmResourceListByParent<SecurityMLAnalyticsSetting>;
}
