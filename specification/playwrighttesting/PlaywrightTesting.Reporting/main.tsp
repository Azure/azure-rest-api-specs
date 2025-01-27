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
  "{endpoint}",
  "Microsoft Azure Playwright Reporting Service API Endpoint",
  {
    @doc("""
      Supported Azure Playwright Service API Endpoints (protocol and hostname, for example:
        https://{region}.reporting.api.playwright.microsoft.com).
      """)
    endpoint: string,
  }
)
@useAuth(
  [
    OAuth2Auth<[
      {
        type: OAuth2FlowType.implicit,
        description: "We can use OAuth2 Implicit flow to get the auth token for calling the APIs.",
        authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
        scopes: ["https://playwright.microsoft.com/.default"],
      }
    ]>,
    OAuth2Auth<[
      {
        type: OAuth2FlowType.authorizationCode,
        description: "We can use OAuth2 Authorization Code flow to get the auth token for calling the APIs.",
        authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
        tokenUrl: "https://login.microsoftonline.com/common/v2.0/oauth2/token",
        scopes: ["https://playwright.microsoft.com/.default"],
      }
    ]>
  ]
)

@service({
  title: "Microsoft Playwright Service Reporting Data Plane API",
})
@versioned(Microsoft.PlaywrightTesting.Reporting.Versions)
namespace Microsoft.PlaywrightTesting.Reporting;

@doc("The PlaywrightTesting Reporting service Data Plane version.")
enum Versions {
  @doc("Version 2025-02-24")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Microsoft.PlaywrightTesting.Shared.Versions.v1_0)
  `2025-02-24`,
}

// Models ////////////////////
// Enums converted to unions with string variant
@doc("Status of the test run.")
union TestRunStatus {
  string,

  @doc("The test run is currently running.")
  "Running",

  @doc("The test run completed on the client side.")
  "ClientComplete",

  @doc("The test run completed on the server side.")
  "ServerComplete",
}

@doc("Access levels for test results URL.")
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
  "JavaScript",

  @doc("TypeScript")
  "TypeScript",

  @doc("Csharp")
  "CSharp",
}

// Models with unions
@doc("Model representing client configuration.")
model TestRunConfig {
  @doc("Number of retry attempts.")
  @visibility("read", "create")
  retryCount?: int32;

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
  shardDetails?: ShardDetails;

  @doc("Timeout duration for test execution.")
  @visibility("read", "create")
  timeoutInMs: duration;

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

  @doc("MsTest")
  "MsTest",

  @doc("Nunit")
  "Nunit",

  @doc("Playwright")
  "Playwright",
}

@doc("Supported Framework")
union TestFrameworkName {
  string,

  @doc("Playwright")
  "Playwright",
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
  runnerType: RunnerType;
}

@doc("Model representing a shard.")
model ShardDetails {
  @doc("Total number of shards.")
  @maxValue(1000)
  total: int32;
}

@doc("Supported CI provider for tests")
union CiProviderName {
  string,

  @doc("GitHub")
  "GitHub",

  @doc("Azure Devops")
  "Ado",

  @doc("default")
  "Default",
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

  @maxLength(4096)
  @doc("URL linking to the revision details.")
  revisionUrl?: url;
}

@doc("Model representing summary of test run results.")
model CloudReportingSummary {

  @doc("Processing Status of the the uploaded. Allowed values: RUNNING  | CLIENT_COMPLETE | SERVER_COMPLETE")
  resultProcessingstatus: TestRunStatus;

  @doc("Total number of tests executed.")
  @visibility("read")
  numTotalTests: int32;

  @doc("Number of tests that passed.")
  @visibility("read")
  numPassedTests: int32;

  @doc("Number of tests that failed.")
  @visibility("read")
  numFailedTests: int32;

  @doc("Number of tests that were skipped.")
  @visibility("read")
  numSkippedTests: int32;

  @doc("Number of tests that were flaky.")
  @visibility("read")
  numFlakyTests: int32;

  @doc("Status of the test run - PASSED | FAILED | INTERRUPTED | TIMEDOUT")
  @visibility("read")
  status: TestStatus;

  @doc("List of jobs associated with the test run.")
  @visibility("read")
  jobs?: string[];

  @doc("List of projects associated with the test run.")
  @visibility("read")
  projects?: string[];

  @doc("List of tags associated with the test run.")
  @visibility("read")
  tags?: string[];
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

  @doc("Flag indicating if a test-run was throttled because requested browser Quota exceeded")
  browserQuotaExceeded: boolean;
}

