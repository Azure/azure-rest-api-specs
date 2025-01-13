// cheat-sheet - https://microsoft.github.io/typespec/standard-library/http/cheat-sheet
// tsp compile main.tsp --emit @azure-tools/typespec-autorest

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";
import "../PlaywrightTesting.Shared";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Autorest;
using Microsoft.PlaywrightTesting.Shared;

@server(
  "https://eastus.api.playwright.microsoft.com",
  "Azure Playwright Service API Endpoint"
)
@useAuth(
  [
    OAuth2Auth<[
      {
        type: OAuth2FlowType.implicit,
        authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
        scopes: ["https://preview.playwright-int.io/.default"],
      }
    ]>
  ]
)
@service({
  title: "Microsoft Playwright Service Reporting Data Plane API",
})
@versioned(Microsoft.PlaywrightTesting.DataPlane.Versions)
namespace Microsoft.PlaywrightTesting.DataPlane;

@doc("The PlaywrightTesting Data Plane service version.")
enum Versions {
  @doc("Version 2025-01-02-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Microsoft.PlaywrightTesting.Shared.Versions.v1_0)
  `2025-01-02-preview`,
}

// Models ////////////////////
// Enums converted to unions with string variant
@doc("Status of the test run.")
union TestRunStatus {
  string,

  @doc("The test run is currently running.")
  "RUNNING",

  @doc("The test run completed on the client side.")
  "CLIENT_COMPLETE",

  @doc("The test run completed on the server side.")
  "SERVER_COMPLETE",
}

@doc("Access levels for test results URI.")
union AccessLevel {
  string,

  @doc("Read access.")
  "Read",

  @doc("Write access.")
  "Write",

  @doc("Read and write access.")
  "ReadWrite",

  @doc("Read, add, create, and write access.")
  "ReadAddCreateWrite",
}

@doc("Supported Test SDK Language.")
union TestSdkLanguage {
  string,

  @doc("JavaScript.")
  "JAVASCRIPT",

  @doc("TypeScript")
  "TYPESCRIPT",

  @doc("Csharp")
  "CSHARP",
}

// Models with unions
@doc("Model representing client configuration.")
model TestRunConfig {
  @doc("Number of retry attempts.")
  @visibility("read", "create")
  retries?: int32;

  @doc("Interval between repeated test runs.")
  @visibility("read", "create")
  repeatEach?: int32;

  @doc("Number of worker instances.")
  @visibility("read", "create")
  workers?: int32;

  @doc("Details of the test framework used.")
  @visibility("read", "create")
  testFramework?: TestFramework;

  @doc("Details of the shards used in the test.")
  @visibility("read", "create")
  shards?: Shard;

  @doc("Timeout duration for test execution.")
  @visibility("read", "create")
  timeout: int32;

  // Added Fields
  @doc("Type of test being executed (default: WebTest).")
  @visibility("read", "create")
  @maxLength(200)
  testType?: string = "WebTest";

  @doc("Programming language used for the test SDK. Supported languages are 'JavaScript', 'TypeScript', 'Csharp'")
  @visibility("read", "create")
  testSdkLanguage: TestSdkLanguage;

  //TODO pattern check
  @doc("Version of the reporter package.")
  @visibility("read", "create")
  reporterPackageVersion?: string;
}

@doc("Supported Runner Types for tests")
union RunnerType {
  string,

  @doc("MSTEST")
  "MSTEST",

  @doc("NUNIT")
  "NUNIT",

  @doc("PLAYRIGHT")
  "PLAYRIGHT",
}

@doc("Supported Framework")
union TestFrameworkName {
  string,

  @doc("PLAYRIGHT")
  "PLAYRIGHT",
}

@doc("Model representing a test framework.")
model TestFramework {
  //TODO- validate values of framework
  @doc("Name of the test framework. Supported Frameworks are Playwright")
  @maxLength(200)
  name: TestFrameworkName;

  @doc("Version of the test framework.")
  //TODO add pattern for playwright version
  version: string;

  @doc("Name of the test runner.Supported Frameworks are MSTEST, Playwright, NUNIT")
  runnerName: RunnerType;
}

@doc("Model representing a shard.")
model Shard {
  @doc("Total number of shards.")
  @maxValue(1000)
  total: int32;
}

@doc("Supported CI provider for tests")
union CiProviderName {
  string,

  @doc("GitHub")
  "GITHUB",

  @doc("Ado")
  "ADO",

