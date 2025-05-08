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

  // Private Upload API
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Upload the result to a redteam run.")
  @route("runs:upload")
  @post
  @useAuth(BearerAuth)
  @added(Versions.v2025_05_15_preview)
  @removed(Versions.v_latest)
  UploadRun is Azure.Core.Foundations.Operation<
    {
      @doc("Redteam to upload.")
      @body
      redteam: RedTeamUpload;
    },
    RedTeam
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Update the uploaded the result to an redteam run.")
  @route("runs:updateUpload/{name}")
  @patch
  @useAuth(BearerAuth)
  @added(Versions.v2025_05_15_preview)
  @removed(Versions.v_latest)
  UploadUpdateRun is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the redteam run to update.")
      @path
      name: string;

      @doc("Redteam upload to update.")
      @body
      redteam: RedTeamUpload;
    },
    RedTeam
  >;


  // Simulation Private APIs
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Get the jailbreak dataset with type.")
  @route("/simulation/jailbreak/{type}")
  @get
  getJailBreakDatasetWithType is Azure.Core.Foundations.Operation<
    {
      @doc("Type of jailbreak dataset")
      @path
      type: string;
    },
    Array<string>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" 
  @doc("Get the attack objectives.")
  @route("/simulation/attackobjectives")
  @get
  getAttackObjectives is Azure.Core.Foundations.Operation<
    {
      @doc("Risk types for the attack objectives dataset")
      @query(#{ explode: true })
      riskTypes?: string[];

      @doc("The language for the attack objectives dataset, defaults to 'en'")
      @query
      lang?: string;

      @doc("The strategy")
      @query
      strategy?: string;
    },
    Array<AttackObjective>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Get the jailbreak dataset.")
  @route("/simulation/jailbreak/")
  @get
  getJailBreakDataset is Azure.Core.Foundations.Operation<{}, Array<string>>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Get template parameters with type.")
  @route("/simulation/template/parameters/{type}")
  @get
  getTemplateParametersWithType is Azure.Core.Foundations.Operation<
    {
      @doc("Type for the template parameters")
      @path
      type: string;
    },
    string
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Get template parameters.")
  @route("/simulation/template/parameters/")
  @get
  getTemplateParameters is Azure.Core.Foundations.Operation<{}, string>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Get the template parameters image.")
  @route("/simulation/template/parameters/image")
  @get
  getTemplateParametersImage is Azure.Core.Foundations.Operation<
    {
      @doc("Image path.")
      @query
      path: string;
    },
    string
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Submit a request for simulation.")
  @route("/simulation/chat/completions/submit")
  @post
  submitSimulation is Azure.Core.Foundations.Operation<
    {
      @doc("Properties of a Prompt Version.")
      @body
      body: SimulationDTO;
    },
    ResourceCreatedOrOkResponse<LongRunningResponse>
  >;
}
