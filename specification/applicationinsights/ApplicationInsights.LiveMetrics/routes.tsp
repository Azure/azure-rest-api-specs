import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace LiveMetrics;

op QuickPulseOperation<
  TParams extends TypeSpec.Reflection.Model,
  TResponse extends TypeSpec.Reflection.Model
> is Foundations.Operation<TParams, TResponse, {}, ServiceError>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
@doc("Client SDK calls QuickPulse /ping API.")
@route("/QuickPulseService.svc/ping")
@post
op ping is QuickPulseOperation<PingRequest, {...PingResponseHeaders, ...CollectionConfigurationInfo}>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
@doc("Client SDK calls QuickPulse /post API.")
@route("/QuickPulseService.svc/post")
@post
op post is QuickPulseOperation<PostRequest, {...PostResponseHeaders, ...CollectionConfigurationInfo}>;