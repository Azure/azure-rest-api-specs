import "@typespec/versioning";
import "../common/models.tsp";
import "../common/service.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/friendly-name" "Explicit names preserve existing preview schemas after moving v1-unreachable types outside the service namespace."
namespace Azure.AI.ProjectsInternal {
  using Azure.AI.Projects;

  #suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
  @friendlyName("CreateOrUpdateManagedAgentIdentityBlueprintRequest")
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

  @friendlyName("ManagedAgentIdentityBlueprint")
  model ManagedAgentIdentityBlueprint {
    @visibility(Lifecycle.Read)
    name: string;
  }
}

namespace Azure.AI.Projects {
  alias CreateOrUpdateManagedAgentIdentityBlueprintRequest = Azure.AI.ProjectsInternal.CreateOrUpdateManagedAgentIdentityBlueprintRequest;

  alias ManagedAgentIdentityBlueprint = Azure.AI.ProjectsInternal.ManagedAgentIdentityBlueprint;
}
