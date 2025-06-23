import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Versioning;
using Azure.Core.Foundations;

namespace Azure.AI.Projects;

alias ServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias EvaluationsOperations = Azure.Core.ResourceOperations<ServiceTraits>;

alias ListEvaluationParameters = {
  @doc("Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2")
  @query
  tags?: string;

  @doc("Comma-separated list of property names (and optionally values). Example: prop1,prop2=value2")
  @query
  properties?: string;

  ...StandardListQueryParameters;
};

@route("evaluations")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
interface Evaluations {
  @doc("Get an evaluation run by name.")
  get is EvaluationsOperations.ResourceRead<Evaluation>;

  @doc("List evaluation runs")
  list is EvaluationsOperations.ResourceList<
    Evaluation,
    ListQueryParametersTrait<ListEvaluationParameters>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates an evaluation run.")
  @route("runs:run")
  @post
  createRun is Azure.Core.Foundations.Operation<
    {
      @doc("Evaluation to be run")
      @body
      evaluation: Evaluation;
    },
    ResourceCreatedResponse<Evaluation>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates an agent evaluation run.")
  @route("runs:runAgent")
  @post
  createAgentEvaluation is Azure.Core.Foundations.Operation<
    {
      @doc("Agent evaluation to be run")
      @body
      evaluation: AgentEvaluationRequest;
    },
    ResourceCreatedResponse<AgentEvaluation>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get agent evaluation results.")
  @route("/runs/agents/{runId}")
  @get
  getAgentEvaluationResults is Azure.Core.Foundations.Operation<
    {
      @doc("Agent run id, for agent API v1, it's `[thread_id]:[run_id]`; for agent API v2, it's only the run_id.")
      @path
      runId: string;
    },
    OkResponse<AgentEvaluation>
  >;

  // Evaluation Private APIs
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Check annotation supported by the service.")
  @route("/checkannotation")
  @get
  @useAuth(BearerAuth)
  @added(Versions.v2025_05_15_preview)
  @removed(Versions.v_latest)
  checkAnnotation(...Azure.Core.Foundations.ApiVersionParameter): {
    @statusCode statusCode: 200;

    @doc("List of supported annotation.")
    @body
    supportedAnnotationList: string[];
  };

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Submit the annotation.")
  @route("/submitannotation")
  @post
  @useAuth(BearerAuth)
  @added(Versions.v2025_05_15_preview)
  @removed(Versions.v_latest)
  submitAnnotation(
    ...Azure.Core.Foundations.ApiVersionParameter,

    @doc("Annotation data inputList of supported annotation.")
    @body
    annotationDTO: AnnotationDTO,
  ): {
    @statusCode statusCode: 202;

    @doc("The data for annotation.")
    @body
    fileContentResult: string;
  };

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union"
  #suppress "@azure-tools/typespec-autorest/union-unsupported" ""
  @doc("Poll for the operation results.")
  @route("/operations/{operationId}")
  @get
  @useAuth(BearerAuth)
  @added(Versions.v2025_05_15_preview)
  @removed(Versions.v_latest)
  operationResults(
    ...Azure.Core.Foundations.ApiVersionParameter,

    @doc("Operation ID for the polling operation.")
    @path
    operationId: string,
  ): {
    @statusCode statusCode: 200 | 202;

    @doc("The operation results.")
    @body
    
    operationResults: Record<unknown>[] | ChatCompletions;
  };

  // Upload API set
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Upload the result to an evaluation run.")
  @route("runs:upload")
  @post
  @useAuth(BearerAuth)
  @added(Versions.v2025_05_15_preview)
  @removed(Versions.v_latest)
  UploadRun is Azure.Core.Foundations.Operation<
    {
      @doc("Evaluation to upload.")
      @body
      evaluation: EvaluationUpload;
    },
    Evaluation
  >;

  #suppress "@typespec/http/patch-implicit-optional" ""
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Update the uploaded the result to an evaluation run.")
  @route("runs:updateUpload/{name}")
  @patch
  @useAuth(BearerAuth)
  @added(Versions.v2025_05_15_preview)
  @removed(Versions.v_latest)
  UploadUpdateRun is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the evaluation run to update.")
      @path
      name: string;

      @doc("Evaluation upload to update.")
      @body
      evaluation: EvaluationUpload;
    },
    Evaluation
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
