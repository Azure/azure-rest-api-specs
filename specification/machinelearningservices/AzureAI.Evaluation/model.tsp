import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "@typespec/openapi";
import "@typespec/versioning";

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
  init_params?: Record<string>;

  @doc("Data parameters of the evaluator.")
  data_mapping?: Record<string>;
}

@doc("Data Source for Application Insight.")
model AppInsightDataSource {
  @doc("Application Insight connection string.")
  connection_string: string;

  @doc("Query to fetch data.")
  query: string;
}

// @doc("Data source for Evaluation.")
// union DataSource {
//     dataset_id: string;
//     app_insights: AppInsightDataSource;
// }

@doc("Input Data for Evaluation.")
model Data{
  @doc("Data for evaluation.")
  source: string | AppInsightDataSource;
}

@doc("Output Location for Evaluation.")
model outputLocation {
  @doc("Output location for the evaluation.")
  dataPath: string;
}

@doc("Base Model and prompt for evaluation.")
model BaseModel {
  @doc("Base model for evaluation.")
  endpoint: string;

  @doc("System prompt to be used with base model.")
  prompt: string;

  @doc("parameters for evaluation.")
  parameters: Record<string>;
}

@doc("Evaluation Target.")
union EvaluationTarget {
    BaseModel
}

@doc("Evaluation Definition")
model Evaluation {
  @doc("Identifier of the evaluation.")
  id: string;

  @doc("Data for evaluation.")
  data: Data;

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
  evaluators?: Record<EvaluatorConfiguration>;

  @doc("Output location for the evaluation.")
  outputLocation?: string;

  @doc("Evaluation Target.")
  evaluation_target?: EvaluationTarget;
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
  @doc("Tags to be updated.")
  tags: Record<string>;
}


#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create reponses correctly"
alias ResourceCreatedResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<201> &
  T;

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create reponses correctly"
alias OkResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<200> &
  T;
