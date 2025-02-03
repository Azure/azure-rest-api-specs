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
  @maxValue(100)
  retryCount?: int32;

  @doc("Interval between repeated test runs.")
  @visibility("read", "create")
  @maxValue(10000)
  repeatEach?: int32;

  @doc("Details of the test framework used.")
  @visibility("read", "create")
  testFramework?: TestFramework;

  @doc("Details of the shards used in the test.")
  @visibility("read", "create")
  shardDetails?: ShardDetails;

  @doc("Timeout duration for test execution.")
  @visibility("read", "create")
  timeoutInMs: int64;

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
  servicePackageVersion?: string;
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
  name: TestFrameworkName;

  @doc("Version of the test framework.")
  @maxLength(20)
  //TODO add pattern for playwright version
  version: string;

  @doc("Name of the test runner.Supported Frameworks are MSTEST, Playwright, NUNIT")
  runnerType: RunnerType;
}

@doc("Model representing a shard. Learn about Playwright sharding here: https://playwright.dev/docs/test-sharding")
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
  @doc("Name of the CI provider.  GitHub | Azure DevOps | Default")
  ciProviderName?: CiProviderName;

  @maxLength(255)
  @doc("Branch name in the source code repository. All unicode characters except spaces, ASCII control characters, special Git characters (^, ~, :, ?, *, [, ]), double dots (..), multiple consecutive slashes (//), or start/end with a slash (/) or start with period (.).")
  branch?: string;

  @maxLength(255)
  @doc("Author of the commit triggering the test run. All unicode characters except ASCII control characters, special Git characters (^, ~, :, ?, *, [, ]), double dots (..), multiple consecutive slashes (//), or start/end with a slash (/) or start with period (.).")
  author?: string;

  @maxLength(40)
  @doc("ID of the commit triggering the test run. This is the SHA-1 hash")
  commitId?: string;

  @maxLength(4096)
  @doc("URL linking to the revision details. Should be a valid Url. Allowed characters- alphanumeric characters (A-Z, a-z, 0-9), hyphens (-), underscores (_), periods (.), tildes (~), and forward slashes (/) for hierarchy. Special characters must be URL-encoded.")
  revisionUrl?: url;
}

@doc("Model representing summary of test run results.")
model CloudReportingSummary {
  @doc("Start time of the test run in datetime(RFC 3339 literal format).")
  startTime: utcDateTime;

  @doc("End time of the test run.")
  endTime: utcDateTime;

  @doc("Processing Status of the testresults on the Server Side.")
  serverStatus: TestRunStatus;

  @doc("Total number of tests executed")
  @visibility("read")
  totalTestsCount?: int32;

  @doc("Number of tests that passed.")
  @visibility("read")
  passedTestsCount?: int32;

  @doc("Number of tests that failed.")
  @visibility("read")
  failedTestsCount?: int32;

  @doc("Number of tests that were skipped.")
  @visibility("read")
  skippedTestsCount?: int32;

  @doc("Number of tests that were flaky (passed on retry).")
  @visibility("read")
  flakyTestsCount?: int32;

  @doc("Status of the test run")
  @visibility("read")
  status: TestStatus;

  @doc("List of CI jobs associated with the test run.")
  @visibility("read")
  jobs?: string[];

  @doc("List of Playwright projects (https://playwright.dev/docs/test-projects) associated with the test run.")
  @visibility("read")
  projects?: string[];

  @doc("List of tags associated with the test run.")
  @visibility("read")
  tags?: string[];

  @doc("Number of worker instances.")
  @visibility("read", "create")
  @maxValue(1000)
  workersCount?: int32;
}

