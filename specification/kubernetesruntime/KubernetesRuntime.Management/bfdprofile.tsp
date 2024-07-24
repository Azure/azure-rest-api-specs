import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.KubernetesRuntime;

@added(Versions.v2024_08_01)
@doc("A BfdProfile resource for an Arc connected cluster (Microsoft.Kubernetes/connectedClusters)")
model BfdProfile is ExtensionResource<BfdProfileProperties> {
  @doc("The name of the BfdProfile")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("bfdProfileName")
  @segment("bfdProfiles")
  @path
  name: string;
}

@added(Versions.v2024_08_01)
@doc("Details of the BfdProfile.")
model BfdProfileProperties {
  @doc("Receive interval in milliseconds")
  receiveInterval?: int32;

  @doc("Transmit interval in milliseconds")
  transmitInterval?: int32;

  @doc("Detect multiplier")
  detectMultiplier?: int32;

  @doc("Echo interval in milliseconds")
  echoInterval?: int32;

  @doc("Echo mode")
  echoMode?: EnableState;

  @doc("Passive mode")
  passiveMode?: EnableState;

  @doc("Minimul TTL")
  minimulTtl?: int32;

  @visibility("read")
  @doc("Resource provision state")
  provisioningState?: ProvisioningState;
}

@added(Versions.v2024_08_01)
@armResourceOperations(BfdProfile)
interface BfdProfiles {
  get is ArmResourceRead<BfdProfile>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BfdProfile>;
  delete is ArmResourceDeleteSync<BfdProfile>;
  listByParent is ArmResourceListByParent<BfdProfile>;
}
