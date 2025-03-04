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
namespace MdsSolution.CopilotService.TestQueryService;

alias ServiceTraits = SupportsRepeatableRequests &
SupportsConditionalRequests &
SupportsClientRequestId;

alias apiOperations = Azure.Core.ResourceOperations<ServiceTraits>;

/**
 * Represents a request for validation.
 */
model ValidateRequest {
  /**
   * The name of the test.
   */
  testName: string;

  /**
   * The test cases for validation.
   */
  testCases: CopilotTestCase[];

  @doc("run in the conversation context")
  runInConversationContext: boolean = false;
}

/**
 * Represents a response for validation.
 */
model ValidateResponse {
  /**
   * The natural language input.
   */
  naturalLanguage?: string;

  /**
   * The expected query.
   */
  expectedQuery?: string;

  /**
   * The actual query.
   */
  actualQuery?: string;

  /**
   * The consolidated score.
   */
  consolidatedScore: float64;

  /**
   * The actual data.
   */
  actualData?: string;

  /**
   * The expected data.
   */
  expectedData?: string;

  /**
   * The expected entities.
   */
  expectedEntities?: string;

  /**
   * The actual entities.
   */
  actualEntities?: string;

  /**
   * The prompt tokens.
   */
  promptTokens?: string;

  /**
   * The entity extraction prompt tokens.
   */
  entityExtractionPromptTokens?: string;
}


/**
 * Represents the result of a test case.
 */
model TestCaseResult {
  /**
   * The query to be asked.
   */
  ask: string;

  /**
   * The expected KQL query.
   */
  expectedKqlQuery: string;

  /**
   * The consolidated score of the test case.
   */
  consolidatedScore: int64 = 0;

  /**
   * The status of the operation.
   */
  status: OperationStatus = OperationStatus.InProgress;

  /**
   * The error message, if any.
   */
  errorMessage?: string;
}

@doc("Validate Test Response")
model ValidateTestSummary {
  /**
   * The unique identifier of the test.
   */
  testId: string;

  /**
   * The time when the test was created.
   */
  createdTime: string;

  /**
   * The user who created the test.
   */
  createdBy: string;
}

/**
 * Represents a test case for Copilot.
 */
@doc("Test Case for Test run")
model CopilotTestCase {
  @doc("The natural language input for the test case.")
  naturalLanguage?: string;

  @doc("The expected query for the test case.")
  expectedQuery?: string;
  
  @doc("The expected entities for the test case.")
  expectedEntities?: string;
}

@resource("testquery")
@doc("Test Query")
model TestQuery {
    @key
    @doc("The unique identifier of the test query.")
    @visibility("read")  
    testQueryId: string;

    @doc("start date of test run")
    fromDate?: utcDateTime;

    @doc("end date of test run")
    toDate?: utcDateTime;
}

@doc("Test Query Request")
model TestQueryRequest {
    @doc("The name of the test query.")
    testName: string;
    
    @doc("The test cases for the query.")
    testCases: CopilotTestCase[];
    
    @doc("The run in conversation context.")
    runInConversationContext: boolean = false;

    @doc("coversation Id")
    conversationId?: string;
}

@doc("Operation Status")
union OperationStatus {
  /**
   * The operation has been accepted.
   */
  Accepted: "Accepted",

  /**
   * The operation is in progress.
   */
  InProgress: "InProgress",

  /**
   * The operation encountered a transient failure.
   */
  TransientFailure: "TransientFailure",

  /**
   * The operation succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * The operation failed.
   */
  Failed: "Failed",

  /**
   * The operation is being deleted.
   */
  Deleting: "Deleting",

  /**
   * The operation was canceled.
   */
  Canceled: "Canceled",

  /**
   * The status of the operation is unknown.
   */
  Unknown: "Unknown",

  /**
   * The operation was skipped.
   */
  Skipped: "Skipped",

  string
}

@doc("test response")
model TestResponse {
    @doc("Test Run Id")
    testRunId: string;

    @doc("Test Run Status")
    testRunStatus: string;

    @doc("creation date")
    createdDateTime: utcDateTime;

    @doc("created by")
    createdBy: string;
}

@doc("Test Details Response")
model TestDetailsResponse {
    @doc("Test Id")
    testId: string;
  
    @doc("Test Run Status")
    testRunStatus: string;
  
    @doc("Test Results")
    testResults: TestCaseResult[];
  }

interface TestQueryApi { 
    @doc("Validate a query")
    execute is apiOperations.ResourceAction<TestQuery, TestQueryRequest, TestResponse>;
    
    @doc("Get the details of a validate test")
    getValidateTestDetails is apiOperations.ResourceRead<TestQuery, TestDetailsResponse>;
    
    @doc("List validate test requests")
    listValidateTestRequests is apiOperations.ResourceList<TestQuery, ValidateTestSummary>;
}
