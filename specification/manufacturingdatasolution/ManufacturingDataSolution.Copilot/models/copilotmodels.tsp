// import "@typespec/rest";
// import "@typespec/http";
// import "@typespec/openapi3";
// import "@typespec/versioning";

// using TypeSpec.Rest;
// using TypeSpec.Http;
// using TypeSpec.Versioning;
// using OpenAPI;

// namespace MdsSolution.CopilotService.Models;

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

// /**
//  * Represents a query response result.
//  */
// model QueryResponseResult {
//   /**
//    * Resultant Query Query or Query query execution response (JArray string)
//    */
//   result?: string;

//   /**
//    * Summary of the Resultant Query Query or Query query execution response (JArray string)
//    */
//   summary?: string;
// }

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

// /**
//  * Instruction Info Response Model
//  */
// model InstructionInfoResponse {
//   /**
//    * List of Instruction Info objects
//    */
//   instructionInfoList: InstructionInfo[];
// }

// /**
//  * Represents the base model for an instruction.
//  */
// model BaseInstructionModel {
//   /**
//    * The unique identifier of the instruction.
//    */
//   instructionId: string;

//   /**
//    * The version of the instruction.
//    */
//   instructionVersion: string;

//   /**
//    * The status of the instruction.
//    */
//   stauses: InstructionStatusEnum;

//   /**
//    * The domain of the instruction.
//    */
//   domain: InstrustionDomainEnum;

//   /**
//    * The sub-domain of the instruction.
//    */
//   subDomain: InstructionSubDomainEnum;

//   /**
//    * The category of the instruction.
//    */
//   category: InstructionCategoryEnum;

//   /**
//    * The language of the instruction.
//    */
//   language: InstructionLanguageEnum;

//   /**
//    * The retrieval properties of the instruction.
//    */
//   retrieval: RetrievalProperties;

//   /**
//    * The content properties of the instruction.
//    */
//   content: ContentProperties;

//   /**
//    * The relationships of the instruction.
//    */
//   relationships: Relationships;
// }

// /**
//  * Represents the request model for an instruction.
//  */
// @parentResource(BaseInstructionModel)
// model InstructionRequestModel {
//   /** Comment for the instruction */
//   comment: string;
// }

// /**
//  * Represents information about an instruction.
//  */
// model InstructionInfo {
//   /**
//    * The instruction identifier.
//    */
//   instructionId: string;

//   /**
//    * The instruction version.
//    */
//   version: string;

//   /**
//    * The instruction status.
//    */
//   status: InstructionStatusEnum;
// }

// /** Instruction Patch request */
// model InstructionPatchRequest {
//   /**
//    * The instruction status.
//    */
//   status: InstructionStatusEnum;
// }

// /**
//  * Represents a list of instruction request models.
//  */
// model InstructionRequestModelList {
//   /**
//    * The list of instruction request models.
//    */
//   instructionRequestModels: InstructionRequestModel[];
// }

// /**
//  * Represents the response model for an instruction.
//  */
// @parentResource(BaseInstructionModel)
// model InstructionResponseModel {
//   /**
//    * The administrative information of the instruction.
//    */
//   administrative: string;
// }

// /** Attributes used to perform similarity search */
// model RetrievalProperties {
//   /**
//    * The sub-topics related to the instruction.
//    */
//   subTopics: string[];

//   /**
//    * The keywords associated with the instruction.
//    */
//   keywords: string[];

//   /**
//    * The sample questions for the instruction.
//    */
//   sampleQuestions: string[];
// }

// /** The content of the instruction */
// model ContentProperties {
//   /** Content with semantic information */
//   semanticContent: string;
// }

// /** Represents relationships to different instructions */
// model Relationships {
//   /** List of dependent instructions */
//   dependencies: string[];

//   /** List of InstructionIds to be excluded */
//   exclusions: string[];
// }

// /**
//  * Represents a test case for Copilot.
//  */
// model CopilotTestCase {
//   /**
//    * The natural language input for the test case.
//    */
//   naturalLanguage?: string;

//   /**
//    * The expected query for the test case.
//    */
//   expectedQuery?: string;

//   /**
//    * The expected entities for the test case.
//    */
//   expectedEntities?: string;
// }

// /**
//  * Represents the parameters for the query API.
//  */
// model QueryApiParams {
//   /**
//    * The format of the data table.
//    */
//   @query("dataTableFormat")
//   dataTableFormatParam: DataTableFormat;

//   /**
//    * The maximum number of retries.
//    */
//   @query("maxRetry")
//   maxRetryParam: int32 = 1;

//   /**
//    * Indicates whether to include a summary.
//    */
//   @query("includeSummary")
//   includeSummaryParam: boolean = false;
// }

// /**
//  * Represents the parameters for the validate API.
//  */
// model ValidateApiParams {
//   /**
//    * The start date for the validation.
//    */
//   @query("dateFrom")
//   dateFrom: utcDateTime;

//   /**
//    * The end date for the validation.
//    */
//   @query("dateTo")
//   dateTo: utcDateTime;

//   /**
//    * The identifier of the searched test.
//    */
//   @query("searchedTestId")
//   searchedTestId: string;
// }

