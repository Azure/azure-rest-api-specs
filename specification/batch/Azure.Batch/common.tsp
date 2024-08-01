import "@typespec/versioning";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

namespace Azure.Batch;

// Batch operation definitions
#suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior"
@get
op ListOperation<TFilter, TResponse> is Azure.Core.RpcOperation<
  BatchCommonListHeaders & TFilter,
  BatchResponseHeaders & TResponse,
  NoFilter,
  BatchError
>;

#suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior"
@get
op ReadOperation<
  TPathParams extends TypeSpec.Reflection.Model,
  TResource
> is Azure.Core.RpcOperation<
  BatchClientRequestHeaders & TPathParams,
  TResource & BatchResponseHeaders,
  NoFilter,
  BatchError
>;

#suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior"
@get
op FileOperation<
  TPathParams extends TypeSpec.Reflection.Model,
  TResource
> is Azure.Core.RpcOperation<
  BatchClientRequestHeaders & TPathParams,
  TResource & FileResponseHeaders,
  NoFilter,
  BatchError
>;

#suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior"
@head
op HeadFileOperation<
  TPathParams extends TypeSpec.Reflection.Model,
  TResource
> is Azure.Core.RpcOperation<
  BatchClientRequestHeaders & TPathParams,
  TResource & FileResponseHeaders,
  NoFilter,
  BatchError
>;

#suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior"
@delete
op DeleteOperation<
  TFilter,
  TResponse extends TypeSpec.Reflection.Model
> is Azure.Core.RpcOperation<
  BatchClientRequestHeaders & TFilter,
  TResponse,
  NoFilter,
  BatchError
>;

#suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior"
@post
op CreateOperation<TResource, TResponse> is RpcOperation<
  BatchClientRequestHeaders & MinimalMetadata & TResource,
  Created<TResponse> & BatchResponseHeaders,
  NoFilter,
  BatchError
>;

#suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior"
@patch
op UpdateOperation<TResource, TResponse> is RpcOperation<
  BatchClientRequestHeaders & MinimalMetadata & TResource,
  TResponse & BatchResponseHeaders,
  NoFilter,
  BatchError
>;

#suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior"
@put
op ReplaceOperation<TResource, TResponse> is RpcOperation<
  BatchClientRequestHeaders & MinimalMetadata & TResource,
  TResponse & BatchResponseHeaders,
  NoFilter,
  BatchError
>;

#suppress "@azure-tools/typespec-azure-core/no-error-status-codes" "Azure REST API guidelines recommend using 'default' error response for all error cases. Avoid defining custom 4xx or 5xx error cases."
#suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior"
@doc("New rpc operation allowing multiple responses")
@Foundations.Private.needsRoute
@head
op ResourceInfoOperationWithAdditionalResponse<
  TParams extends TypeSpec.Reflection.Model,
  TResponse extends TypeSpec.Reflection.Model,
  TAdditionalResponse extends {} = {}
> is Foundations.Operation<
  TParams,
  TResponse | TAdditionalResponse,
  NoFilter,
  BatchError
>;

#suppress "@azure-tools/typespec-azure-core/no-response-body" "Legacy behavior"
@post
op PostOperation<TResource, TResponse> is RpcOperation<
  BatchClientRequestHeaders & TResource,
  TResponse & BatchResponseHeaders,
  NoFilter,
  BatchError
>;

// Templates
alias NoFilter = {};
alias MinimalMetadata = {
  @doc("Type of content")
  @header("content-type")
  contentType: "application/json; odata=minimalmetadata";
};

alias Created<T> = {
  @doc("A process exit code.")
  @statusCode
  code: "201";

  @header("DataServiceId")
  @doc("The OData ID of the resource to which the request applied.")
  dataServiceId: string;

  ...T;
};

// headers ////////////////////

alias AcceptedProcessingResponseHeaders = {
  @doc("A process exit code.")
  @statusCode
  code: "202";

  ...DataServiceResponseHeaders;
};