  @doc("default")
  "DEFAULT",
}

@doc("Model representing continuous integration (CI) configuration. ")
model CiConfig {
  @doc("Name of the CI provider.  GitHub | ADO")
  @maxLength(200)
  ciProviderName?: CiProviderName;

  @maxLength(500)
  @doc("Branch name in the source code repository.")
  branch?: string;

  @maxLength(500)
  @doc("Author of the commit triggering the test run.")
  author?: string;

  @maxLength(500)
  @doc("ID of the commit triggering the test run.")
  commitId?: string;

  @maxLength(1000)
  @doc("URL linking to the revision details.")
  revisionUrl?: string;
}

@doc("Model representing summary of test run results.")
model ReportingSummary {
  @doc("Total number of tests executed.")
  numTotalTests: int32;

  @doc("Number of tests that passed.")
  numPassedTests: int32;

  @doc("Number of tests that failed.")
  numFailedTests: int32;

  @doc("Number of tests that were skipped.")
  numSkippedTests: int32;

  @doc("Number of tests that were flaky.")
  numFlakyTests: int32;

  @doc("Status of the test run - PASSED | FAILED | INTERRUPTED | TIMEDOUT")
  status: TestStatus;
}

@doc("Model representing summary information about a test run.")
model CloudRunSummary {
  @doc("Status of the test run. Allowed values: RUNNING  | CLIENT_COMPLETE | SERVER_COMPLETE")
  status: TestRunStatus;

  @doc("Start time of the test run in datetime(RFC 3339 literal format).")
  startTime: utcDateTime;

  @doc("End time of the test run.")
  endTime: utcDateTime;

  @doc("Billable time for the test run. Available after testRun Ends")
  billableTime: int32;

  @doc("Total time taken for the test run.")
  totalTime: int32;

  @doc("Number of browser sessions used in the test run.")
  numBrowserSessions: int32;

  @doc("List of jobs associated with the test run.")
  jobs: string[];

  @doc("List of projects associated with the test run.")
  projects: string[];

  @doc("List of tags associated with the test run.")
  tags: string[];

  @doc("List of errorMessages encountered by  reporter client. Beyond the limit errorMessages will be truncated")
  @maxItems(1000)
  errorMessages?: string[];

  @doc("Metadata related to test run uploads.")
  uploadMetadata?: UploadMetadata;
}

@doc("Model to update shard result.")
model UpdateShardExecutionSummary {
  @doc("Start time of the test run in datetime(RFC 3339 literal format).")
  startTime: utcDateTime;

  @doc("End time of the test run.")
  endTime: utcDateTime;

  @doc("List of errorMessages encountered by  reporter client. Beyond the limit errorMessages will be truncated")
  @maxItems(1000)
  errorMessages?: string[];

  @doc("Metadata related to test run uploads.")
  uploadMetadata?: UploadMetadata;
}

@doc("Model representing upload metadata.")
model UploadMetadata {
  @doc("Total number of test results uploaded.")
  numTestResults: int32;

  @doc("Total number of attachments uploaded.")
  numTotalAttachments: int32;

  @doc("Total size of attachments uploaded in Bytes.")
  sizeTotalAttachments: int64;
}

@doc("Model representing a test results URI.")
model TestResultsUri {
  @doc("URI for accessing test results.")
  uri: string;

  @doc("Creation timestamp of the test results URI- RFC 3339 literal format")
  createdAt: string;

  @doc("Expiration timestamp of the test results URI- RFC 3339 literal format")
  expiresAt: string;

  @doc("Access level for the test results URI.")
  accessLevel: AccessLevel;
}

@doc("Model representing detailed information about a test run.")
@resource("test-runs")
@parentResource(Account)
model TestRun {
  @doc("Identifier of the test run.")
  @key
  @visibility("read", "create")
  testRunId: string;

  @doc("Display name of the test run, unicode characters allowed.")
  @maxLength(200)
  displayName?: string;

  @doc("Start time of the test run -RFC 3339 literal format")
  @visibility("read", "create")
  startTime: utcDateTime;

  @doc("Creator's identifier.")
  creatorId: string;

  @doc("Creator's name.")
  creatorName: string;

  @doc("Summary of the test run.")
  summary: CloudRunSummary;

  @doc("Summary of test run results.")
  resultsSummary: ReportingSummary;

  @doc("Continuous integration configuration.")
  @visibility("read", "create")
  ciConfig?: CiConfig;

  @doc("Client configuration for the test run.")
  @visibility("read", "create")
  testRunConfig: TestRunConfig;

  @doc("URI for accessing test results.")
  testResultsUri: TestResultsUri;

  @doc("Flag indicating if cloud run is enabled.")
  isCloudRunEnabled: boolean;

  @doc("Must be set to true when Customers want to use Reporting Feature ")
  @visibility("read", "create")
  isCloudReportingEnabled: boolean;
}

@doc("DTO representing a Test Run Shard.")
@resource("shards")
@parentResource(TestRun)
model TestRunShardDto {
  @doc("Shard Id for the shard")
  @key
  @visibility("read", "create")
  shardId: string;

  @doc("Summary of the test run shard.")
  @visibility("read", "create", "update")
  summary: UpdateShardExecutionSummary;

  @doc("number of workers used by playwright client.")
  @visibility("read", "create")
  workers: int32;

  @doc("Flag indicating if upload is completed for the shard.")
  @visibility("create", "read", "update")
  isUploadCompleted?: boolean;
}

// Import necessary libraries and define namespaces as per your typespec file.

@doc("status of a test execution")
union TestStatus {
  string,

