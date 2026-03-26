import "./models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

alias RedTeamsPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.red_teams_v1_preview>;

@route("redTeams")
@tag("Redteams")
interface RedTeams {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("Get a redteam by name.")
  get is Azure.Core.Foundations.ResourceOperation<
    RedTeam,
    {
      ...RedTeamsPreviewHeader;
    },
    Azure.Core.Foundations.ResourceOkResponse<RedTeam>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("List a redteam by name.")
  @Rest.listsResource(RedTeam)
  list is Azure.Core.Foundations.ResourceList<
    RedTeam,
    RedTeamsPreviewHeader,
    Azure.Core.Page<RedTeam>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates a redteam run.")
  @route("runs:run")
  @post
  create is FoundryDataPlaneOperation<
    {
      ...RedTeamsPreviewHeader;

      @doc("Redteam to be run")
      @body
      RedTeam: RedTeam;
    },
    ResourceCreatedResponse<RedTeam>
  >;
}
