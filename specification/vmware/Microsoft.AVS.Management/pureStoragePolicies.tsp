namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface PureStoragePolicies {
  @added(Versions.v2024_09_01)
  list is ArmResourceListByParent<PureStoragePolicy>;

  @added(Versions.v2024_09_01)
  get is ArmResourceRead<PureStoragePolicy>;

  @added(Versions.v2024_09_01)
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PureStoragePolicy>;

  @added(Versions.v2024_09_01)
  delete is ArmResourceDeleteWithoutOkAsync<PureStoragePolicy>;
}

@doc("An instance describing a Pure Storage Policy Based Management policy")
@parentResource(PrivateCloud)
model PureStoragePolicy is ProxyResource<PureStoragePolicyProperties> {
  @doc("Name of the storage policy.")
  @pattern("^[-\\w\\._]+$")
  @key("storagePolicyName")
  @path
  @segment("pureStoragePolicies")
  name: string;
}

@doc("Properties of a Pure Storage Policy Based Management policy")
model PureStoragePolicyProperties {
  @doc("Definition of a Pure Storage Policy Based Management policy")
  storagePolicyDefinition: string;

  @doc("Azure resource ID of the Pure Storage Pool associated with the storage policy")
  storagePoolId: string;

  @doc("The state of the Pure Storage Policy Based Management policy provisioning")
  @visibility(Lifecycle.Read)
  provisioningState?: PureStoragePolicyProvisioningState;
}

@doc("Pure Storage Policy Based Management policy provisioning state")
union PureStoragePolicyProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is deleting")
  Deleting: "Deleting",

  @doc("is updating")
  Updating: "Updating",
}
