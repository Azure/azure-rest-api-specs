import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Microsoft.LoadTestService;

@doc("Test Profile Id path parameter.")
@added(APIVersions.v2024_05_01_preview)
model TestProfileIdPathParameter {
  @doc("Unique identifier for the test profile, must contain only lower-case alphabetic, numeric, underscore or hyphen characters.")
  @maxLength(50)
  @minLength(2)
  @key
  @visibility("read")
  @pattern("^[a-z0-9_-]*$")
  testProfileId: string;
}

@doc("Test Profile Run Id path parameter.")
@added(APIVersions.v2024_05_01_preview)
model TestProfileRunIdPathParameter {
  @doc("Unique identifier for the test profile run, must contain only lower-case alphabetic, numeric, underscore or hyphen characters.")
  @visibility("read")
  @maxLength(50)
  @minLength(2)
  @key
  @pattern("^[a-z0-9_-]*$")
  testProfileRunId: string;
}

@doc("Kind of the resource on which test profile is created.")
@added(APIVersions.v2024_05_01_preview)
union ResourceKind {
  string,

  @doc("Resource is a Azure FunctionApp on Flex Consumption Plan.")
  FunctionsFlexConsumption: "FunctionsFlexConsumption",
}

@doc("Test profile run status.")
union TestProfileRunStatus {
  string,

  @doc("Test profile run request is accepted.")
  ACCEPTED: "ACCEPTED",

  @doc("Test profile run is not yet started.")
  NOTSTARTED: "NOTSTARTED",

  @doc("Test profile run has started executing.")
  EXECUTING: "EXECUTING",

  @doc("Test profile run has completed successfully.")
  DONE: "DONE",

  @doc("Test profile run is being cancelled.")
  CANCELLING: "CANCELLING",

  @doc("Test profile run is cancelled.")
  CANCELLED: "CANCELLED",

  @doc("Test profile run has failed.")
  FAILED: "FAILED",
}

@doc("Category of Recommendation.")
@added(APIVersions.v2024_05_01_preview)
union RecommendationCategory {
  string,

  @doc("The recommendation for this category optimizes the throughput/RPS (Requests per Second) of the app.")
  ThroughputOptimized: "ThroughputOptimized",

  @doc("The recommendation for this category optimizes the cost of the app.")
  CostOptimized: "CostOptimized",
}

@doc("Resource configuration instance for a Flex Consumption based Azure Function App.")
@added(APIVersions.v2024_05_01_preview)
model FunctionFlexConsumptionResourceConfiguration {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Abbreviating MB to Mb changes the meaning of the value."
  @doc("Memory size of the instance. Supported values are 2048, 4096.")
  instanceMemoryMB: int64;

  @doc("HTTP Concurrency for the function app.")
  httpConcurrency: int64;
}

@doc("Details of a particular test run for a test profile run.")
@added(APIVersions.v2024_05_01_preview)
model TestRunDetail {
  @doc("Status of the test run.")
  status: Status;

  @doc("ID of the configuration on which the test ran.")
  configurationId: string;

  @doc("Key value pair of extra properties associated with the test run.")
  properties: Record<string>;
}

@doc("A recommendation object that provides a list of configuration that optimizes its category.")
@added(APIVersions.v2024_05_01_preview)
model TestProfileRunRecommendation {
  @doc("Category of the recommendation.")
  category: RecommendationCategory;

  @doc("List of configurations IDs for which the recommendation is applicable. These are a subset of the provided target resource configurations.")
  configurations?: string[];
}

@doc("Configurations of a target resource. This varies with the kind of resource.")
@added(APIVersions.v2024_05_01_preview)
@discriminator("kind")
model TargetResourceConfigurations {
  @doc("Kind of the resource for which the configurations apply.")
  @visibility("create", "read")
  kind: ResourceKind;
}

@doc("Configurations for a Function App using Flex Consumption Plan.")
@added(APIVersions.v2024_05_01_preview)
model FunctionFlexConsumptionTargetResourceConfigurations
  extends TargetResourceConfigurations {
  @doc("""
    The kind value to use when providing configuration.
    This should typically be not changed from its value.
    """)
  kind: ResourceKind.FunctionsFlexConsumption;

  @doc("A map of configurations for a Function app using Flex Consumption Plan.")
  configurations?: Record<FunctionFlexConsumptionResourceConfiguration>;
}

@doc("The Test Profile Model. A Test Profile resource enables you to set up a test profile which contains various configurations for a supported resource type and a load test to execute on that resource.")
@summary("Test Profile Model.")
@resource("test-profiles")
@added(APIVersions.v2024_05_01_preview)
model TestProfile {
  ...TestProfileIdPathParameter;

  @maxLength(50)
  @minLength(2)
  @doc("Display name of the test profile.")
  displayName?: string;

  @maxLength(100)
  @doc("Description for the test profile.")
  description?: string;

  @doc("Associated test ID for the test profile. This property is required for creating a Test Profile and it's not allowed to be updated.")
  @visibility("create", "read")
  testId?: string;

  @doc("Target resource ID on which the test profile is created. This property is required for creating a Test Profile and it's not allowed to be updated.")
  @visibility("create", "read")
  targetResourceId?: string;

  @doc("Configurations of the target resource on which testing would be done.")
  targetResourceConfigurations?: TargetResourceConfigurations;

  ...SystemMetaData;
}

