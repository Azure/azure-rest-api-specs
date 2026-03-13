import "@typespec/versioning";
import "../common/models.tsp";
import "../common/service.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@removed(Versions.v1)
@extension(
  "x-ms-foundry-meta",
  #{ required_previews: #[FoundryFeaturesOptInKeys.agent_endpoint_v1_preview] }
)
model CreateOrUpdateManagedAgentIdentityBlueprintRequest {
  @doc("""
    The unique name that identifies the managed agent identity blueprint.
    Name can be used to retrieve/update/delete the managed agent identity blueprint.
    - Must start and end with alphanumeric characters,
    - Can contain hyphens in the middle
    - Must not exceed 63 characters.
    """)
  @maxLength(63)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;
}

@removed(Versions.v1)
model ManagedAgentIdentityBlueprint {
  @visibility(Lifecycle.Read)
  name: string;
}
