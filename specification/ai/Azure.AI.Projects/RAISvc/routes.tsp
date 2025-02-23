import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./model.tsp";
import "./main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Microsoft.MachineLearningServices;

interface RAISvc {
  // Evaluation APIs
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Get the supported annotation tasks.")
  @route("/checkannotation")
  @get
  getAnnotation is Azure.Core.Foundations.Operation<{}, string[]>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Submit a request for annotation.")
  @route("/submitannotation")
  @post
  submitAnnotation is Azure.Core.Foundations.Operation<
    {
      @doc("Properties of a Prompt Version.")
      @body
      body: AnnotationDTO;
    },
    global.ResourceCreatedOrOkResponse<LongRunningResponse>
  >;

  // Simulation APIs
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
    string
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Get the jailbreak dataset.")
  @route("/simulation/jailbreak/")
  @get
  getJailBreakDataset is Azure.Core.Foundations.Operation<{}, string>;

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
    global.ResourceCreatedOrOkResponse<LongRunningResponse>
  >;

  // Grader APIs
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Submit a request for graders.")
  @route("/submitaoaievaluation")
  @post
  submitAoaiEvaluation is Azure.Core.Foundations.Operation<
    {
      @doc("Properties of a Prompt Version.")
      @body
      body: GradersDTO;
    },
    global.ResourceCreatedOrOkResponse<LongRunningResponse>
  >;

  // Operation Results
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Waiting for bug fix: https://github.com/Azure/typespec-azure-pr/issues/3739."
  @doc("Get the operation result.")
  @route("/operations/{operationId}")
  @get
  getOperationResult is Azure.Core.Foundations.Operation<
    {
      @doc("Operation id.")
      @path
      operationId: string;
    },
    string
  >;
}
