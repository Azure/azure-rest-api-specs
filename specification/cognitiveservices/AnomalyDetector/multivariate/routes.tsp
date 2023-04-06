import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace AnomalyDetector.Multivariate;

@get
@route("/multivariate/detect-batch/{resultId}")
@summary("Get Multivariate Anomaly Detection Result")
@doc("""
For asynchronous inference, get a multivariate anomaly detection result based on the
resultId value that the BatchDetectAnomaly API returns.
""")
// To improve CADL implementation apply: https://github.com/Azure/azure-rest-api-specs/issues/21527
op GetMultivariateBatchDetectionResult(
  @format("uuid")
  @doc("ID of a batch detection result.")
  @path resultId: string,
): MultivariateDetectionResult | ResponseError;


@post
@route("/multivariate/models")
@summary("Train a Multivariate Anomaly Detection Model")
@doc("""
Create and train a multivariate anomaly detection model. The request must
include a source parameter to indicate an Azure Blob
Storage URI that's accessible to the service. There are two types of data input. The Blob Storage URI can point to an Azure Blob
Storage folder that contains multiple CSV files, where each CSV file has
two columns, time stamp and variable. Or the Blob Storage URI can point to a single blob that contains a CSV file that has all the variables and a
time stamp column.
""")
// To improve CADL implementation apply: https://github.com/Azure/azure-rest-api-specs/issues/21527
op TrainMultivariateModel(
  @doc("Model information.")
  @body modelInfo: ModelInfo,
): {
  @statusCode statusCode: 201,
  @doc("Location and ID of the model.")
  @header Location: string,
  @body result: AnomalyDetectionModel
  } | ResponseError;

@get
@route("/multivariate/models")
@summary("List Multivariate Models")
@doc("List models of a resource.")
// To improve CADL implementation apply: https://github.com/Azure/azure-rest-api-specs/issues/21527
op ListMultivariateModels(
  @doc("Skip indicates how many models will be skipped.")
  @query
  skip?: int32 = 0;

  @doc("Top indicates how many models will be fetched.")
  @query
  top?: int32;
): ModelList | ResponseError;


@summary("Delete Multivariate Model")
@doc("Delete an existing multivariate model according to the modelId value.")
@delete
@route("/multivariate/models/{modelId}")
// To improve CADL implementation apply: https://github.com/Azure/azure-rest-api-specs/issues/21527
op DeleteMultivariateModel(
  @doc("Model identifier.")
  @path
  modelId: string,
): {
  @doc("Delete model successfully.")
  @statusCode
  statusCode: 204
  } | ResponseError;

@summary("Get Multivariate Model")
@doc("""
Get detailed information about the multivariate model, including the training status
and variables used in the model.
""")
@get
@route("/multivariate/models/{modelId}")
// To improve CADL implementation apply: https://github.com/Azure/azure-rest-api-specs/issues/21527
op GetMultivariateModel(
  @doc("Model identifier.")
  @path
  modelId: string,
): AnomalyDetectionModel | ResponseError;

@route("/multivariate/models/{modelId}:detect-batch")
@summary("Detect Multivariate Anomaly")
@doc("""
Submit a multivariate anomaly detection task with the modelId value of a trained model
and inference data. The input schema should be the same with the training
request. The request will finish asynchronously and return a resultId value to
query the detection result. The request should be a source link to indicate an
externally accessible Azure Storage URI that either points to an Azure Blob
Storage folder or points to a CSV file in Azure Blob Storage.
""")
// To improve CADL implementation apply: https://github.com/Azure/azure-rest-api-specs/issues/21527
op DetectMultivariateBatchAnomaly(
  @doc("Model identifier.")
  @path
  modelId: string,
  @doc("Request of multivariate anomaly detection.")
  @body options: MultivariateBatchDetectionOptions,
): {
  @statusCode statusCode: 202,
  @doc("ID of the detection result.")
  @header "Operation-Id": string,
  @doc("Location of the detection result.")
  @header "Operation-Location": string,
  @body result: MultivariateDetectionResult,
} | ResponseError;

@route("/multivariate/models/{modelId}:detect-last")
@summary("Detect anomalies in the last point of the request body")
@doc("""
Submit a multivariate anomaly detection task with the modelId value of a trained model
and inference data. The inference data should be put into the request body in
JSON format. The request will finish synchronously and return the detection
immediately in the response body.
""")
// To improve CADL implementation apply: https://github.com/Azure/azure-rest-api-specs/issues/21527
op DetectMultivariateLastAnomaly(
  @doc("Model identifier.")
  @path
  modelId: string,
  @doc("Request of the last detection.")
  @body options: MultivariateLastDetectionOptions,
): MultivariateLastDetectionResult | ResponseError;
