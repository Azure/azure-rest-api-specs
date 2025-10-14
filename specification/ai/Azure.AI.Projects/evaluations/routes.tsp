import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.AI.Projects;

alias ServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias EvaluationsOperations = Azure.Core.ResourceOperations<ServiceTraits>;

@route("evaluations")
@added(Versions.v2025_05_15_preview)
interface Evaluations {
  @doc("Get an evaluation run by name.")
  get is EvaluationsOperations.ResourceRead<Evaluation>;

  @doc("List evaluation runs")
  list is EvaluationsOperations.ResourceList<Evaluation>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates an evaluation run.")
  @route("runs:run")
  @post
  create is Azure.Core.Foundations.Operation<
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
  @doc("Cancel an evaluation run by name")
  @post
  cancel is EvaluationsOperations.ResourceAction<
    Evaluation,
    {},
    Http.NoContentResponse
  >;

  @doc("Delete an evaluation run by name")
  delete is EvaluationsOperations.ResourceDelete<Evaluation>;

  // Evaluation Private APIs
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Check annotation supported by the service.")
  @route("/checkannotation")
  @get
  @useAuth(BearerAuth)
  @added(Versions.v2025_05_15_preview)
  checkAnnotation is Azure.Core.Foundations.Operation<
    {
      @doc("Client request ID header")
      @header("x-ms-client-request-id")
      clientRequestId?: uuid;
    },
    {
      @statusCode statusCode: 200;

      @doc("List of supported annotation.")
      @body
      supportedAnnotationList: string[];
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Submit the annotation.")
  @route("/submitannotation")
  @post
  @useAuth(BearerAuth)
  @added(Versions.v2025_05_15_preview)
  submitAnnotation is Azure.Core.Foundations.Operation<
    {
      @doc("Client request ID header")
      @header("x-ms-client-request-id")
      clientRequestId?: uuid;

      @doc("Annotation data inputList of supported annotation.")
      @Http.bodyRoot
      annotationDTO: AnnotationDTO;
    },
    {
      @statusCode statusCode: 202;

      @doc("The data for annotation.")
      @Http.bodyRoot
      fileContentResult: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union"
  @doc("Poll for the operation results.")
  @route("/operations/{operationId}")
  @get
  @useAuth(BearerAuth)
  @added(Versions.v2025_05_15_preview)
  operationResults is Azure.Core.Foundations.Operation<
    {
      @doc("Client request ID header")
      @header("x-ms-client-request-id")
      clientRequestId?: uuid;

      @doc("Operation ID for the polling operation.")
      @path
      operationId: string;
    },
    {
      @statusCode statusCode: 200;

      @doc("The operation results.")
      @body
      operationResults: Record<unknown>[];
    }
  >;

  // Upload API set
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Upload the result to an evaluation run.")
  @route("runs:upload")
  @post
  @useAuth(BearerAuth)
  @added(Versions.v2025_05_15_preview)
  UploadRun is Azure.Core.Foundations.Operation<
    {
      @doc("Client request ID header")
      @header("x-ms-client-request-id")
      clientRequestId?: uuid;

      @doc("Evaluation to upload.")
      @Http.bodyRoot
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
  UploadUpdateRun is Azure.Core.Foundations.Operation<
    {
      @doc("Client request ID header")
      @header("x-ms-client-request-id")
      clientRequestId?: uuid;

      @doc("Name of the evaluation run to update.")
      @path
      name: string;

      @doc("Evaluation upload to update.")
      @Http.bodyRoot
      evaluation: EvaluationUpload;
    },
    Evaluation
  >;
}
