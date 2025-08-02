namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;

@armResourceOperations
interface CloudLinks {
  list is ArmResourceListByParent<
    CloudLink,
    Response = ArmResponse<ResourceList<CloudLink>>
  >;

  get is ArmResourceRead<CloudLink>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    CloudLink,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<CloudLink>;
}

@@clientName(CloudLinks.createOrUpdate::parameters.resource, "cloudLink");

@doc("Cloud Link status")
union CloudLinkStatus {
  string,

  @doc("is active")
  Active: "Active",

  @doc("is building")
  Building: "Building",

  @doc("is deleting")
  Deleting: "Deleting",

  @doc("is failed")
  Failed: "Failed",

  @doc("is disconnected")
  Disconnected: "Disconnected",
}

@doc("A cloud link resource")
@parentResource(PrivateCloud)
model CloudLink is ProxyResource<CloudLinkProperties> {
  @doc("Name of the cloud link.")
  @pattern("^[-\\w\\._]+$")
  @key("cloudLinkName")
  @path
  @segment("cloudLinks")
  name: string;
}

@doc("cloud link provisioning state")
union CloudLinkProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("The properties of a cloud link.")
model CloudLinkProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: CloudLinkProvisioningState;

  @doc("The state of the cloud link.")
  @visibility(Lifecycle.Read)
  status?: CloudLinkStatus;

  @doc("Identifier of the other private cloud participating in the link.")
  linkedCloud?: string;
}