  @doc("The test passed successfully.")
  "PASSED",

  @doc("The test failed.")
  "FAILED",

  @doc("The test was skipped.")
  "SKIPPED",

  @doc("The test was interrupted.")
  "INTERRUPTED",

  @doc("The test timed out.")
  "TIMEDOUT",
}

// Model representing UploadTestResultsRequest
@doc("Request object for uploading test results.")
@parentResource(TestResult)
model UploadTestResultsRequest {
  @doc("List of test results.")
  @maxItems(100)
  value: TestResult[];
}

// Model representing details of a single test result
@doc("Details of a single test result.")
@resource("test-results")
@parentResource(Account)
model TestResult {
  @doc("Identifier of the test execution.")
  @key
  @visibility("read", "create")
  @maxLength(200)
  testExecutionId: string;

  @doc("Identifier of the test.")
  @visibility("read", "create")
  @maxLength(200)
  testId: string;

  @doc("Identifier of the test combination.")
  @visibility("read", "create")
  @maxLength(200)
  testCombinationId: string;

  @doc("Identifier of the test run.")
  @visibility("read", "create")
  @maxLength(200)
  runId: string;

  @doc("Identifier of the shard.")
  @visibility("read", "create")
  @maxLength(200)
  shardId: string;

  @doc("Identifier of the account.")
  @visibility("read", "create")
  @maxLength(200)
  accountId: string;

  @doc("Identifier of the suite.")
  @visibility("read", "create")
  @maxLength(200)
  suiteId: string;

  @doc("Title of the test.")
  @visibility("read", "create")
  @maxLength(500)
  testTitle: string;

  @doc("Title of the suite.")
  @visibility("read", "create")
  @maxLength(500)
  suiteTitle: string;

  @doc("Name of the file.")
  @visibility("read", "create")
  @maxLength(300)
  fileName: string;

  @doc("Line number.")
  @visibility("read", "create")
  lineNumber: uint32;

  @doc("Number of retry attempts. max retry is 20. After which testresults metadata will not be stored")
  @visibility("read", "create")
  retry: uint32;

  @doc("Status of the test.")
  @visibility("read", "create")
  status: TestStatus;

  @doc("Configuration for the web test.")
  @visibility("read", "create")
  webTestConfig?: WebTestConfig;

  @doc("Continuous integration configuration.")
  @visibility("read", "create")
  ciConfig?: CiConfig;

  @doc("Summary of test results.")
  @visibility("read", "create")
  resultsSummary: TestResultsSummary;

  @doc("Previous retry summaries.")
  previousRetries?: PreviousRetrySummary[];

  @doc("List of tags associated with the test result.")
  @visibility("read", "create")
  @maxItems(100)
  tags?: string[];

  @doc("List of annotations.")
  @visibility("read", "create")
  @maxItems(100)
  annotations?: string[];

  @doc("Relative path in Storage for all the artifacts of this test")
  @visibility("read", "create")
  artifactsPath: string;
}

@doc("Supported browser Types for tests")
union BrowserType {
  string,

  @doc("Chromium")
  "CHROMIUM",

  @doc("Webkit")
  "WEBKIT",

  @doc("Safari")
  "FIREFOX",
}

@doc("Supported OS  for tests")
union OsType {
  string,

  @doc("Windows")
  "WINDOWS",

  @doc("Linux")
  "LINUX",