@doc("The Test Profile Run Model. Test Profile Run resource enables you to instantiate an already created test profile and run load tests to get recommendations on the optimal configuration for the target resource.")
@summary("Test Profile Run model.")
@resource("test-profile-runs")
@added(APIVersions.v2024_05_01_preview)
model TestProfileRun {
  ...TestProfileRunIdPathParameter;

  // Begin section: Properties provided by user
  @maxLength(50)
  @minLength(2)
  @doc("Display name for the test profile run.")
  displayName?: string;

  @maxLength(100)
  @doc("The test profile run description")
  description?: string;

  @doc("Associated test profile ID for the test profile run. This is required to create a test profile run and can't be updated.")
  @visibility("create", "read")
  testProfileId?: string;

  // End section: Properties provided by user

  // Begin section: Properties populated from Test Profile
  @doc("Target resource ID on which the test profile run is created")
  @visibility("read")
  targetResourceId?: string;

  @doc("Configurations of the target resource on which the test profile ran.")
  @visibility("read")
  targetResourceConfigurations?: TargetResourceConfigurations;

  // End section: Properties populated from Test Profile

  // Begin section: Test profile Run specific information
  @doc("The test profile run status.")
  @visibility("read")
  status?: TestProfileRunStatus;

  @doc("Error details if there is any failure in test profile run. These errors are specific to the Test Profile Run.")
  @visibility("read")
  errorDetails?: ErrorDetails[];

  @doc("The test profile run start DateTime(RFC 3339 literal format).")
  @visibility("read")
  startDateTime?: utcDateTime;

  @doc("The test profile run end DateTime(RFC 3339 literal format).")
  @visibility("read")
  endDateTime?: utcDateTime;

  @doc("Test profile run duration in seconds.")
  @visibility("read")
  durationInSeconds?: int64;

  @doc("""
    Details of the test runs ran as part of the test profile run.
    Key is the testRunId of the corresponding testRun.
    """)
  @visibility("read")
  testRunDetails?: Record<TestRunDetail>;

  @doc("Recommendations provided based on a successful test profile run.")
  @visibility("read")
  recommendations?: TestProfileRunRecommendation[];

  // End section: Test profile run specific information

  ...SystemMetaData;
}

@doc("Parameters for list test profile operation")
@added(APIVersions.v2024_05_01_preview)
model ListTestProfileQueryParams {
  @doc("Maximum number of results to include in a single response.")
  @query
  maxpagesize?: int32;

  @doc("""
    Start DateTime(RFC 3339 literal format) of the last updated time range to filter test profiles.
    """)
  @query
  lastModifiedStartTime?: utcDateTime;

  @doc("""
    End DateTime(RFC 3339 literal format) of the last updated time range to filter test profiles.
    """)
  @query
  lastModifiedEndTime?: utcDateTime;

  @doc("Comma separated list of IDs of the test profiles to filter.")
  @query
  testProfileIds?: string;

  @doc("Comma separated list IDs of the tests which should be associated with the test profiles to fetch.")
  @query
  testIds?: string;
}

@doc("Parameters for list test profile run operation")
@added(APIVersions.v2024_05_01_preview)
model ListTestProfileRunQueryParams {
  @doc("Maximum number of results to include in a single response.")
  @query
  maxpagesize?: int32;

  @doc("""
    Minimum Start DateTime(RFC 3339 literal format) of the test profile runs to filter on.
    """)
  @query
  minStartDateTime?: utcDateTime;

  @doc("""
    Maximum Start DateTime(RFC 3339 literal format) of the test profile runs to filter on.
    """)
  @query
  maxStartDateTime?: utcDateTime;

  @doc("""
    Minimum End DateTime(RFC 3339 literal format) of the test profile runs to filter on.
    """)
  @query
  minEndDateTime?: utcDateTime;

  @doc("""
    Maximum End DateTime(RFC 3339 literal format) of the test profile runs to filter on.
    """)
  @query
  maxEndDateTime?: utcDateTime;

  @doc("""
    Start DateTime(RFC 3339 literal format) of the created time range to filter test profile runs.
    """)
  @query
  createdDateStartTime?: utcDateTime;

  @doc("""
    End DateTime(RFC 3339 literal format) of the created time range to filter test profile runs.
    """)
  @query
  createdDateEndTime?: utcDateTime;

  @doc("Comma separated list of IDs of the test profile runs to filter.")
  @query
  testProfileRunIds?: string;

  @doc("Comma separated IDs of the test profiles which should be associated with the test profile runs to fetch.")
  @query
  testProfileIds?: string;

  @doc("Comma separated list of Statuses of the test profile runs to filter.")
  @query
  statuses?: string;
}
