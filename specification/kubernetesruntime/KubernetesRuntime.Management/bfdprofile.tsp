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
@doc("State for BFD Echo Mode")
union EchoModeState {
  string,

  @doc("Echo mode is enabled")
  Enabled: "Enabled",

  @doc("Echo mode is disabled")
  Disabled: "Disabled",
}

@added(Versions.v2024_08_01)
@doc("State for BFD Passive Mode")
union PassiveModeState {
  string,

  @doc("Passive mode is enabled")
  Enabled: "Enabled",

  @doc("Passive mode is disabled")
  Disabled: "Disabled",
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
  echoMode?: EchoModeState;

  @doc("Passive mode")
  passiveMode?: PassiveModeState;

  @doc("Minimum TTL")
  minimumTtl?: int32;

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