@doc("Model to update shard result.")
model UpdateShardExecutionSummary {
  @doc("Start time of the test run in datetime(RFC 3339 literal format).")
  startTime: utcDateTime;

  @doc("End time of the test run.")
  endTime: utcDateTime;

  @doc("Metadata related to test run uploads.")
  uploadMetadata?: UploadMetadata;
}

@doc("Model representing upload metadata.")
model UploadMetadata {
  @doc("Total number of test results uploaded.")
  testResultsCount: int32;

  @doc("Total number of attachments uploaded.")
  totalAttachmentsCount: int32;

  @doc("Total size of attachments uploaded in Bytes.")
  totalAttachmentsSize: int64;
}

@doc("Model representing a test results URL.")
model TestResultsUrl {
  @doc("URL for accessing test results.")
  url: url;

  @doc("Creation timestamp of the test results URL- RFC 3339 literal format")
  createdAt: utcDateTime;

  @doc("Expiration timestamp of the test results URL- RFC 3339 literal format")
  expiresAt: utcDateTime;

  @doc("Access level for the test results URL.")
  accessLevel: AccessLevel;
}

@doc("Model representing detailed information about a test run.")
@resource("test-runs")
@parentResource(Account)
model TestRun {
  @doc("Identifier of the test run.")
  @key
  @visibility("read")
  testRunId: string;

  @doc("Display name of the test run, unicode characters allowed.")
  @maxLength(200)
  displayName?: string;

  @doc("Start time of the test run -RFC 3339 literal format")
  @visibility("read", "create")
  startTime: utcDateTime;

  @doc("Creator's identifier.")
  @visibility("read")
  creatorId: string;

  @doc("Creator's name.")
  @visibility("read")
  creatorName: string;

  @doc("Summary of the Cloud executed run. Only available if cloud run is enabled ")
  @visibility("read")
  cloudRunSummary?: CloudRunSummary;

  @doc("Summary of reports uploaded on cloud.Only available if cloud reporting is enabled")
  @visibility("read")
  cloudReportSummary?: CloudReportingSummary;

  @doc("Continuous integration configuration.")
  @visibility("read", "create")
  ciConfig?: CiConfig;

  @doc("Client configuration for the test run.")
  @visibility("read", "create")
  testRunConfig?: TestRunConfig;

  @doc("URL for accessing test results.")
  @visibility("read")
  testResultsUrl?: TestResultsUrl;

  @doc("Flag indicating if cloud run is enabled.")
  @visibility("read")
  cloudRunEnabled: boolean;

  @doc("Must be set to true when Customers want to use Reporting Feature ")
  @visibility("read", "create")
  cloudReportingEnabled: boolean;
}

@doc("Execution details of a Shard.")
@parentResource(TestRun)
model ShardExecutionDetails {
  @doc("Shard Id for the shard- indexed 0,1,2")
  @key
  @visibility("read", "create")
  shardId: int32;

  @doc("Summary of the test run shard.")
  @visibility("read", "create", "update")
  summary: UpdateShardExecutionSummary;

  @doc("number of workers used by playwright client.")
  @visibility("read", "create")
  workers: int32;

  @doc("Flag indicating if upload is completed for the shard.")
  @visibility("create", "read", "update")
  uploadCompleted?: boolean;
}

// Import necessary libraries and define namespaces as per your typespec file.

@doc("status of a test execution")
union TestStatus {
  string,

  @doc("The test passed successfully.")
  "Passed",

  @doc("The test failed.")
  "Failed",

  @doc("The test was skipped.")
  "Skipped",

  @doc("The test was interrupted.")
  "Interrupted",

  @doc("The test timed out.")
  "TimedOut",
}

// Model representing UploadTestResultsRequest
@doc("Request object for uploading test results.")
@parentResource(TestResultDetails )
model UploadTestResultsRequest {
  @doc("List of test results.")
  @maxItems(100)
  values: TestResultDetails [];
}

// Model representing details of a single test result
@doc("Details of a single test result.")
@resource("test-results")
@parentResource(Account)
model TestResultDetails  {
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
  @visibility("read")
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
  lineNumber: int32;

  @doc("Number of retryCount attempts. max retryCount is 20. After which testresults metadata will not be stored")
  @visibility("read", "create")
  @maxValue(20)
  retryCount: int32;

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
  @visibility("read")
  result: TestResult;

  @doc("Previous retryCount summaries.")
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
  artifactsPath?: string;
}