@doc("Model representing summary information about a test run.")
model CloudRunSummary {
  @doc("Status of the test run. Allowed values: RUNNING  | CLIENT_COMPLETE | SERVER_COMPLETE")
  serverStatus: TestRunStatus;

  @doc("Billable time for the test run. Available after testRun Ends")
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
  @doc("Total number of test results uploaded.")
  testResultsCount: int32;

  @doc("Total number of attachments uploaded.")
  @maxValue(1000000)
  totalAttachmentsCount: int32;

  @doc("Total size of attachments uploaded in Bytes.")
  @maxValue(1024000000)
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
  @doc("Identifier of the test run. All unicode characters except spaces, ASCII control characters, special Git characters (^, ~, :, ?, *, [, ]), double dots (..), multiple consecutive slashes (//), or start/end with a slash (/) or start with period (.)")
  @key
  @visibility("read")
  @maxLength(200)
  testRunId: string;

  @doc("Display name of the test run All unicode characters except ASCII control characters, special Git characters (^, ~, :, ?, *, [, ]), double dots (..), multiple consecutive slashes (//), or start/end with a slash (/) or start with period (.).")
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

  @doc("Creator's name.")
  @visibility("read")
  creatorName: string;

  @doc("Summary of the Cloud executed run. Only available if cloud run is enabled ")
  @visibility("read")
  cloudRunSummary?: CloudRunSummary;

  @doc("Summary of reports uploaded on cloud. Only available if cloud reporting is enabled")
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

  @doc("Must be set to true when users want to use Reporting Feature ")
  @visibility("read", "create")
  cloudReportingEnabled: boolean;
}

@doc("Execution details of a Shard.")
model ShardExecutionDetails {
  @doc("Shard Id for the shard- indexed 1,2,3 etc.")
  @visibility("read", "create")
  shardId: int32;

  @doc("Summary of the test run shard.")
  @visibility("read", "create")
  summary: UpdateShardExecutionSummary;

  @doc("number of workers used by playwright client.")
  @visibility("read", "create")
  @maxValue(1000)
  workersCount: int32;

  @doc("Flag indicating if upload is completed for the shard.")
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

  @doc("The test was flaky.")
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
  @doc("Identifier of the test execution. Should be a guid")
  @key
  @visibility("read", "create")
  @maxLength(200)
  testExecutionId: string;

  @doc("Identifier of the test. This is SHA-1 hash")
  @visibility("read", "create")
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  @maxLength(200)
  testId: string;

  @doc("Identifier of the test combination.This is SHA-1 hash")
  @visibility("read", "create")
  @maxLength(200)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  testCombinationId: string;

  @doc("Identifier of the test run.")
  @visibility("read")
  @maxLength(200)
  runId: string;

  @doc("Identifier of the shard.")
  @visibility("read", "create")
  @maxValue(1000)
  shardId: int32;

  @doc("Identifier of the account.")
  @visibility("read")
  @maxLength(200)
  accountId: string;

  @doc("Identifier of the suite. This is SHA-1 hash")
  @visibility("read", "create")
  @maxLength(200)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  suiteId: string;

  @doc("Title of the test. All unicode characters except ASCII control characters, special Git characters (^, ~, :, ?, *, [, ]), double dots (..), multiple consecutive slashes (//), or start/end with a slash (/) or start with period (.).")
  @visibility("read", "create")
  @maxLength(1000)
  testTitle: string;

  @doc("Title of the suite. All unicode characters except ASCII control characters, special Git characters (^, ~, :, ?, *, [, ]), double dots (..), multiple consecutive slashes (//), or start/end with a slash (/) or start with period (.).")
  @visibility("read", "create")
  @maxLength(500)
  suiteTitle: string;

  @doc("Name of the file- subject to constraints of OS and programming language")
  @visibility("read", "create")
  @maxLength(255)
  fileName: string;

  @doc("Line number.")
  @visibility("read", "create")
  lineNumber: int32;

  @doc("Number of retryCount attempts. Max retryCount is 100, after which testresults metadata will not be stored")
  @visibility("read", "create")
  @maxValue(100)
  retryCount: int32;

  @doc("Status of the test result. While uploading results, a single test execution status can't be Flaky")
  @visibility("read", "create")
  status: TestStatus;

  @doc("Configuration for the web test.")
  @visibility("read", "create")
  webTestConfig?: WebTestConfig;

  @doc("Continuous integration configuration.")
  @visibility("read")
  ciConfig?: CiConfig;

  @doc("Duration of the test execution in milliseconds.")
  durationInMs: int64;

  @doc("Start time of the test execution.- (RFC 3339 literal format)")
  startTime: utcDateTime;

  @doc("Metadata related to attachments- comma separated IMAGE, VIDEO, TRACE as applicable")
  attachmentsMetadata?: AttachmentKind[];

  @doc("Previous retry summaries. While uploading results, each retry is uploaded separately.However, all the retries of a test gets grouped on the server side and can be retrieved as a single entity using GET API.")
  @visibility("read")
  previousRetries?: PreviousRetrySummary[];

  @doc("List of tags associated with the test result. All unicode characters except ASCII control characters, special  characters (^, ~, :, ?, *, [, ]), double dots (..), multiple consecutive slashes (//), or start/end with a slash (/) or start with period (.).")
  @visibility("read", "create")
  @maxItems(100)
  tags?: string[];

  @doc("List of annotations (https://playwright.dev/docs/test-annotations).All unicode characters except ASCII control characters, special Git characters (^, ~, :, ?, *, [, ]), double dots (..), multiple consecutive slashes (//), or start/end with a slash (/) or start with period (.).")
  @visibility("read", "create")
  @maxItems(100)
  annotations?: string[];

  @doc("Relative path in storage for all the artifacts of this test. contain only lowercase letters, numbers, and hyphens, and cannot start or end with a hyphen or contain consecutive hyphens")
  @visibility("read", "create")
  @minLength(3)
  @maxLength(63)
  artifactsPath?: string;
}

