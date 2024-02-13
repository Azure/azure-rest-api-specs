import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace AnomalyDetector.Univariate;

@post
@doc("Operation template for univariate anomaly detection service action.")
op UnivariateServiceAction<TParams, TResponse>(
  ...TParams,
): TResponse | AnomalyDetectorError;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure core RpcOperation does not support custom error response"
// https://github.com/Azure/typespec-azure/issues/2795
@route("timeseries/entire/detect")
@summary("Detect anomalies for the entire series in batch.")
@doc("""
This operation generates a model with an entire series. Each point is detected
with the same model. With this method, points before and after a certain point
are used to determine whether it's an anomaly. The entire detection can give the
user an overall status of the time series.
""")
op detectUnivariateEntireSeries is UnivariateServiceAction<
  // TParams
  {
    @doc("Method of univariate anomaly detection.")
    @body
    options: UnivariateDetectionOptions;
  },
  // TResponse
  UnivariateEntireDetectionResult
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure core RpcOperation does not support custom error response"
// https://github.com/Azure/typespec-azure/issues/2795
@route("timeseries/last/detect")
@summary("Detect anomaly status of the latest point in time series.")
@doc("""
This operation generates a model by using the points that you sent in to the API
and based on all data to determine whether the last point is anomalous.
""")
op detectUnivariateLastPoint is UnivariateServiceAction<
  // TParams
  {
    @doc("Method of univariate anomaly detection.")
    @body
    options: UnivariateDetectionOptions;
  },
  // TResponse
  UnivariateLastDetectionResult
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Azure core RpcOperation does not support custom error response"
// https://github.com/Azure/typespec-azure/issues/2795
@route("timeseries/changepoint/detect")
@summary("Detect change point for the entire series")
@doc("Evaluate the change point score of every series point.")
op detectUnivariateChangePoint is UnivariateServiceAction<
  // TParams
  {
    @doc("Method of univariate anomaly detection.")
    @body
    options: UnivariateChangePointDetectionOptions;
  },
  // TResponse
  UnivariateChangePointDetectionResult
>;