alias NoContentSuccessResponseHeaders = {
  @doc("A process exit code.")
  @statusCode
  code: "204";

  ...DataServiceResponseHeaders;
};

alias RequestSuccessResponseHeaders = {
  @doc("A process exit code.")
  @statusCode
  code: "200";

  ...DataServiceResponseHeaders;
};

alias DataServiceResponseHeaders = {
  @header("DataServiceId")
  @doc("The OData ID of the resource to which the request applied.")
  dataServiceId: string;
};

alias FileResponseHeaders = {
  @doc("A process exit code.")
  @statusCode
  code: "200";

  @header("Content-Length")
  @doc("The length of the file.")
  contentLength: string;

  ...BatchEtagResponseHeaders;

  @doc("The client-request-id provided by the client during the request. This will be returned only if the return-client-request-id parameter was set to true.")
  @header("client-request-id")
  clientRequestId?: string;

  @header("ocp-batch-file-isdirectory")
  @doc("Whether the object represents a directory.")
  ocpbatchfileisdirectory: boolean;

  @header("ocp-batch-file-mode")
  @doc("The file mode attribute in octal format.")
  ocpbatchfilemode: string;

  @header("ocp-batch-file-url")
  @doc("The URL of the file.")
  ocpbatchfileurl: string;

  @header("ocp-creation-time")
  @doc("The file creation time.")
  @encode(DateTimeKnownEncoding.rfc7231)
  ocpcreationtime?: utcDateTime;

  @doc("A unique identifier for the request that was made to the Batch service. If a request is consistently failing and you have verified that the request is properly formulated, you may use this value to report the error to Microsoft. In your report, include the value of this request ID, the approximate time that the request was made, the Batch Account against which the request was made, and the region that Account resides in.")
  @header("request-id")
  requestid?: string;
};

alias BatchPoolHeaders = {
  ...BatchMatchHeaders;

  @doc("The ID of the Pool to get.")
  @path
  poolId: string;
};

alias BatchMatchHeaders = {
  ...BatchModifiedSinceHeaders;

  @doc("""
    An ETag value associated with the version of the resource known to the client.
    The operation will be performed only if the resource's current ETag on the
    service exactly matches the value specified by the client.
    """)
  @header("If-Match")
  @clientName("if__match", "python")
  ifMatch?: string;

  @doc("""
    An ETag value associated with the version of the resource known to the client.
    The operation will be performed only if the resource's current ETag on the
    service does not match the value specified by the client.
    """)
  @header("If-None-Match")
  @clientName("if_none_match", "python")
  ifNoneMatch?: string;
};

alias BatchModifiedSinceHeaders = {
  @doc("""
    A timestamp indicating the last modified time of the resource known to the
    client. The operation will be performed only if the resource on the service has
    been modified since the specified time.
    """)
  @header("If-Modified-Since")
  @encode(DateTimeKnownEncoding.rfc7231)
  @clientName("if_modified_since", "python")
  ifModifiedSince?: utcDateTime;

  @doc("""
    A timestamp indicating the last modified time of the resource known to the
    client. The operation will be performed only if the resource on the service has
    not been modified since the specified time.
    """)
  @header("If-Unmodified-Since")
  @encode(DateTimeKnownEncoding.rfc7231)
  @clientName("if_unmodified_since", "python")
  ifUnmodifiedSince?: utcDateTime;
};

// This is the standard set of headers that most of batch apis return
alias BatchResponseHeaders = BatchEtagResponseHeaders &
  BatchClientResponseHeaders;

alias BatchEtagResponseHeaders = {
  @doc("The ETag HTTP response header. This is an opaque string. You can use it to detect whether the resource has changed between requests. In particular, you can pass the ETag to one of the If-Modified-Since, If-Unmodified-Since, If-Match or If-None-Match headers.")
  @header("ETag")
  @clientName("etag", "python")
  etag?: string;

  @doc("The time at which the resource was last modified.")
  @header("Last-Modified")
  @encode(DateTimeKnownEncoding.rfc7231)
  lastmodified?: utcDateTime;
};