@doc("Supported browser Types for tests")
union BrowserType {
  string,

  @doc("Chromium")
  "Chromium",

  @doc("Webkit")
  "Webkit",

  @doc("Firefox")
  "Firefox",
}

@doc("Supported OS  for tests")
union OsType {
  string,

  @doc("Windows")
  "Windows",

  @doc("Linux")
  "Linux",

  @doc("Macintosh")
  "Mac",
}

@doc("Attachment kinds uploaded for a test result")
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
  @doc("Name of the CI job running the test. All unicode characters except ASCII control characters, special  characters (^, ~, :, ?, *, [, ]), double dots (..), multiple consecutive slashes (//), or start/end with a slash (/) or start with period (.).")
  @maxLength(500)
  jobName: string;

  @doc("Name of the Playwright project.All unicode characters except ASCII control characters, special Git characters (^, ~, :, ?, *, [, ]), double dots (..), multiple consecutive slashes (//), or start/end with a slash (/) or start with period (.).")
  @maxLength(500)
  projectName: string;

  @doc("Name of the browser.")
  browserType: BrowserType;

  @doc("Operating system where the browser is hosted.")
  os: OsType;
}

// Model representing summary of previous retryCount
@doc("Summary of previous retries.")
model PreviousRetrySummary {
  @doc("Identifier of the test execution.")
  testExecutionId: string;

  @doc("Number of retryCount attempts.")
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

  @doc("List of artifacts paths.")
  @visibility("read")
  artifactsPath?: string;
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
  @doc("List of CI branches for a testrun, All unicode characters except ASCII control characters, special Git characters (^, ~, :, ?, *, [, ]), double dots (..), multiple consecutive slashes (//), or start/end with a slash (/) or start with period (.).")
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

  @doc("Gets a test run.")
  get is Operations.ResourceRead<TestRun>;

  @doc("List test runs.")
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

alias TestRunIdQueryParameter = QueryParametersTrait<{
  /** Mandatory runId for the test results. */
  @query
  @doc("All unicode characters except ASCII control characters, special Git characters (^, ~, :, ?, *, [, ]), double dots (..), multiple consecutive slashes (//), or start/end with a slash (/) or start with period (.).")
  testRunId: string;
}>;

@tag("test-result")
interface TestResults {
  // TestResults Operations

  @doc("Upload Test Results.")
  uploadBatch is Operations.ResourceCollectionAction<
    TestResultDetails,
    UploadTestResultsRequest,
    {},
    TestRunIdQueryParameter
  >;

  @doc("List Test Results.")
  list is Operations.ResourceList<
    TestResultDetails,
    ListQueryParametersTrait<StandardListQueryParameters & FilterQueryParameter>
  >;

  @doc("Get Test Results summary.")
  @action("resultsStats")
  computeResultsStats is Operations.ResourceCollectionAction<
    TestResultDetails,
    {},
    ResultsStats,
    QueryParametersTrait<StandardListQueryParameters & FilterQueryParameter>
  >;
}
