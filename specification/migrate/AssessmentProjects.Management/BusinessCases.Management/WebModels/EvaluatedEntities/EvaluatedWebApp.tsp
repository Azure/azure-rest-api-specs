import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../../Common/ArmModels/AzureResourceProperties.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Evaluated web app resource.")
@parentResource(BusinessCase)
model EvaluatedWebApp is ProxyResource<EvaluatedWebAppProperties> {
  @doc("Business case Evaluated web App ARM name")
  @key("evaluatedWebAppName")
  @segment("evaluatedWebApps")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This is a hydrated resource with no PUT call."
@doc("Evaluated web app properties class.")
model EvaluatedWebAppProperties {
  @doc("Recommended Azure target.")
  recommendedAzureTarget?: string;

  @doc("Recommended Azure SKU name.")
  recommendedAzureSkuName?: string;

  @doc("Recommended Azure SKU size.")
  recommendedAzureSkuSize?: string;

  @doc("The server name.")
  serverName?: string;

  @doc("The workload.")
  workload?: string;

  @doc("The activity state.")
  activityState?: string;

  @doc("Is machine ready for migration.")
  readyForMigration?: string;
}
