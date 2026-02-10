import "./models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

alias RedTeamOps = FoundryAzureOperations<WithConditionalFoundryPreviewHeader<FoundryFeaturesOptInKeys.red_teams_v1_preview>>;

@route("redTeams")
@tag("Redteams")
interface RedTeams {

  // BUG: This operation (see OpenAPI3 file) is missing the "Foundry-Features" header.
  @doc("Get a redteam by name.")
  get is RedTeamOps.ResourceRead<RedTeam>;

  // BUG: This operation (see OpenAPI3 file) is missing the "Foundry-Features" header.
  @doc("List a redteam by name.")
  list is RedTeamOps.ResourceList<RedTeam>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates a redteam run.")
  @route("runs:run")
  @post
  create is FoundryDataPlaneOperation<
    {
      ...WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.red_teams_v1_preview>;

      @doc("Redteam to be run")
      @body
      RedTeam: RedTeam;
    },
    ResourceCreatedResponse<RedTeam>
  >;
}
