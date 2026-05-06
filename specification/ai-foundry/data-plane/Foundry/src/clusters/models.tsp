import "../common/models.tsp";

namespace Azure.AI.Projects;

@doc("Request body for creating an interactive Ray command job on a compute cluster.")
model InteractiveRayJobCreate {
  @doc("Optional job name. If omitted, the service uses the Operation-Id header or generates one.")
  name?: string;

  @doc("Optional display name for the generated Ray job.")
  displayName?: string;

  @doc("Optional description for the generated Ray job.")
  description?: string;

  @doc("Optional tags to attach to the generated Ray job.")
  tags?: Record<string>;

  @doc("Number of compute nodes to reserve for the interactive Ray session.")
  instanceCount: int32;
}