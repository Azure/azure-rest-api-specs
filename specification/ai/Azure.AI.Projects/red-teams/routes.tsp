import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Projects;

alias RedTeamServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests; // NoRetryRequests suppresses @azure-tools/typespec-azure-core/conditional-requests-trait-missing

alias RedTeamOperations = Azure.Core.ResourceOperations<RedTeamServiceTraits>;

@route("redTeams")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
interface RedTeams {
  @doc("Get a redteam by name.")
  get is RedTeamOperations.ResourceRead<RedTeam>;

  @doc("List a redteam by name.")
  list is RedTeamOperations.ResourceList<
    RedTeam,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates a redteam run.")
  @route("runs:run")
  @post
  createRun is Azure.Core.Foundations.Operation<
    {
      @doc("Redteam to be run")
      @body
      RedTeam: RedTeam;
    },
    RedTeam
  >;

  // Simulation Private APIs
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Simulation jailbreak.")
  @route("/simulation/jailbreak")
  @get
  @useAuth(BearerAuth)
  op jailbreak(
    @doc("Type of parameter.") @query type?: string,
    @doc("API version.") @query apiVersion: string
  ): {
      @statusCode statusCode: 200;
      @body jailbreakDataset: string;
  };

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Simulation template parameters.")
  @route("/simulation/template/parameters/")
    @get
    @useAuth(BearerAuth)
    op templateParameters(
      @doc("Type of parameter.") @query type?: string,
      @doc("API version.") @query apiVersion: string
    ): {
      @statusCode statusCode: 200;
      @doc("Template parameter dataset.")
      @body templateParametersDataset: string;
  };

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Simulation template parameters for image.")
  @route("/simulation/template/parameters/image")
    @get
    @useAuth(BearerAuth)
    op templateParametersImage(
      @doc("Path for image.") @query path: string,
      @doc("API version.") @query apiVersion: string
    ): {
      @statusCode statusCode: 200;
      @doc("File content result.")
      @body fileContentResult: string;
  };

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Simulation chat completion.")
  @route("/simulation/chat/completions/submit")
    @post
    @useAuth(BearerAuth)
    op chatCompletionsSubmit(
      @doc("Simulation request.") @body simulationDTO: SimulationDTO,
      @doc("API version.") @query apiVersion: string
    ): {
      @statusCode statusCode: 202;
      @doc("File content result.")
      @body fileContentResult: string;
  };
}
