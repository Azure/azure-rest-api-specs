using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("WebApp assessment service plan resource.")
@parentResource(WebAppAssessmentV3)
model WebAppServicePlanV3 is ProxyResource<WebAppServicePlanV3Properties> {
  @doc("Gets the Name of the WebApp assessment service plan.")
  @key("servicePlanName")
  @segment("webAppServicePlans")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("WebApp assessment service plan properties class.")
model WebAppServicePlanV3Properties {
  @doc("Target type of the webapp.")
  @visibility(Lifecycle.Read)
  webAppTargetType: WebAppTargetType;

  @doc("Type of webapp.")
  @visibility(Lifecycle.Read)
  webAppType: WebServerType;

  @doc("Webapp service plan name.")
  @visibility(Lifecycle.Read)
  webAppServicePlanName: string;

  @doc("Number of web apps.")
  @visibility(Lifecycle.Read)
  numberOfWebApps: int32;

  @doc("Monthly cost of the web app service plan.")
  @visibility(Lifecycle.Read)
  monthlyCost: float64;

  @doc("Storage used by the web app service plan.")
  @visibility(Lifecycle.Read)
  storage: float64;

  @doc("Number of scale-out instances.")
  @visibility(Lifecycle.Read)
  scaleOutInstances: int32;

  @doc("Number of cores.")
  @visibility(Lifecycle.Read)
  cores: int32;

  @doc("Amount of RAM.")
  @visibility(Lifecycle.Read)
  ram: float64;

  @doc("SKU name of the web app.")
  @visibility(Lifecycle.Read)
  webAppSkuName: string;

  @doc("SKU size of the web app.")
  @visibility(Lifecycle.Read)
  webAppSkuSize: string;

  @doc("Timestamp when the web app service plan was created.")
  @visibility(Lifecycle.Read)
  createdTimestamp: utcDateTime;

  @doc("Timestamp when the web app service plan was last updated.")
  @visibility(Lifecycle.Read)
  updatedTimestamp: utcDateTime;

  @doc("Cost components of the web app service plan.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  costComponents: CostComponent[];
}
