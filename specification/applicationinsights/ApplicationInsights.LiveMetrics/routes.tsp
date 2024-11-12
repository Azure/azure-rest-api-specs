import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.Monitor.LiveMetrics;

op LiveMetricsOperation<
  TParams extends TypeSpec.Reflection.Model,
  TResponse extends TypeSpec.Reflection.Model
> is Foundations.Operation<TParams, TResponse, {}, ServiceError>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
@doc("Determine whether there is any subscription to the metrics and documents.")
@route("/QuickPulseService.svc/ping")
@post
op isSubscribed is LiveMetricsOperation<
  IsSubscribedOperationRequestParameters,
  {
    ...IsSubscribedOperationResponseHeaders;
    ...CollectionConfigurationInfo;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
@doc("Publish live metrics to the Live Metrics service when there is an active subscription to the metrics.")
@route("/QuickPulseService.svc/post")
@post
op publish is LiveMetricsOperation<
  PublishOperationRequestParameters,
  {
    ...PublishOperationResponseHeaders;
    ...CollectionConfigurationInfo;
  }
>;
