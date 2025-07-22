import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("SharedConfigValuesResource properties")
model SharedConfigValuesResourceProperties {
  @doc("The unique name in CloudSprout whose value needs to be published or consumed.")
  moniker: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Azure services must not have properties of type `unknown`."
  @doc("Moniker value to be published.")
  value?: unknown;

  @doc("Scope of Moniker value. Optional.")
  scope?: Scope;

  @doc("CloudSprout environment to publish or consume the value to. Optional.")
  cloudSproutEnv?: string;

  @doc("Resource Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: SharedConfigValuesProvisioningState;
}

@doc("sharedConfigValues Resource")
model SharedConfigValuesResource
  is ProxyResource<SharedConfigValuesResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("resourceName")
  @segment("sharedConfigValues") // start with lower case
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

@doc("GeoScope. Optional.")
model Scope {
  @doc("GeoType. The valid values are Cloud, Geography, Region.")
  geoType: string;

  @doc("The GeoValue for the specified GeoType. If GeoType is Cloud, GeoValue is the applicable cloud name for the Moniker value.")
  geoValue: string;

  @doc("EnvType. The valid value are Prod, PPE, Test, Dev.")
  envType?: string;
}

@armResourceOperations
interface SharedConfigValues {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SharedConfigValuesResource>;
  listBySubscription is ArmListBySubscription<SharedConfigValuesResource>;
  listByResourceGroup is ArmResourceListByParent<SharedConfigValuesResource>;
  get is ArmResourceRead<SharedConfigValuesResource>;
  delete is ArmResourceDeleteWithoutOkAsync<SharedConfigValuesResource>;
}
