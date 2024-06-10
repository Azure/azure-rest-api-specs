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

@doc("PublishConfigValuesResource properties")
model PublishConfigValuesResourceProperties {
  @doc("PublishValues.")
  @extension("x-ms-identifiers", [])
  publishValues: Array<PublishValue>;

  @doc("CloudSprout environment to publish the value to. Optional.")
  cloudSproutEnv?: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: PublishConfigValuesProvisioningState;
}

@doc("publishConfigValues Resource")
model PublishConfigValuesResource
  is ProxyResource<PublishConfigValuesResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("resourceName")
  @segment("publishConfigValues") // start with lower case
  @visibility("read")
  @path
  name: string;
}

@doc("PublishValue.")
model PublishValue {
  @doc("Moniker")
  moniker: string;

  @doc("Moniker value to be published.")
  value: string;

  @doc("Scope of Moniker value. Optional.")
  scope?: Scope;
}

@doc("Scope. Optional.")
model Scope {
  @doc("GeoType. The valid value is Cloud.")
  geoType: string;

  @doc("The GeoValue for the specified GeoType. If GeoType is Cloud, GeoValue is the applicable cloud name for the Moniker value.")
  geoValue: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface PublishConfigValues {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PublishConfigValuesResource>;
  listBySubscription is ArmListBySubscription<PublishConfigValuesResource>;
  listByResourceGroup is ArmResourceListByParent<PublishConfigValuesResource>;
  get is ArmResourceRead<PublishConfigValuesResource>;
}
