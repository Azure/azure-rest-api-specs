import "./models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

alias RedTeamsPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.red_teams_v1_preview>;

@route("redTeams")
@tag("Redteams")
interface RedTeams {
  /** Retrieves the specified redteam and its configuration. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @summary("Get a redteam")
  get is FoundryResourceOperation<
    RedTeam,
    {
      ...RedTeamsPreviewHeader;
    },
    Azure.Core.Foundations.ResourceOkResponse<RedTeam>
  >;

  /** Returns the redteams available in the current project. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @summary("List redteams")
  @Rest.listsResource(RedTeam)
  list is FoundryResourceList<
    RedTeam,
    RedTeamsPreviewHeader,
    Azure.Core.Page<RedTeam>
  >;

  /** Submits a new redteam run for execution with the provided configuration. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Create a redteam run")
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
