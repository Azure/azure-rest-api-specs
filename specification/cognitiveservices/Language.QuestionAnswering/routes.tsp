import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;

namespace Language.QuestionAnswering;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias LanguageOperations = ResourceOperations<ServiceTraits, ErrorResponse>;

interface QuestionAnswering {
  /**
   * Answers the specified question using your knowledge base.
   */
  @route("/:query-knowledgebases")
  @post
  getAnswers is RpcOperation<
    {
      /**
       * The name of the project to use.
       */
      @query("projectName")
      @maxLength(100)
      @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]{0,98}[a-zA-Z0-9]$")
      projectName: string;

      /**
       * The name of the specific deployment of the project to use.
       */
      @query("deploymentName")
      deploymentName: string;

      /**
       * Post body of the request.
       */
      @bodyRoot
      knowledgeBaseQueryOptions: AnswersOptions;
    },
    AnswersResult,
    {},
    ErrorResponse
  >;

  /**
   * Answers the specified question using the provided text in the body.
   */
  @route("/:query-text")
  @post
  getAnswersFromText is RpcOperation<
    {
      /**
       * Post body of the request.
       */
      @bodyRoot
      textQueryOptions: AnswersFromTextOptions;
    },
    AnswersFromTextResult,
    {},
    ErrorResponse
  >;
}
