import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/copilotmodels.tsp";
import "./../models/common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Versioning;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService.QueryService;

alias ServiceTraits = SupportsRepeatableRequests &
SupportsConditionalRequests &
SupportsClientRequestId;

alias apiOperations = Azure.Core.ResourceOperations<ServiceTraits>;

// /**
//  * Represents a query request.
//  */
// model QueryRequest {
//   /**
//    * The query to be asked.
//    */
//   ask?: string;

//   /**
//    * The skill identifier.
//    */
//   skillId?: string;

//   /**
//    * The session identifier.
//    */
//   sessionId?: string;
// }


@doc("Query Response Result")
model QueryResponse {

  @doc("Resultant Query Query or Query query execution response (JArray string)")
  result?: string;
  
  @doc("Summary of the Resultant Query Query or Query query execution response (JArray string)")
  summary?: string;
}

// /**
//  * Represents a request for validation.
//  */
// model ValidateRequest {
//   /**
//    * The name of the test.
//    */
//   testName: string;

//   /**
//    * The test cases for validation.
//    */
//   testCases: CopilotTestCase[];
// }

// /**
//  * Represents a response for validation.
//  */
// model ValidateResponse {
//   /**
//    * The natural language input.
//    */
//   naturalLanguage?: string;

//   /**
//    * The expected query.
//    */
//   expectedQuery?: string;

//   /**
//    * The actual query.
//    */
//   actualQuery?: string;

//   /**
//    * The consolidated score.
//    */
//   consolidatedScore: float64;

//   /**
//    * The actual data.
//    */
//   actualData?: string;

//   /**
//    * The expected data.
//    */
//   expectedData?: string;

//   /**
//    * The expected entities.
//    */
//   expectedEntities?: string;

//   /**
//    * The actual entities.
//    */
//   actualEntities?: string;

//   /**
//    * The prompt tokens.
//    */
//   promptTokens?: string;

//   /**
//    * The entity extraction prompt tokens.
//    */
//   entityExtractionPromptTokens?: string;
// }

// /**
//  * Represents the details of a validation test response.
//  */
// model ValidateTestDetailsResponse {
//   /**
//    * The unique identifier of the test.
//    */
//   testId: string;

//   /**
//    * The status of the test run.
//    */
//   testRunStatus: string;

//   /**
//    * The results of the test cases.
//    */
//   testResults: TestCaseResult[];
// }

// /**
//  * Represents the result of a test case.
//  */
// model TestCaseResult {
//   /**
//    * The query to be asked.
//    */
//   ask: string;

//   /**
//    * The expected KQL query.
//    */
//   expectedKqlQuery: string;

//   /**
//    * The consolidated score of the test case.
//    */
//   consolidatedScore: int64 = 0;

//   /**
//    * The status of the operation.
//    */
//   status: OperationStatus = OperationStatus.InProgress;

//   /**
//    * The error message, if any.
//    */
//   errorMessage?: string;
// }

// @doc("Validate Test Response")
// model ValidateTestSummary {
//   /**
//    * The unique identifier of the test.
//    */
//   testId: string;

//   /**
//    * The time when the test was created.
//    */
//   createdTime: string;

//   /**
//    * The user who created the test.
//    */
//   createdBy: string;
// }

@doc("query request")
@resource("query")  
model Query {
  @key
  @visibility("update")
  @doc("language")
  language: string = "en";
}

@doc("query additional properties")
model QueryAdditionalProperties {
  @doc("User query in natural language")
  ask: string;

  @doc("conversation id")
  conversationId: string;

  @doc("include summary")
  includeSummary: boolean;

  @doc("max retry")
  maxRetry: int32 = 2;
}

interface QueryApi { 
    @doc("execute the query")
    execute is apiOperations.ResourceAction<
      Query,
      QueryAdditionalProperties,
      QueryResponse
    >;
}
