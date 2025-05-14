import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias RedTeamServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests; // NoRetryRequests suppresses @azure-tools/typespec-azure-core/conditional-requests-trait-missing

alias RedTeamOperations = Azure.Core.ResourceOperations<RedTeamServiceTraits>;

@route("redTeams")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
interface RedTeams {
  @doc("Get a redteam by name.")
  get is RedTeamOperations.ResourceRead<RedTeam>;

  @doc("List a redteam by name.")
  list is RedTeamOperations.ResourceList<RedTeam>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates a redteam run.")
  @route("runs:run")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      @doc("Redteam to be run")
      @body
      RedTeam: RedTeam;
    },
    ResourceCreatedResponse<RedTeam>
  >;
}