// /**
//  * Represents the query parameters for the instruction API.
//  */
// model InstructionApiParams {
//   @doc("Flag to get Instruction with Active versions ")
//   @query("showOnlyActive")
//   showOnlyActive: boolean = false;

//   @doc("Instruction version")
//   @query("version")
//   version: string;

//   @doc("Flag to update dependencies while deleting")
//   @query("forceDelete")
//   forceDelete: boolean = false;

//   @doc("Mandatory flag to bulk delete instruction versions")
//   @query("deleteAll")
//   deleteAll: boolean = false;
// }

// /**
//  * Represents the model of a Copilot feedback request.
//  */
// model CopilotFeedbackRequest {
//   /**
//    * The operation identifier.
//    */
//   operationId: string;

//   /**
//    * The conversation identifier.
//    */
//   conversationId: string;

//   /**
//    * The feedback value.
//    */
//   feedback: FeedbackEnum;
// }

// /**
//  * Represents the response model for an operation.
//  */
// model OperationResponseModel {
//   /**
//    * The status of the operation.
//    */
//   operationStatus: OperationStatus;

//   /**
//    * The operation identifier.
//    */
//   operationId: string;

//   /**
//    * The Error message list
//    */
//   errorMessage: string[];
// }

// /**
//  * Represents a sample query.
//  */
// model SampleQuery {
//   /**
//    * The language of the query.
//    */
//   language: string = "KQL";

//   /**
//    * The query string.
//    */
//   query: string;
// }

// /**
//  * Represents an example query.
//  */
// model ExampleQuery {
//   /**
//    * The unique identifier of the example.
//    */
//   exampleId: string;

//   /**
//    * The user question associated with the example.
//    */
//   userQuestion: string;

//   /**
//    * The linked instructions for the example.
//    */
//   linkedInstructions: string[];

//   /**
//    * The sample query associated with the example.
//    */
//   sampleQuery: SampleQuery;
// }

// /**
//  * Represents a patch request for an example query.
//  */
// model ExampleQueryPatchRequest {
//   /**
//    * The linked instructions for the example query.
//    */
//   linkedInstructions?: string[];
// }

// /**
//  * Represents a list of example queries.
//  */
// model ExampleQueryList {
//   /**
//    * The list of example queries.
//    */
//   exampleQueries: ExampleQuery[];
// }

// /**
//  * Represents the response model for an alias.
//  */
// @parentResource(Alias)
// model AliasResponseModel {}

// /**
//  * Represents a list of alias dictionary request models.
//  */
// model AliasDictionaryRequestModelList {
//   /** List of alias dictionary requests */
//   aliasDictionaryRequestList: Alias[];
// }

// /** Defines the Alias patch request */
// model AliasPatchRequest {
//   /** Indicates whether the alias is enabled or not */
//   enabled: boolean;
// }

// /**
//  * Represents feedback types.
//  */
// union FeedbackEnum {
//   /**
//    * Neutral feedback.
//    */
//   Neutral: "Neutral",

//   /**
//    * Positive feedback.
//    */
//   ThumbUp: "ThumbUp",

//   /**
//    * Negative feedback.
//    */
//   ThumbDown: "ThumbDown",

//   /**
//    * Extensible feedback type.
//    */
//   string,
// }

// /**
//  * Represents the status of an operation.
//  */
// /**
//  * Represents the status of an operation.
//  */
// union OperationStatus {
//   /**
//    * The operation has been accepted.
//    */
//   Accepted: "Accepted",

//   /**
//    * The operation is in progress.
//    */
//   InProgress: "InProgress",

//   /**
//    * The operation encountered a transient failure.
//    */
//   TransientFailure: "TransientFailure",

//   /**
//    * The operation succeeded.
//    */
//   Succeeded: "Succeeded",

//   /**
//    * The operation failed.
//    */
//   Failed: "Failed",

//   /**
//    * The operation is being deleted.
//    */
//   Deleting: "Deleting",

//   /**
//    * The operation was canceled.
//    */
//   Canceled: "Canceled",

//   /**
//    * The status of the operation is unknown.
//    */
//   Unknown: "Unknown",

//   /**
//    * The operation was skipped.
//    */
//   Skipped: "Skipped",

//   /**
//    * Extensible status type.
//    */
//   string,
// }

// /**
//  * Represents the format of the data table.
//  */
// union DataTableFormat {
//   /**
//    * Markdown format.
//    */
//   Markdown: "Markdown",

//   /**
//    * JSON format.
//    */
//   Json: "Json",

//   /**
//    * Extensible format type.
//    */
//   string,
// }

// /**
//  * Represents the status of an instruction.
//  */
// union InstructionStatusEnum {
//   /**
//    * The instruction is active.
//    */
//   Active: "Active",

//   /**
//    * The instruction is inactive.
//    */
//   Inactive: "Inactive",

//   /**
//    * Extensible status type.
//    */
//   string,
// }

// /** Instruction Domain Enums */
// union InstrustionDomainEnum {
//   /**
//    * Manufacturing Operations Management
//    */
//   MOM: "MOM",

//   /**
//    * Supply Chain Management
//    */
//   SCM: "SCM",

//   /**
//    * Digital Engineering
//    */
//   DE: "DE",

//   /**
//    * Extensible status type.
//    */
//   string,
// }
