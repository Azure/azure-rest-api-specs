namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface IscsiPaths {
  listByPrivateCloud is ArmResourceListByParent<IscsiPath>;

  get is ArmResourceRead<IscsiPath>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    IscsiPath,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<IscsiPath>;
}

@doc("An iSCSI path resource")
@parentResource(PrivateCloud)
@singleton
model IscsiPath is ProxyResource<IscsiPathProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "existing api"
  @doc("Name of the iSCSI path resource")
  @key("iscsiPathName")
  @path
  @segment("iscsiPaths")
  name: string;
}

@doc("The properties of an iSCSI path resource")
model IscsiPathProperties {
  @doc("The state of the iSCSI path provisioning")
  @visibility("read")
  provisioningState?: IscsiPathProvisioningState;

  @doc("CIDR Block for iSCSI path.")
  @visibility("create", "read")
  networkBlock: string;
}

@doc("private cloud provisioning state")
union IscsiPathProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is pending")
  Pending: "Pending",

  @doc("is building")
  Building: "Building",

  @doc("is deleting")
  Deleting: "Deleting",

  @doc("is updating")
  Updating: "Updating",
}
