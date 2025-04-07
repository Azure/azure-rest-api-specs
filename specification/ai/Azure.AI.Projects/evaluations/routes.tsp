import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias EvaluationsOperations = Azure.Core.ResourceOperations<ServiceTraits>;

@route("evaluations")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v_latest)
interface Evaluations {
  @doc("Get an evaluation run by name.")
  get is EvaluationsOperations.ResourceRead<Evaluation>;

  @doc("List evaluation runs")
  list is EvaluationsOperations.ResourceList<
    Evaluation,
    ListQueryParametersTrait<StandardListQueryParameters>
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
    Evaluation
  >;

  // Evaluation Private APIs
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Check annotation supported by the service.")
  @route("/checkannotation")
  @get
  @useAuth(BearerAuth)
  @added(Versions.v2025_05_15_preview)
  @removed(Versions.v_latest)
  op checkAnnotation(
    @doc("Api Version.")
    @query apiVersion: string
  ): {
      @statusCode statusCode: 200;
      @doc("List of supported annotation.")
      @body supportedAnnotationList: string[];
  };

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Submit the annotation.")
  @route("/submitannotation")
  @post
  @useAuth(BearerAuth)
  @added(Versions.v2025_05_15_preview)
  @removed(Versions.v_latest)
  op submitAnnotation(
    @doc("Api Version.")
    @query apiVersion: string,
    @doc("Annotation data inputList of supported annotation.")
    @body annotationDTO: AnnotationDTO
  ): {
    @statusCode statusCode: 202;
    @doc("The data for annotation.")
    @body fileContentResult: string;
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
}
