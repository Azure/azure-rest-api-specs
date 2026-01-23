import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

import "./models.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias RedTeamServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests; // NoRetryRequests suppresses @azure-tools/typespec-azure-core/conditional-requests-trait-missing

alias RedTeamOperations = Azure.Core.ResourceOperations<RedTeamServiceTraits>;

@route("redTeams")
interface RedTeams {
  @doc("Get a redteam by name.")
  get is RedTeamOperations.ResourceRead<RedTeamPreview>;

  @doc("List a redteam by name.")
  list is RedTeamOperations.ResourceList<RedTeamPreview>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates a redteam run.")
  @route("runs:run")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      ...FoundryBetaOptInHeader<FoundryPreviewOptInKeys.red_teams_v1>;

      @doc("Redteam to be run")
      @body
      RedTeam: RedTeamPreview;
    },
    ResourceCreatedResponse<RedTeamPreview>
  >;
}
