using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;

namespace Microsoft.AszLabHardware;

@doc("A collection of hardware")
model Lab is TrackedResource<LabProperties> {
  @doc("The name of the lab")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("labName")
  @segment("labs")
  @path
  name: string;
}

@doc("Details of the AszLabHw Lab.")
model LabProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Labs {
  get is ArmResourceRead<Lab>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Lab>;
  update is ArmTagsPatchAsync<Lab, LabProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Lab>;
  listByResourceGroup is ArmResourceListByParent<Lab>;
  listBySubscription is ArmListBySubscription<Lab>;
}
