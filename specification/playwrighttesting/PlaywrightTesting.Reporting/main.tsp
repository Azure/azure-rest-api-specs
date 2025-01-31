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
  "Microsoft Azure Playwright reporting service API endpoint",
  {
    @doc("""
      Supported Azure Playwright Service reporting API Endpoints (protocol and hostname, for example:
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
        description: "We can use the OAuth2 Implicit flow to get the auth token for authenticating the APIs.",
        authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
        scopes: ["https://playwright.microsoft.com/.default"],
      }
    ]>,
    OAuth2Auth<[
      {
        type: OAuth2FlowType.authorizationCode,
        description: "We can use the OAuth2 Authorization Code flow to obtain the authentication token for calling the APIs",
        authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
        tokenUrl: "https://login.microsoftonline.com/common/v2.0/oauth2/token",
        scopes: ["https://playwright.microsoft.com/.default"],
      }
    ]>
  ]
)
@service({
  title: "Microsoft Playwright Testing Service Reporting Data Plane API",
})
@versioned(Microsoft.PlaywrightTesting.Reporting.Versions)
namespace Microsoft.PlaywrightTesting.Reporting;

@doc("The Playwright Testing Reporting service Data Plane version.")
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

  @doc("The test run is currently in progress.")
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

  @doc("Read, create, and write access.")
  "ReadAddCreateWrite",
}

@doc("Supported Test SDK Languages.")
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
  @doc("Number of retries.")
  @visibility("read", "create")
  @maxValue(100)
  retryCount?: int32;

  @doc("The number of times to repeat each test, useful for debugging flaky tests.")
  @visibility("read", "create")
  @maxValue(10000)
  repeatEach?: int32;

  @doc("Number of worker instances (https://playwright.dev/docs/test-parallel#worker-processes).")
  @visibility("read", "create")
  @maxValue(10000000)
  workersCount?: int32;

  @doc("Details of the test framework used.")
  @visibility("read", "create")
  testFramework?: TestFramework;

  @doc("Details of the shards used in the test.")
  @visibility("read", "create")
  shardDetails?: ShardDetails;

  @doc("Playwright test timeout.")
  @visibility("read", "create")
  timeoutInMs: int64;

  // Added Fields
  @doc("Type of test being executed (default: WebTest).")
  @visibility("read", "create")
  @maxLength(200)
  testType?: string = "WebTest";

  @doc("Programming language used for the test SDK.")
  @visibility("read", "create")
  testSdkLanguage: TestSdkLanguage;

  //TODO pattern check
  @doc("Version of the service package.")
  @visibility("read", "create")
  reporterPackageVersion?: string;
}

@doc("Supported runners for test reporting")
union RunnerType {
  string,

  @doc("MsTest runner. Learn more [here].(https://learn.microsoft.com/dotnet/core/testing/unit-testing-mstest-runner-intro)")
  "MsTest",

  @doc("Nunit. Learn more [here](https://nunit.org)")
  "Nunit",

  @doc("Playwright")
  "Playwright",
}

@doc("Supported test frameworks")
union TestFrameworkName {
  string,

  @doc("Playwright")
  "Playwright",
}

@doc("Model representing a test framework.")
model TestFramework {
  //TODO- validate values of framework
  @doc("Name of the test framework.")
  name: TestFrameworkName;

  @doc("Version of the test framework.")
  @maxLength(20)
  //TODO add pattern for playwright version
  version: string;

  @doc("Name of the test runner.")
  runnerType: RunnerType;
}

@doc("Model representing a shard. Learn about Playwright sharding [here](https://playwright.dev/docs/test-sharding)")
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

  @doc("Azure DevOps")
  "Azure DevOps",

  @doc("default")
  "Default",
}

@doc("Model representing continuous integration (CI) configuration. ")
model CiConfig {
  @doc("Name of the CI provider.")
  @maxLength(200)
  ciProviderName?: CiProviderName;

  @maxLength(500)
  @doc("Branch name in the source code repository.")
  branch?: string;

  @maxLength(500)
  @doc("Author of the last commit.")
  author?: string;

  @maxLength(500)
  @doc("ID of the last commit.")
  commitId?: string;

  @maxLength(4096)
  @doc("URL linking to the revision details in source code repository.")
  revisionUrl?: url;
}

@doc("Model representing summary of test run results.")
model CloudReportingSummary {
  @doc("Start time of the test run in datetime(RFC 3339 literal format).")
  startTime: utcDateTime;

  @doc("End time of the test run.")
  endTime: utcDateTime;

  @doc("Run status of the test results on the service.")
  serverStatus: TestRunStatus;

  @doc("Total number of tests executed")
  @visibility("read")
  totalTestsCount?: int32;

  @doc("Number of passed tests in the test run.")
  @visibility("read")
  passedTestsCount?: int32;

  @doc("Number of failed tests in the test run.")
  @visibility("read")
  failedTestsCount?: int32;

  @doc("Number of skipped tests in the test run.")
  @visibility("read")
  skippedTestsCount?: int32;

  @doc("Number of flaky tests in the test run (tests that passed on retry).")
  @visibility("read")
  flakyTestsCount?: int32;

  @doc("Status of the test run")
  @visibility("read")
  status: TestStatus;

  @doc("List of CI jobs associated with the test run.")
  @visibility("read")
  jobs?: string[];

  @doc("List of Playwright [projects](https://playwright.dev/docs/test-projects) associated with the test run.")
  @visibility("read")
  projects?: string[];

  @doc("List of tags associated with tests in the test run.")
  @visibility("read")
  tags?: string[];
}

@doc("Model representing summary information about a test run.")
model CloudRunSummary {
  @doc("Status of the test run.")
  serverStatus: TestRunStatus;

  @doc("Billed time for the test run, available once the test run has ended")
  billableTimeInMs?: int32;

  @doc("Total time taken for the test run.")
  totalTimeInMs?: int32;

  @doc("Number of browser sessions used in the test run.")
  browserSessionsCount?: int32;

  @doc("Flag indicating whether the test run was throttled due to reaching the maximum allowed parallel browser limit for the workspace.")
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
  @doc("Total number of test results uploaded in the test run.")
  testResultsCount: int32;

  @doc("Total number of attachments uploaded in the test run.")
  @maxValue(1000000)
  totalAttachmentsCount: int32;

  @doc("Total size of attachments uploaded in the test run (bytes).")
  @maxValue(100000000000)
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
  @maxLength(200)
  testRunId: string;

  @doc("Display name of the test run in the portal (unicode characters allowed).")
  @maxLength(200)
  @minLength(3)
  @visibility("read", "create")
  displayName: string;

  @doc("Creation time of the test run -RFC 3339 literal format")
  @visibility("read", "create")
  creationTime: utcDateTime;

  @doc("Creator's identifier. It's the Id referred in the access/Entra token")
  @visibility("read")
  creatorId: string;

  @doc("Test run created by.")
  @visibility("read")
  creatorName: string;

  @doc("Summary of the cloud-hosted browser run. Only available if cloud run is enabled ")
  @visibility("read")
  cloudRunSummary?: CloudRunSummary;

  @doc("Summary of reports uploaded on cloud. Only available if cloud reporting is enabled")
  @visibility("read")
  cloudReportSummary?: CloudReportingSummary;

  @doc("Continuous integration (CI) configuration.")
  @visibility("read", "create")
  ciConfig?: CiConfig;

  @doc("Playwright client configuration for the test run.")
  @visibility("read", "create")
  testRunConfig?: TestRunConfig;

  @doc("URL for accessing test results.")
  @visibility("read")
  testResultsUrl?: TestResultsUrl;

  @doc("Flag indicating if test run is using cloud-hosted browsers (cloud run).")
  @visibility("read")
  cloudRunEnabled: boolean;

  @doc("Must be set to true when users want to use reporting feature ")
  @visibility("read", "create")
  cloudReportingEnabled: boolean;
}

@doc("Execution details of a Playwright shard within the test run.")
model ShardExecutionDetails {
  @doc("Shard Id for the shard- indexed 1,2,3 etc.")
  @visibility("read", "create")
  shardId: int32;

  @doc("Summary of the test run shard.")
  @visibility("read", "create")
  summary: UpdateShardExecutionSummary;

  @doc("Number of workers used by playwright client.")
  @visibility("read", "create")
  @maxValue(10000000)
  workersCount: int32;

  @doc("Flag indicating if upload is complete for the shard.")
  @visibility("create", "read")
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

  @doc("The test was flaky (passed in retry).")
  "Flaky",

  @doc("The test was interrupted.")
  "Interrupted",

  @doc("The test timed out.")
  "TimedOut",
}

// Model representing UploadTestResultsRequest
@doc("Request object for uploading test results.")
@parentResource(TestResultDetails)
model UploadTestResultsRequest {
  @doc("List of test results.")
  @maxItems(100)
  values: TestResultDetails[];
}

// Model representing details of a single test result
@doc("Details of a single test result.")
@resource("test-results")
@parentResource(Account)
model TestResultDetails {
  @doc("Identifier for the test execution.")
  @key
  @visibility("read", "create")
  @maxLength(200)
  testExecutionId: string;

  @doc("Identifier for the test.")
  @visibility("read", "create")
  @maxLength(200)
  testId: string;

  @doc("Identifier for the test combination. A test combination represents a specific test within a project.")
  @visibility("read", "create")
  @maxLength(200)
  testCombinationId: string;

  @doc("Identifier of the test run.")
  @visibility("read")
  @maxLength(200)
  runId: string;

  @doc("Identifier of the shard.")
  @visibility("read", "create")
  @maxValue(1000)
  shardId: int32;

  @doc("Identifier of the workspace.")
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

  @doc("Title of the test suite.")
  @visibility("read", "create")
  @maxLength(500)
  suiteTitle: string;

  @doc("Name of the file.")
  @visibility("read", "create")
  @maxLength(300)
  fileName: string;

  @doc("Line number for the test in the file.")
  @visibility("read", "create")
  lineNumber: int32;

  @doc("Number of retries for the test.")
  @visibility("read", "create")
  @maxValue(100)
  retryCount: int32;

  @doc("Status of the individual test execution. The status cannot be 'flaky' for upload")
  @visibility("read", "create")
  status: TestStatus;

  @doc("Configuration for the web test.")
  @visibility("read", "create")
  webTestConfig?: WebTestConfig;

  @doc("Continuous integration (CI) configuration.")
  @visibility("read")
  ciConfig?: CiConfig;

  @doc("Duration of the test execution in milliseconds.")
  durationInMs: int64;

  @doc("Start time of the test execution.- (RFC 3339 literal format)")
  startTime: utcDateTime;

  @doc("Metadata related to attachments")
  attachmentsMetadata?: AttachmentKind[];

  @doc("Previous retry summaries: Retires are uploaded separately but grouped on the service, accessible as a single entity via the GET API.")
  @visibility("read")
  previousRetries?: PreviousRetrySummary[];

  @doc("List of tags associated with the test result.")
  @visibility("read", "create")
  @maxItems(100)
  tags?: string[];

  @doc("List of annotations (https://playwright.dev/docs/test-annotations) for the test result.")
  @visibility("read", "create")
  @maxItems(100)
  annotations?: string[];

  @doc("Relative path in storage for all the artifacts of the test")
  @visibility("read", "create")
  artifactsPath?: string;
}

@doc("Supported browser types for running tests")
union BrowserType {
  string,

  @doc("Chromium")
  "Chromium",

  @doc("Webkit")
  "Webkit",

  @doc("Firefox")
  "Firefox",
}

@doc("Supported operating systems for tests")
union OsType {
  string,

  @doc("Windows")
  "Windows",

  @doc("Linux")
  "Linux",

  @doc("Macintosh")
  "Mac",
}

@doc("Types of attachments uploaded for a test result")
union AttachmentKind {
  string,

  @doc("Screenshot")
  "Image",

  @doc("Video")
  "Video",

  @doc("Trace")
  "Trace",
}

// Model representing web test configuration
@doc("Configuration details for the web test.")
model WebTestConfig {
  @doc("Name of the CI job running the test.")
  @maxLength(500)
  jobName: string;

  @doc("Name of the Playwright project to which the test is associated.")
  @maxLength(500)
  projectName: string;

  @doc("Name of the browser running the test.")
  browserType: BrowserType;

  @doc("Operating system where the browser is hosted.")
  os: OsType;
}

// Model representing summary of previous retryCount
@doc("Summary of previous retries.")
model PreviousRetrySummary {
  @doc("Identifier of the test execution.")
  testExecutionId: string;

  @doc("Number of retries.")
  @maxValue(100)
  retryCount: int32;

  @doc("Status of the test execution.")
  status: TestStatus;

  @doc("Duration of the test execution.")
  durationInMs: duration;

  @doc("Start time of the test execution- RFC 3339 literal format ")
  startTime: utcDateTime;

  @doc("Metadata related to attachments.")
  attachmentsMetadata: AttachmentKind[];

  @doc("Relative path of test artifacts in storage.")
  @visibility("read")
  artifactsPath?: string;
}

@doc("Summary statistics of test run in a workspace.")
model AccountTestRunStats {
  /** Passed  runs within a workspace */
  passed: int32;

  /** Failed  runs within a workspace */
  failed: int32;

  /** Flaky  runs within a workspace */
  flaky: int32;

  /** Total  runs within a workspace */
  all: int32;

  /** Cloud Executed runs within a workspace */
  cloudExecutionRuns: int32;
}

// Model representing summary statistics of tests
@doc("Summary statistics of test results in a run.")
model ResultsStats {
  /** Passed tests within a run */
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

  @doc("Create or update a testrun.")
  createOrUpdate is Operations.ResourceCreateOrUpdate<TestRun>;

  @doc("Get a test run.")
  get is Operations.ResourceRead<TestRun>;

  @doc("List test runs.")
  list is Operations.ResourceList<
    TestRun,
    ListQueryParametersTrait<StandardListQueryParameters & FilterQueryParameter>
  >;

  @doc("Get Test results upload url to publish test results.")
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

  @doc("Get test run summary for an Odata filter.")
  @action("accountRunStats")
  computeAccountRunStats is Operations.ResourceCollectionAction<
    TestRun,
    {},
    AccountTestRunStats,
    QueryParametersTrait<StandardListQueryParameters & FilterQueryParameter>
  >;

  @doc("Get test run metadata for an Odata filter.")
  @action("metadata")
  computeMetadata is Operations.ResourceCollectionAction<
    TestRun,
    {},
    TestRunsMetadata,
    QueryParametersTrait<StandardListQueryParameters & FilterQueryParameter>
  >;
}

alias TestRunIdQueryParameter = QueryParametersTrait<{
  /** Mandatory runId for the test results. */
  @query
  testRunId: string;
}>;

@tag("test-result")
interface TestResults {
  // TestResults Operations

  @doc("Upload test results.")
  uploadBatch is Operations.ResourceCollectionAction<
    TestResultDetails,
    UploadTestResultsRequest,
    {},
    TestRunIdQueryParameter
  >;

  @doc("List test results.")
  list is Operations.ResourceList<
    TestResultDetails,
    ListQueryParametersTrait<StandardListQueryParameters & FilterQueryParameter>
  >;

  @doc("Get test results summary.")
  @action("resultsStats")
  computeResultsStats is Operations.ResourceCollectionAction<
    TestResultDetails,
    {},
    ResultsStats,
    QueryParametersTrait<StandardListQueryParameters & FilterQueryParameter>
  >;
}
