import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using Azure.Core;
using Azure.ClientGenerator.Core;

namespace Search;

alias matchingHeader = {
  @doc("Defines the If-Match condition. The operation will be performed only if the ETag on the server matches this value.")
  @header("If-Match")
  ifMatch?: string;

  @doc("Defines the If-None-Match condition. The operation will be performed only if the ETag on the server does not match this value.")
  @header("If-None-Match")
  ifNoneMatch?: string;
};

alias preferHeader = {
  @doc("For HTTP PUT requests, instructs the service to return the created/updated resource on success.")
  @header("Prefer")
  prefer: "return=representation";
};

alias selectQuery = {
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Pre-existing API contract"
  @doc("Selects which top-level properties to retrieve. Specified as a comma-separated list of JSON property names, or '*' for all properties. The default is all properties.")
  @query
  @encode(ArrayEncoding.commaDelimited)
  $select?: string;
};

alias indexNamePath = {
  @doc("The name of the index.")
  @clientName("name")
  @path
  indexName: string;
};

alias indexerNamePath = {
  @doc("The name of the indexer.")
  @clientName("name")
  @path
  indexerName: string;
};

alias dataSourceNamePath = {
  @doc("The name of the datasource.")
  @clientName("name")
  @path
  dataSourceName: string;
};

alias skillsetNamePath = {
  @doc("The name of the skillset.")
  @clientName("name")
  @path
  skillsetName: string;
};

alias synonymMapNamePath = {
  @doc("The name of the synonym map.")
  @clientName("name")
  @path
  synonymMapName: string;
};

alias aliasNamePath = {
  @doc("The name of the alias.")
  @clientName("name")
  @path
  aliasName: string;
};

alias sourceNamePath = {
  @doc("The name of the knowledge source.")
  @clientName("name")
  @path
  sourceName: string;
};

alias knowledgeBaseNamePath = {
  @doc("The name of the knowledge base.")
  @clientName("name")
  @path
  knowledgeBaseName: string;
};

alias querySourceAuthorizationHeader = {
  @doc("Token identifying the user for which the query is being executed. This token is used to enforce security restrictions on documents.")
  @header("x-ms-query-source-authorization")
  querySourceAuthorization?: string;
};

alias enableElevatedReadHeader = {
  @doc("A value that enables elevated read that bypass document level permission checks for the query operation.")
  @header("x-ms-enable-elevated-read")
  enableElevatedRead?: boolean;
};

@doc("Client initialization options for SearchIndexClient.")
model SearchIndexClientOptions {
  @doc("The name of the index.")
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

@doc("Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).")
@error
model ErrorResponse {
  @doc("The error object.")
  error?: ErrorDetail;
}

@doc("The error detail.")
model ErrorDetail {
  @doc("The error code.")
  @visibility(Lifecycle.Read)
  code?: string;

  @doc("The error message.")
  @visibility(Lifecycle.Read)
  message?: string;

  @doc("The error target.")
  @visibility(Lifecycle.Read)
  target?: string;

  @doc("The error details.")
  @visibility(Lifecycle.Read)
  details?: ErrorDetail[];

  @doc("The error additional info.")
  @visibility(Lifecycle.Read)
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("The resource management error additional info.")
model ErrorAdditionalInfo {
  @doc("The additional info type.")
  @visibility(Lifecycle.Read)
  type?: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "model should have additionalProperties"
  @doc("The additional info.")
  @visibility(Lifecycle.Read)
  info?: Record<unknown>;
}
