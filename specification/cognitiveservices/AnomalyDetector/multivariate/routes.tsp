import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace AnomalyDetector.Multivariate;

// Operation templates

@post
@doc("Operation template for multivariate anomaly detection service action.")
op MultivariateServiceAction<TParams, TResponse>(
  ...TParams,
): TResponse | ResponseError;

// Operations

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern"
// This operation does not fit any standard operation pattern.
// The closest match is probably GetResourceOperationStatus, but that can't be used because
// it does not support an api-version in the path defined in the @server decorator.
// https://github.com/Azure/typespec-azure/issues/2798
@get
@route("/multivariate/detect-batch/{resultId}")
@summary("Get Multivariate Anomaly Detection Result")
@doc("""
For asynchronous inference, get a multivariate anomaly detection result based on the
resultId value that the BatchDetectAnomaly API returns.
""")
op getMultivariateBatchDetectionResult(
  @doc("ID of a batch detection result.")
  @path
  resultId: uuid,
): MultivariateDetectionResult | ResponseError;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure core RpcOperation does not support custom error response"
// https://github.com/Azure/typespec-azure/issues/2795
@route("/multivariate/models")
@summary("Train a Multivariate Anomaly Detection Model")
@doc("""
Create and train a multivariate anomaly detection model. The request must
include a source parameter to indicate an Azure Blob
Storage URI that's accessible to the service. There are two types of data input. The Blob Storage URI can point to an Azure Blob
Storage folder that contains multiple CSV files, where each CSV file has
two columns, time stamp and variable. Or the Blob Storage URI can point to a single blob that contains a CSV file that has all the variables and a
time stamp column.
The model object will be created and returned in the response, but the
training process happens asynchronously. To check the training status, call
GetMultivariateModel with the modelId value and check the status field in the
modelInfo object.
""")
op trainMultivariateModel is MultivariateServiceAction<
  // TParams
  {
    @doc("Model information.")
    @body
    modelInfo: ModelInfo;
  },
  // TResponse
  {
    @statusCode statusCode: 201;

    @doc("Location and ID of the model.")
    @header
    location: string;

    @body result: AnomalyDetectionModel;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern"
// This operation does not fit any standard operation pattern.
// The closest match is probably ResourceList, but that can't be used because
// it does not support an api-version in the path defined in the @server decorator.
// https://github.com/Azure/typespec-azure/issues/2798
// and because the response uses "models" instead of "value" as the array property name.
@get
@route("/multivariate/models")
@summary("List Multivariate Models")
@doc("List models of a resource.")
op listMultivariateModels(
  ...SkipQueryParameter,
  ...TopQueryParameter,
): ModelList | ResponseError;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern"
// This operation does not fit any standard operation pattern.
// The closest match is probably ResourceDelete, but that can't be used because
// it does not support an api-version in the path defined in the @server decorator.
@summary("Delete Multivariate Model")
@doc("Delete an existing multivariate model according to the modelId value.")
@delete
@route("/multivariate/models/{modelId}")
op deleteMultivariateModel(
  @doc("Model identifier.")
  @path
  modelId: string,
): {
  @doc("Delete model successfully.")
  @statusCode
  statusCode: 204;
} | ResponseError;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern"
// This operation does not fit any standard operation pattern.
// The closest match is probably ResourceGet, but that can't be used because
// it does not support an api-version in the path defined in the @server decorator.
@summary("Get Multivariate Model")
@doc("""
Get detailed information about the multivariate model, including the training status
and variables used in the model.
""")
@get
@route("/multivariate/models/{modelId}")
op getMultivariateModel(
  @doc("Model identifier.")
  @path
  modelId: string,
): AnomalyDetectionModel | ResponseError;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern"
// This operation does not fit any standard operation pattern.
// The closest match is probably LongRunningResourceAction, but that can't be used because
// it does not support an api-version in the path defined in the @server decorator.
@post
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
op detectMultivariateBatchAnomaly(
  @doc("Model identifier.")
  @path
  modelId: string,

  @doc("Request of multivariate anomaly detection.")
  @body
  options: MultivariateBatchDetectionOptions,
): {
  @statusCode statusCode: 202;

  @doc("ID of the detection result.")
  @header("Operation-Id")
  operationId: string;

  @doc("Location of the detection result.")
  @header("Operation-Location")
  operationLocation: string;

  @body result: MultivariateDetectionResult;
} | ResponseError;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Does not fit any standard operation pattern"
// This operation does not fit any standard operation pattern.
// The closest match is probably ResourceAction, but that can't be used because
// it does not support an api-version in the path defined in the @server decorator.
@route("/multivariate/models/{modelId}:detect-last")
@summary("Detect anomalies in the last point of the request body")
@doc("""
Submit a multivariate anomaly detection task with the modelId value of a trained model
and inference data. The inference data should be put into the request body in
JSON format. The request will finish synchronously and return the detection
immediately in the response body.
""")
op detectMultivariateLastAnomaly(
  @doc("Model identifier.")
  @path
  modelId: string,

  @doc("Request of the last detection.")
  @body
  options: MultivariateLastDetectionOptions,
): MultivariateLastDetectionResult | ResponseError;
