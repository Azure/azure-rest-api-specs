import "../common/models.tsp";

namespace Azure.AI.Projects;

@doc("Request body for starting an interactive Ray session on a compute cluster.")
model RaySessionStart {
  @doc("Optional session name. If omitted, the service uses the Operation-Id header or generates one.")
  name?: string;

  @doc("Optional display name for the generated Ray session job.")
  displayName?: string;

  @doc("Optional description for the generated Ray session job.")
  description?: string;

  @doc("Optional tags to attach to the generated Ray session job.")
  tags?: Record<string>;

  @doc("Number of compute nodes to reserve for the interactive Ray session.")
  instanceCount: int32;

  @doc("Whether to expose the Ray Client server port through the AML proxy for remote access. When true, the Ray Client port is registered as an interactive endpoint, enabling remote ray.init() connections via the WebSocket-TCP bridge. When false or omitted, the Ray Client port is not accessible externally.")
  enableRemoteAccessClientServer?: boolean;

  @doc("The port for the Ray Client server. Defaults to 10001. Only relevant when enableRemoteAccessClientServer is true.")
  clientServerPort?: int32;
}