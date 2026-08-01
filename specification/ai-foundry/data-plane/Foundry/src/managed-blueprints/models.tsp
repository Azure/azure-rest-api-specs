import "@typespec/versioning";
import "../common/models.tsp";
import "../common/service.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

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

model ManagedAgentIdentityBlueprint {
  @visibility(Lifecycle.Read)
  name: string;
}
