import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using Azure.Core;
using Azure.ClientGenerator.Core;

namespace Search;

alias matchingHeader = {
  /** Defines the If-Match condition. The operation will be performed only if the ETag on the server matches this value. */
  @header("If-Match")
  ifMatch?: string;

  /** Defines the If-None-Match condition. The operation will be performed only if the ETag on the server does not match this value. */
  @header("If-None-Match")
  ifNoneMatch?: string;
};

alias preferHeader = {
  /** For HTTP PUT requests, instructs the service to return the created/updated resource on success. */
  @header("Prefer")
  prefer: "return=representation";
};

alias acceptHeaderMinimal = {
  /** The Accept header. */
  @header("Accept")
  accept: "application/json;odata.metadata=minimal";
};

alias acceptHeaderNone = {
  /** The Accept header. */
  @header("Accept")
  accept: "application/json;odata.metadata=none";
};

alias selectQuery = {
  /** Selects which top-level properties to retrieve. Specified as a comma-separated list of JSON property names, or '*' for all properties. The default is all properties. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Pre-existing API contract"
  @query
  $select?: string[];
};

alias indexNamePath = {
  /** The name of the index. */
  @clientName("name")
  @path
  indexName: string;
};

alias indexerNamePath = {
  /** The name of the indexer. */
  @clientName("name")
  @path
  indexerName: string;
};

alias dataSourceNamePath = {
  /** The name of the datasource. */
  @clientName("name")
  @path
  dataSourceName: string;
};

alias skillsetNamePath = {
  /** The name of the skillset. */
  @clientName("name")
  @path
  skillsetName: string;
};

alias synonymMapNamePath = {
  /** The name of the synonym map. */
  @clientName("name")
  @path
  synonymMapName: string;
};

alias aliasNamePath = {
  /** The name of the alias. */
  @clientName("name")
  @path
  aliasName: string;
};

alias sourceNamePath = {
  /** The name of the knowledge source. */
  @clientName("name")
  @path
  sourceName: string;
};

alias knowledgeBaseNamePath = {
  /** The name of the knowledge base. */
  @clientName("name")
  @path
  knowledgeBaseName: string;
};

alias querySourceAuthorizationHeader = {
  /** Token identifying the user for which the query is being executed. This token is used to enforce security restrictions on documents. */
  @header("x-ms-query-source-authorization")
  querySourceAuthorization?: string;
};

alias enableElevatedReadHeader = {
  /** A value that enables elevated read that bypass document level permission checks for the query operation. */
  @header("x-ms-enable-elevated-read")
  enableElevatedRead?: boolean;
};

/** Client initialization options for SearchIndexClient. */
model SearchIndexClientOptions {
  /** The name of the index. */
  @paramAlias("indexName")
  indexName: string;
}

alias SearchOperation<
  TParams extends Reflection.Model,
  TResponse,
  Traits extends Reflection.Model = {},
  TError extends Reflection.Model = ErrorResponse
> = Foundations.Operation<
  TParams & ClientRequestIdHeader,
  TResponse,
  Traits,
  TError
>;

alias SearchIndexOperation<
  TParams extends Reflection.Model,
  TResponse,
  Traits extends Reflection.Model = {},
  TError extends Reflection.Model = ErrorResponse
> = Foundations.Operation<
  TParams & ClientRequestIdHeader & indexNamePath,
  TResponse,
  Traits,
  TError
>;

alias SearchIndexerOperation<
  TParams extends Reflection.Model,
  TResponse,
  Traits extends Reflection.Model = {},
  TError extends Reflection.Model = ErrorResponse
> = Foundations.Operation<
  TParams & ClientRequestIdHeader & indexerNamePath,
  TResponse,
  Traits,
  TError
>;

alias SearchDataSourceOperation<
  TParams extends Reflection.Model,
  TResponse,
  Traits extends Reflection.Model = {},
  TError extends Reflection.Model = ErrorResponse
> = Foundations.Operation<
  TParams & ClientRequestIdHeader & dataSourceNamePath,
  TResponse,
  Traits,
  TError
>;

alias SearchSkillsetOperation<
  TParams extends Reflection.Model,
  TResponse,
  Traits extends Reflection.Model = {},
  TError extends Reflection.Model = ErrorResponse
> = Foundations.Operation<
  TParams & ClientRequestIdHeader & skillsetNamePath,
  TResponse,
  Traits,
  TError
>;

alias SearchSynonymMapOperation<
  TParams extends Reflection.Model,
  TResponse,
  Traits extends Reflection.Model = {},
  TError extends Reflection.Model = ErrorResponse
> = Foundations.Operation<
  TParams & ClientRequestIdHeader & synonymMapNamePath,
  TResponse,
  Traits,
  TError
>;

alias SearchAliasOperation<
  TParams extends Reflection.Model,
  TResponse,
  Traits extends Reflection.Model = {},
  TError extends Reflection.Model = ErrorResponse
> = Foundations.Operation<
  TParams & ClientRequestIdHeader & aliasNamePath,
  TResponse,
  Traits,
  TError
>;

alias SearchSourceOperation<
  TParams extends Reflection.Model,
  TResponse,
  Traits extends Reflection.Model = {},
  TError extends Reflection.Model = ErrorResponse
> = Foundations.Operation<
  TParams & ClientRequestIdHeader & sourceNamePath,
  TResponse,
  Traits,
  TError
>;

alias SearchKnowledgeBaseOperation<
  TParams extends Reflection.Model,
  TResponse,
  Traits extends Reflection.Model = {},
  TError extends Reflection.Model = ErrorResponse
> = Foundations.Operation<
  TParams & ClientRequestIdHeader & knowledgeBaseNamePath,
  TResponse,
  Traits,
  TError
>;

/** Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.). */
@error
model ErrorResponse {
  /** The error object. */
  error?: ErrorDetail;
}

/** The error detail. */
model ErrorDetail {
  /** The error code. */
  @visibility(Lifecycle.Read)
  code?: string;

  /** The error message. */
  @visibility(Lifecycle.Read)
  message?: string;

  /** The error target. */
  @visibility(Lifecycle.Read)
  target?: string;

  /** The error details. */
  @visibility(Lifecycle.Read)
  details?: ErrorDetail[];

  /** The error additional info. */
  @visibility(Lifecycle.Read)
  additionalInfo?: ErrorAdditionalInfo[];
}

/** The resource management error additional info. */
model ErrorAdditionalInfo {
  /** The additional info type. */
  @visibility(Lifecycle.Read)
  type?: string;

  /** The additional info. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
  @visibility(Lifecycle.Read)
  info?: Record<unknown>;
}
