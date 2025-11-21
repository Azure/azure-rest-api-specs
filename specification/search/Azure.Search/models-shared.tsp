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
  @doc("Selects which top-level properties to retrieve. Specified as a comma-separated list of JSON property names, or '*' for all properties. The default is all properties.")
  @query
  $select?: string;
};

alias indexNamePath = {
  @doc("The name of the index.")
  @path
  indexName: string;
};

alias indexerNamePath = {
  @doc("The name of the indexer.")
  @path
  indexerName: string;
};

alias dataSourceNamePath = {
  @doc("The name of the datasource.")
  @path
  dataSourceName: string;
};

alias skillsetNamePath = {
  @doc("The name of the skillset.")
  @path
  skillsetName: string;
};

alias synonymMapNamePath = {
  @doc("The name of the synonym map.")
  @path
  synonymMapName: string;
};

alias aliasNamePath = {
  @doc("The name of the alias.")
  @path
  aliasName: string;
};

alias sourceNamePath = {
  @doc("The name of the knowledge source.")
  @path
  sourceName: string;
};

alias knowledgeBaseNamePath = {
  @doc("The name of the knowledge base.")
  @path
  knowledgeBaseName: string;
};

alias querySourceAuthorizationHeader = {
  @doc("Token identifying the user for which the query is being executed. This token is used to enforce security restrictions on documents.")
  @header("x-ms-query-source-authorization")
  querySourceAuthorization?: string;
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
  TParams &
    ClientRequestIdHeader &
    indexNamePath &
    querySourceAuthorizationHeader,
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
  code?: string;

  @doc("The error message.")
  message?: string;

  @doc("The error target.")
  target?: string;

  @doc("The error details.")
  details?: ErrorDetail[];

  @doc("The error additional info.")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("The resource management error additional info.")
model ErrorAdditionalInfo {
  @doc("The additional info type.")
  type?: string;

  @doc("The additional info.")
  info?: Record<string>;
}
