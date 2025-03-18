import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

// namespace Azure.AI.Projects.RedTeams;
namespace Azure.AI.Projects;

alias ServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests; // NoRetryRequests supresses @azure-tools/typespec-azure-core/conditional-requests-trait-missing

alias RedTeamOperations = Azure.Core.ResourceOperations<ServiceTraits>;
alias AttackObjectiveOperations = Azure.Core.ResourceOperations<ServiceTraits>;


@route("/red-teams")
interface RedTeams {
  get is RedTeamsOperations.ResourceRead<red-team>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  // create is Operations.ResourceCreateWithServiceProvidedName<RedTeam>;
  // run is Operations.ResourceCollectionAction<RedTeam, {}, RedTeam>;
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  @route("attack")
  @post
  @doc("Run the RedTeam.")
  create(
    @query
    @doc("The API version to use for this operation.")
    apiVersion: string,

    @body
    @doc("RedTeam to run.")
    RedTeam: RedTeam,
  ): CreatedRedTeamResponse;

  list is RedTeamsOperations.ResourceList<
    RedTeam,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  update is RedTeamsOperations.ResourceUpdate<RedTeam>;
}

@route("/attack-objectives")
interface AttackObjectives {
  get is AttackObjectiveOperations.ResourceRead<AttackObjective>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  // create is Operations.ResourceCreateWithServiceProvidedName<RedTeam>;
  // run is Operations.ResourceCollectionAction<RedTeam, {}, RedTeam>;
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  @route("Generator")
  @post
  @doc("Generate attack objectives: statically or dynamically for Red Teaming.")
  create(
    @query
    @doc("The API version to use for this operation.")
    apiVersion: string,

    @body
    @doc("Attack objectives to create.")
    attackObjective: AttackObjective,
  ): CreatedAttackObjectivesResponse;

  list is AttackObjectiveOperations.ResourceList<
    AttackObjective,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  update is AttackObjectiveOperations.ResourceUpdate<AttackObjective>;
}