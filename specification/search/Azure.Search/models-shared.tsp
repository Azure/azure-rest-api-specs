import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace SearchClient;


alias preferHeader = {
  @doc("For HTTP PUT requests, instructs the service to return the created/updated resource on success.")
  @header("Prefer")
  prefer: "return=representation";
};

alias selectQuery = {
  @doc("""
       Selects which top-level properties to retrieve.
       Specified as a comma-separated list of JSON property names,
       or '*' for all properties. The default is all properties.
       """)  
  @query("$select")
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

alias SearchConditionalOperation<
  TParams extends Reflection.Model,
  TResponse,
  Traits extends Reflection.Model = {},
  TError extends Reflection.Model = ErrorResponse
> = Foundations.Operation<
  TParams & ClientRequestIdHeader & ConditionalRequestHeaders,
  TResponse,
  Traits,
  TError
>;

/**
 * Common error response for all Azure Resource Manager APIs to return error
 * details for failed operations. (This also follows the OData error response
 * format.).
 */
@error
model ErrorResponse {
  /**
   * The error object.
   */
  error?: ErrorDetail;
}

/**
 * The error detail.
 */
model ErrorDetail {
  /**
   * The error code.
   */
  @visibility("read")
  code?: string;

  /**
   * The error message.
   */
  @visibility("read")
  message?: string;

  /**
   * The error target.
   */
  @visibility("read")
  target?: string;

  /**
   * The error details.
   */
  @visibility("read")
  details?: ErrorDetail[];

  /**
   * The error additional info.
   */
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

/**
 * The resource management error additional info.
 */
model ErrorAdditionalInfo {
  /**
   * The additional info type.
   */
  @visibility("read")
  type?: string;

  /**
   * The additional info.
   */
  @visibility("read")
  info?: Record<string>;
}