@doc("Supported browser Types for tests")
union BrowserType {
  string,

  @doc("Chromium")
  "Chromium",

  @doc("Webkit")
  "Webkit",

  @doc("Safari")
  "FireFox",
}

@doc("Supported OS  for tests")
union OsType {
  string,

  @doc("Windows")
  "Windows",

  @doc("Linux")
  "Linux",

  @doc("MAC")
  "Mac",
}

@doc("Attachment kinds uploaded for a test result")
union AttachmentKind {
  string,

  @doc("Image")
  "Image",

  @doc("Video")
  "Video",

  @doc("Trace")
  "Trace"
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
model TestResult {
  @doc("Status of the test results.")
  status: TestStatus;

  @doc("Duration of the test execution in milliseconds.")
  durationInMs: int64;

  @doc("Start time of the test execution.- (RFC 3339 literal format)")
  startTime: utcDateTime;

  @doc("Metadata related to attachments- comma separated IMAGE, VIDEO, TRACE as applicable")
  attachmentsMetadata?: AttachmentKind[];
}

// Model representing summary of previous retryCount
@doc("Summary of previous retries.")
model PreviousRetrySummary {
  @doc("Identifier of the test execution.")
  testExecutionId: string;

  @doc("Number of retryCount attempts.")
  retryCount: int32;

  @doc("Status of the test execution.")
  status: TestStatus;

  @doc("Duration of the test execution.")
  duration: duration;

  @doc("Start time of the test execution- RFC 3339 literal format ")
  startTime: utcDateTime;

  @doc("Metadata related to attachments.")
  attachmentsMetadata: AttachmentKind[];

  @doc("List of artifacts paths.")
  @visibility("read")
  artifactsPath?: string;
}

@doc("Count of a specific status such as PASSED for a run ")
model StatusSummary {
  @doc(" Status of a testrun or test ")
  status: string;

  @doc(" Count  of the specified status")
  count: int32;
}

@doc("Summary statistics of Testrun in an account.")
model AccountTestRunStats {
  /** Passed  runs within an account */
  passed: int32;

  /** Failed  runs within an account */
  failed: int32;

  /** Flaky  runs within an account */
  flaky: int32;

  /** Total  runs within an account */
  all: int32;

  /** Cloud Executed runs within an account */
  cloudExecutionRuns: int32;
}

// Model representing summary statistics of tests
@doc("Summary statistics of testresults in a run.")
model ResultsStats {
  /** Passed test-results within a run */
  passed: int32;

  /** Failed tests within a run */
  failed: int32;

  /** Flaky tests within a run */
  flaky: int32;

  /** Skipped tests within a run */
  skipped: int32;

  /** Total tests within a run */
  all: int32;
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
  createOrUpdate is Operations.ResourceCreateOrUpdate<TestRun>;

  @doc("Gets a testrun.")
  get is Operations.ResourceRead<TestRun>;

  @doc("List testruns.")
  list is Operations.ResourceList<
    TestRun,
    ListQueryParametersTrait<StandardListQueryParameters & FilterQueryParameter>
  >;

  @doc("Get TestResults Upload Url.")
  createArtifactsUploadBaseUrl is Operations.ResourceAction<
    TestRun,
    {},
    TestResultsUrl
  >;

  updateShardExecutionStatus is Operations.ResourceAction<
    TestRun,
    ShardExecutionDetails,
    {}
  >;

  @doc("Get TestRun summary for an Odata filter.")
  @action("accountRunStats")
  computeAccountRunStats is Operations.ResourceCollectionAction<
    TestRun,
    {},
    AccountTestRunStats,
    QueryParametersTrait<StandardListQueryParameters & FilterQueryParameter>
  >;

  @doc("Get TestRun metadata for an Odata filter.")
  @action("metadata")
  computeMetadata is Operations.ResourceCollectionAction<
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
  uploadBatch is Operations.ResourceCollectionAction<
    TestResultDetails ,
    UploadTestResultsRequest,
    {}
  >;

  @doc("List Testresults.")
  list is Operations.ResourceList<
    TestResultDetails ,
    ListQueryParametersTrait<StandardListQueryParameters & FilterQueryParameter>
  >;

  @doc("Get Testresults summary.")
  @action("resultsStats")
  computeResultsStats is Operations.ResourceCollectionAction<
    TestResultDetails ,
    {},
    ResultsStats,
    QueryParametersTrait<StandardListQueryParameters & FilterQueryParameter>
  >;
}