alias BatchClientResponseHeaders = {
  @doc("The client-request-id provided by the client during the request. This will be returned only if the return-client-request-id parameter was set to true.")
  @header("client-request-id")
  clientRequestId?: string;

  @doc("A unique identifier for the request that was made to the Batch service. If a request is consistently failing and you have verified that the request is properly formulated, you may use this value to report the error to Microsoft. In your report, include the value of this request ID, the approximate time that the request was made, the Batch Account against which the request was made, and the region that Account resides in.")
  @header("request-id")
  requestid?: string;
};

alias PoolDoesExistResponseHeaders = {
  ...BatchResponseHeaders;

  @doc("A process exit code.")
  @statusCode
  code: "200";
};

alias PoolDoesNotExistResponseHeaders = {
  @doc("A process exit code.")
  @statusCode
  code: "404";
};

alias JobScheduleDoesExistResponseHeaders = {
  ...BatchResponseHeaders;

  @doc("A response containing headers related to the Job Schedule, if it exists.")
  @statusCode
  code: "200";
};

alias JobScheduleDoesNotExistResponseHeaders = {
  @doc("The Job Schedule does not exist.")
  @statusCode
  code: "404";
};

alias DeleteResponseHeaders = {
  @doc("A process exit code.")
  @statusCode
  code: "202";

  @doc("The client-request-id provided by the client during the request. This will be returned only if the return-client-request-id parameter was set to true.")
  @header("client-request-id")
  clientRequestId?: string;

  @doc("A unique identifier for the request that was made to the Batch service. If a request is consistently failing and you have verified that the request is properly formulated, you may use this value to report the error to Microsoft. In your report, include the value of this request ID, the approximate time that the request was made, the Batch Account against which the request was made, and the region that Account resides in.")
  @header("request-id")
  requestid?: string;
};

alias BatchCommonListHeaders = {
  ...BatchClientRequestHeaders;

  @doc("""
    The maximum number of items to return in the response. A maximum of 1000
    applications can be returned.
    """)
  @query
  @minValue(1)
  @maxValue(1000)
  @clientName("maxPageSize", "java")
  @clientName("max_results", "python")
  maxresults?: int32 = 1000;
};

alias BatchNodeFileClientPathContent = {
  @doc("The ID of the Pool that contains the Compute Node.")
  @path
  poolId: string;

  @doc("The ID of the Compute Node.")
  @path
  nodeId: string;

  @doc("The path to the file or directory.")
  @path
  filePath: string;
};

alias BatchTaskFileClientPathContent = {
  @doc("The ID of the Job that contains the Task.")
  @path
  jobId: string;

  @doc("The ID of the Task whose file you want to retrieve.")
  @path
  taskId: string;

  @doc("The path to the Task file that you want to get the content of.")
  @path
  filePath: string;
};

alias BatchClientRequestHeaders = {
  @doc("""
    The maximum time that the server can spend processing the request, in seconds. The default is 30 seconds. If the value is larger than 30, the default will be used instead.".
    """)
  @query
  @clientName("timeOutInSeconds", "java")
  @clientName("timeOutInSeconds", "csharp")
  @clientName("timeOutInSeconds", "javascript")
  @clientName("timeout", "python")
  timeOut?: int32 = 30;

  @doc("""
    The caller-generated request identity, in the form of a GUID with no decoration
    such as curly braces, e.g. 9C4D50EE-2D56-4CD3-8152-34347DC9F2B0.
    """)
  @header("client-request-id")
  clientRequestId?: string;

  @doc("Whether the server should return the client-request-id in the response.")
  @header("return-client-request-id")
  returnClientRequestId?: boolean = false;

  @doc("""
    The time the request was issued. Client libraries typically set this to the
    current system clock time; set it explicitly if you are calling the REST API
    directly.
    """)
  @header("ocp-date")
  @encode(DateTimeKnownEncoding.rfc7231)
  ocpdate?: utcDateTime;
};
