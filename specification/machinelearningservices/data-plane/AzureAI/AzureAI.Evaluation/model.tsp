import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Microsoft.MachineLearningServices;

@doc("Evaluator Configuration")
model EvaluatorConfiguration {
  @doc("Identifier of the evaluator.")
  id: string;

  @doc("Initialization parameters of the evaluator.")
  initParams?: Record<string>;

  @doc("Data parameters of the evaluator.")
  dataMapping?: Record<string>;
}

@doc("Abstract data class.")
@discriminator("type")
model InputData {
  @doc("Evaluation input data")
  id: string;
}

@doc("Data Source for Application Insight.")
model AppInsightsConfiguration extends InputData {

  type: "app_insights";

  @doc("Application Insight connection string.")
  connectionString: string;

  @doc("Query to fetch data.")
  query: string;
}

@doc("Dataset as source for evaluation.")
model Dataset extends InputData {
  type: "dataset";
}

@discriminator("type")
@doc("Evaluation Target.")
model EvaluationTarget {
  @doc("Name of the evaluation target.")
  name?: string;
}

@doc("Base Model and prompt for evaluation.")
model BaseModel extends EvaluationTarget {
  @doc("Base model for evaluation.")
  model_config: Record<Record<unknown>>;

  @doc("System prompt to be used with base model. This property will hold prompt asset id.")
  prompt: string;

  @doc("parameters for evaluation.")
  parameters: Record<string>;

  type: "base_model";
}

@doc("Evaluation Definition")
model Evaluation {
  @doc("Identifier of the evaluation.")
  id?: string;

  @doc("Data for evaluation.")
  data: InputData;

  @doc("Update stage to 'Archive' to archive the asset. Default is Development, which means the asset is under development.")
  displayName?: string;

  @doc("Description of the evaluation. It can be used to store additional information about the evaluation and is mutable.")
  description?: string;

  @doc("Metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;

  @doc("Status of the evaluation. It is set by service and is read-only.")
  @visibility("read")
  status?: string;

  @doc("Evaluation's tags. Unlike properties, tags are fully mutable.")
  tags?: Record<string>;

  @doc("Evaluation's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed.")
  properties?: Record<string>;

  @doc("Evaluators to be used for the evaluation.")
  evaluators: Record<EvaluatorConfiguration>;

  @doc("Evaluation Target.")
  evaluationTarget?: EvaluationTarget;
}

@doc("Paged evaluation items")
@pagedResult
model PagedEvaluation {
  @doc("The list of Evaluations.")
  @extension("x-ms-identifiers", [])
  @items
  value: Evaluation[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<Evaluation>;
}

@doc("Update Evaluation Request")
model UpdateEvaluationRequest {
  // Tags do we addition or overwrite?
  @doc("Tags to be updated.")
  tags: Record<string>;

  @doc("Display Name")
  displayName: string;

  @doc("Description")
  description: string;
}


#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create reponses correctly"
alias ResourceCreatedResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<201> &
  T;

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create reponses correctly"
alias OkResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<200> &
  T;