  @doc("MAC")
  "MAC",
}

// Model representing web test configuration
@doc("Configuration details for the web test.")
model WebTestConfig {
  @doc("Name of the job.")
  @maxLength(500)
  jobName: string;

  @doc("Name of the project.")
  @maxLength(500)
  projectName: string;

  @doc("Name of the browser.")
  browserType: BrowserType;

  @doc("Operating system details.")
  os: OsType;
}

// Model representing test results summary
@doc("Summary of test results.")
model TestResultsSummary {
  @doc("Status of the test results.")
  status: TestStatus;

  @doc("Duration of the test execution in milliseconds.")
  duration: int64;

  @doc("Start time of the test execution.- (RFC 3339 literal format)")
  startTime: utcDateTime;

  @doc("Metadata related to attachments- comma separated IMAGE, VIDEO, TRACE as applicable")
  attachmentsMetadata?: string;
}

// Model representing summary of previous retries
@doc("Summary of previous retries.")
model PreviousRetrySummary {
  @doc("Identifier of the test execution.")
  testExecutionId: string;

  @doc("Number of retry attempts.")
  retry: uint32;

  @doc("Status of the test execution.")
  status: string;

  @doc("Duration of the test execution.")
  duration: int64;

  @doc("Start time of the test execution- RFC 3339 literal format ")
  startTime: utcDateTime;

  @doc("Metadata related to attachments.")
  attachmentsMetadata: string;

  @doc("List of artifacts paths.")
  artifactsPath?: string[];
}

@doc("Count of a specific status such as PASSED for a run ")
model StatusSummary {
  @doc(" Status of a testrun or test ")
  status: string;

  @doc(" Count  of the specified status")
  count: int32;
}

// Model representing summary statistics of tests
@doc("Summary statistics of tests.")
model StatusSummaryList {
  @doc("Model to represent status of testrun/test")
  statusSummary: StatusSummary[];
}

// Model representing summary statistics of tests
@doc("Metadata for  testruns/builds.")
model TestRunsMetadata {
  @doc("List of CI branches for a testrun")
  branches: string[];
}

// Operations and interfaces for API endpoints remain unchanged

// Operations ////////////////////

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

@tag("test-run")
interface TestRuns {
  // TestRuns Operations

  @doc("Creates or updates a testrun.")
  createOrUpdateTestRun is Operations.ResourceCreateOrUpdate<TestRun>;

  @doc("Gets a testrun.")
  getTestRuns is Operations.ResourceRead<TestRun>;

  @doc("List testruns.")
  listTestRuns is Operations.ResourceList<
    TestRun,
    ListQueryParametersTrait<StandardListQueryParameters & FilterQueryParameter>
  >;

  @doc("Get TestResults Upload Uri.")
  createArtifactsUploadBaseUri is Operations.ResourceAction<
    TestRun,
    {},
    TestResultsUri
  >;

  updateShardExecutionStatus is Operations.ResourceAction<
    TestRun,
    TestRunShardDto,
    {}
  >;

  @doc("Get TestRun summary for an Odata filter.")
  @action("summary")
  @actionSeparator("/")
  getTestRunSummary is Operations.ResourceCollectionAction<
    TestRun,
    {},
    StatusSummaryList,
    QueryParametersTrait<StandardListQueryParameters & FilterQueryParameter>
  >;

  @doc("Get TestRun metadata for an Odata filter.")
  @action("metadata")
  @actionSeparator("/")
  getTestRunMetadata is Operations.ResourceCollectionAction<
    TestRun,
    {},
    TestRunsMetadata,
    QueryParametersTrait<StandardListQueryParameters & FilterQueryParameter>
  >;
}

@tag("test-result")
interface TestResults {
  // TestResults Operations

  @doc("Upload Test Results.")
  //@example(
  //   "./TestResults_Create.json",
  //   "TestResults_Create"
  // )
  uploadBatch is Operations.ResourceCollectionAction<
    TestResult,
    UploadTestResultsRequest,
    {}
  >;

  @doc("List Testresults.")
  listTestResults is Operations.ResourceList<
    TestResult,
    ListQueryParametersTrait<StandardListQueryParameters & FilterQueryParameter>
  >;

  @doc("Get Testresults summary.")
  @action("summary")
  @actionSeparator("/")
  getTestResultsSummary is Operations.ResourceCollectionAction<
    TestResult,
    {},
    StatusSummaryList,
    QueryParametersTrait<StandardListQueryParameters & FilterQueryParameter>
  >;
}
