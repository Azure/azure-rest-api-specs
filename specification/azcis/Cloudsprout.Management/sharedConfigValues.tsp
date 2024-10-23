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
  @doc("The array of config values needs to be published or consumed.")
  @extension("x-ms-identifiers", [])
  sharedValues: Array<SharedValue>;

  @doc("CloudSprout environment to publish or consume the value to. Optional.")
  cloudSproutEnv?: string;

  @doc("Resource Provisioning state")
  @visibility("read")
  provisioningState?: SharedConfigValuesProvisioningState;
}

@doc("sharedConfigValues Resource")
model SharedConfigValuesResource
  is ProxyResource<SharedConfigValuesResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("resourceName")
  @segment("sharedConfigValues") // start with lower case
  @visibility("read")
  @path
  name: string;
}

@doc("The config whose value needs to be published or consumed.")
model SharedValue {
  @doc("The unique name in CloudSprout whose value needs to be published or consumed.")
  moniker: string;

  @doc("Moniker value to be published.")
  value?: string;

  @doc("Scope of Moniker value. Optional.")
  scope?: Scope;
}

@doc("GeoScope. Optional.")
model Scope {
  @doc("GeoType. The valid value is Cloud.")
  geoType: string;

  @doc("The GeoValue for the specified GeoType. If GeoType is Cloud, GeoValue is the applicable cloud name for the Moniker value.")
  geoValue: string;
}

@armResourceOperations
interface SharedConfigValues {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SharedConfigValuesResource>;
  listBySubscription is ArmListBySubscription<SharedConfigValuesResource>;
  listByResourceGroup is ArmResourceListByParent<SharedConfigValuesResource>;
  get is ArmResourceRead<SharedConfigValuesResource>;
  delete is ArmResourceDeleteWithoutOkAsync<SharedConfigValuesResource>;
}
