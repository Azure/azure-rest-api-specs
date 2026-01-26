import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

import "./models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

alias RedTeamOps = FoundryAzureOperations<WithConditionalFoundryPreviewHeader<FoundryPreviewOptInKeys.red_teams_v1>>;

@route("redTeams")
@tag("Redteams")
interface RedTeams {
  @doc("Get a redteam by name.")
  get is RedTeamOps.ResourceRead<RedTeam>;

  @doc("List a redteam by name.")
  list is RedTeamOps.ResourceList<RedTeam>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates a redteam run.")
  @route("runs:run")
  @post
  create is FoundryDataPlaneOperation<
    {
      ...WithConditionalFoundryPreviewHeader<FoundryPreviewOptInKeys.red_teams_v1>;

      @doc("Redteam to be run")
      @body
      RedTeam: RedTeam;
    },
    ResourceCreatedResponse<RedTeam>
  >;
}
