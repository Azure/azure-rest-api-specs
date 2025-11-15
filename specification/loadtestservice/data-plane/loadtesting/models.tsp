import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.LoadTestService;

@doc("Metrics for pass/fail criteria.")
union PFMetrics {
  string,

  @doc("Pass fail criteria for response time metric in milliseconds.")
  ResponseTimeInMilliseconds: "response_time_ms",

  @doc("Pass fail criteria for latency metric in milliseconds.")
  Latency: "latency",

  @doc("Pass fail criteria for error metric.")
  Error: "error",

  @doc("Pass fail criteria for total requests.")
  Requests: "requests",

  @doc("Pass fail criteria for request per second.")
  RequestsPerSecond: "requests_per_sec",
}

@doc("Aggregation functions for pass/fail criteria.")
union PassFailAggregationFunction {
  string,

  @doc("Criteria applies for count value.")
  Count: "count",

  @doc("Criteria applies for given percentage value.")
  Percentage: "percentage",

  @doc("Criteria applies for avg value.")
  Average: "avg",

  @doc("Criteria applies for 50th percentile value.")
  Percentile50: "p50",

  @doc("Criteria applies for 75th percentile value.")
  @added(APIVersions.v2024_05_01_preview)
  Percentile75: "p75",

  @doc("Criteria applies for 90th percentile value.")
  Percentile90: "p90",

  @doc("Criteria applies for 95th percentile value.")
  Percentile95: "p95",

  @doc("Criteria applies for 96th percentile value.")
  @added(APIVersions.v2024_05_01_preview)
  Percentile96: "p96",

  @doc("Criteria applies for 97th percentile value.")
  @added(APIVersions.v2024_05_01_preview)
  Percentile97: "p97",

  @doc("Criteria applies for 98th percentile value.")
  @added(APIVersions.v2024_05_01_preview)
  Percentile98: "p98",

  @doc("Criteria applies for 99th percentile value.")
  Percentile99: "p99",

  @doc("Criteria applies for 99.9th percentile value.")
  @added(APIVersions.v2024_05_01_preview)
  Percentile999: "p99.9",

  @doc("Criteria applies for 99.99th percentile value.")
  @added(APIVersions.v2024_05_01_preview)
  Percentile9999: "p99.99",

  @doc("Criteria applies for minimum value.")
  Minimum: "min",

  @doc("Criteria applies for maximum value.")
  Maximum: "max",
}

@doc("Action to take on failure of pass/fail criteria.")
union PassFailAction {
  string,

  @doc("Test will continue to run even if pass fail metric criteria metric gets failed.")
  continue: "continue",

  @doc("Test run will stop if pass fail criteria metric is not passed.")
  stop: "stop",
}

@doc("Pass/fail criteria result.")
union PassFailResult {
  string,
  @doc("Given pass fail criteria metric has passed.") "passed",
  @doc("Given pass fail criteria metric couldn't determine.") "undetermined",
  @doc("Given pass fail criteria metric has failed.") "failed",
}

@doc("Types of secrets supported.")
union SecretType {
  string,

  @doc("If the secret is stored in an Azure Key Vault.")
  KeyVaultSecretUri: "AKV_SECRET_URI",

  @doc("If the secret value provided as plain text.")
  SecretValue: "SECRET_VALUE",
}

@doc("Managed identity type.")
union ManagedIdentityType {
  string,

  @doc("System-assigned managed identity.")
  SystemAssigned: "SystemAssigned",

  @doc("User-assigned managed identity.")
  UserAssigned: "UserAssigned",
}

@doc("Types of certificates supported.")
union CertificateType {
  string,

  @doc("If the certificate is stored in an Azure Key Vault.")
  KeyVaultCertificateUri: "AKV_CERT_URI",
}

@doc("Types of file supported.")
union FileType {
  string,

  @doc("If the file is a JMX script.")
  JmxFile: "JMX_FILE",

  @doc("If the file is a user properties file.")
  UserProperties: "USER_PROPERTIES",

  @doc("If the file is not among any of the other supported file types.")
  AdditionalArtifacts: "ADDITIONAL_ARTIFACTS",

  @added(APIVersions.v2023_04_01_preview)
  @doc("If the file is a compressed archive containing a collection of various artifacts or resources.")
  ZippedArtifacts: "ZIPPED_ARTIFACTS",

  @added(APIVersions.v2023_04_01_preview)
  @doc("If the file is a JSON config file to define the requests for a URL test.")
  UrlTestConfig: "URL_TEST_CONFIG",

  @added(APIVersions.v2024_03_01_preview)
  @doc("If the file is a test script.")
  TestScript: "TEST_SCRIPT",
}

@doc("File status.")
union FileValidationStatus {
  string,

  @doc("File is not validated.")
  NotValidated: "NOT_VALIDATED",

  @doc("File is validated.")
  ValidationSuccess: "VALIDATION_SUCCESS",

  @doc("File validation is failed.")
  ValidationFailure: "VALIDATION_FAILURE",

  @doc("File validation is in progress.")
  ValidationInitiated: "VALIDATION_INITIATED",

  @doc("Validation is not required.")
  ValidationNotRequired: "VALIDATION_NOT_REQUIRED",
}

@doc("Test result based on pass/fail criteria.")
union PassFailTestResult {
  string,
  @doc("Pass/fail criteria has passed.") "PASSED",
  @doc("Pass/fail criteria is not applicable.") "NOT_APPLICABLE",
  @doc("Pass/fail criteria has failed.") "FAILED",
}

@doc("Test run status.")
union TestRunStatus {
  string,

  @doc("Test run request is accepted.")
  Accepted: "ACCEPTED",

  @doc("Test run is not yet started.")
  NotStarted: "NOTSTARTED",

  @doc("Test run is provisioning.")
  Provisioning: "PROVISIONING",

  @doc("Test run is provisioned.")
  Provisioned: "PROVISIONED",

  @doc("Test run is getting configured.")
  Configuring: "CONFIGURING",

  @doc("Test run configuration is done.")
  Configured: "CONFIGURED",

  @doc("Test run has started executing.")
  Executing: "EXECUTING",

  @doc("Test run execution is completed.")
  Executed: "EXECUTED",

  @doc("Test run is getting deprovisioned.")
  Deprovisioning: "DEPROVISIONING",

  @doc("Test run is deprovisioned.")
  Deprovisioned: "DEPROVISIONED",

  @doc("Test run is completed.")
  Done: "DONE",

  @doc("Test run is being cancelled.")
  Cancelling: "CANCELLING",

  @doc("Test run request is cancelled.")
  Cancelled: "CANCELLED",

  @doc("Test run request is failed.")
  Failed: "FAILED",

  @doc("Test run JMX file is validated.")
  ValidationSuccess: "VALIDATION_SUCCESS",

  @doc("Test run JMX file validation is failed.")
  ValidationFailure: "VALIDATION_FAILURE",
}

@doc("Aggregation type.")
union Aggregation {
  string,
  @doc("Average value.") "Average",
  @doc("Total count.") "Count",
  @doc("Aggregation will be average in this case.") "None",
  @doc("Total sum.") "Total",

  @doc("75th percentile.")
  @added(APIVersions.v2024_05_01_preview)
  "Percentile75",

  @doc("90th percentile.") "Percentile90",
  @doc("95th percentile.") "Percentile95",

  @doc("96th percentile.")
  @added(APIVersions.v2024_05_01_preview)
  "Percentile96",

  @doc("97th percentile.")
  @added(APIVersions.v2024_05_01_preview)
  "Percentile97",

  @doc("98th percentile.")
  @added(APIVersions.v2024_05_01_preview)
  "Percentile98",

  @doc("99th percentile.") "Percentile99",

  @doc("99.9th percentile.")
  @added(APIVersions.v2024_05_01_preview)
  "Percentile999",

  @doc("99.99th percentile.")
  @added(APIVersions.v2024_05_01_preview)
  "Percentile9999",
}

@doc("Metric unit.")
union MetricUnit {
  string,
  @doc("No unit specified.") "NotSpecified",
  @doc("Percentage.") "Percent",
  @doc("Value count.") "Count",
  @doc("Seconds.") "Seconds",
  @doc("Milliseconds") "Milliseconds",
  @doc("Bytes") "Bytes",
  @doc("Bytes per second") "BytesPerSecond",
  @doc("Count per second") "CountPerSecond",
}

@doc("Time Grain")
union TimeGrain {
  string,

  @doc("5 seconds, available only if test run duration is less than 10 minutes.")
  PT5S: "PT5S",

  @doc("10 seconds, available only if test run duration is less than 10 minutes.")
  PT10S: "PT10S",

  @doc("1 minute")
  PT1M: "PT1M",

  @doc("5 minutes, available only if test run duration is greater than 1 minute.")
  PT5M: "PT5M",

  @doc("1 hour, available only if test run duration is greater than 1 minute.")
  PT1H: "PT1H",
}

@added(APIVersions.v2023_04_01_preview)
@doc("Test kind")
union TestKind {
  string,

  @doc("URL Test")
  Url: "URL",

  @doc("JMX Test")
  Jmx: "JMX",

  @added(APIVersions.v2024_03_01_preview)
  @doc("Locust Test")
  Locust: "Locust",
}

@added(APIVersions.v2024_07_01_preview)
@doc("The type of the entity that created the test run. (E.x. User, ScheduleTrigger, etc).")
union CreatedByType {
  string,

  @doc("Entity was created by a user.")
  "User",

  @doc("Entity was created by a scheduled trigger.")
  "ScheduledTrigger",

  @added(APIVersions.v2025_03_01_preview)
  @doc("Entity was created by Azure DevOps pipelines.")
  "AzurePipelines",

  @added(APIVersions.v2025_03_01_preview)
  @doc("Entity was created by GitHub Workflows.")
  "GitHubWorkflows",
}

@doc("Test file info.")
@resource("files")
@parentResource(Test)
model TestFileInfo is FileInfo;

@doc("Test run file info.")
@resource("files")
@parentResource(TestRun)
model TestRunFileInfo is FileInfo;

@doc("Load test model.")
@resource("tests")
model Test {
  @doc("Pass fail criteria for a test.")
  passFailCriteria?: PassFailCriteria;

  @added(APIVersions.v2023_04_01_preview)
  @doc("Auto stop criteria for a test. This will automatically stop a load test if the error percentage is high for a certain time window.")
  autoStopCriteria?: AutoStopCriteria;

  @doc("""
    Secrets can be stored in an Azure Key Vault or any other secret store. If the
    secret is stored in an Azure Key Vault, the value should be the secret
    identifier and the type should be AKV_SECRET_URI. If the secret is stored
    elsewhere, the secret value should be provided directly and the type should be
    SECRET_VALUE.
    """)
  secrets?: Record<Secret>;

  @doc("Certificates metadata.")
  certificate?: CertificateMetadata;

  @doc("Environment variables which are defined as a set of <name,value> pairs.")
  environmentVariables?: Record<string>;

  @doc("The load test configuration.")
  loadTestConfiguration?: LoadTestConfiguration;

  @added(APIVersions.v2023_04_01_preview)
  @doc("Id of the test run to be marked as baseline to view trends of client-side metrics from recent test runs")
  baselineTestRunId?: string;

  @doc("The input artifacts for the test.")
  @visibility(Lifecycle.Read)
  inputArtifacts?: TestInputArtifacts;

  ...TestIdPathParameter;

  @maxLength(100)
  @doc("The test description.")
  description?: string;

  @maxLength(50)
  @minLength(2)
  @doc("Display name of a test.")
  displayName?: string;

  @doc("Subnet ID on which the load test instances should run.")
  subnetId?: string;

  @added(APIVersions.v2023_04_01_preview)
  @doc("Kind of test.")
  kind?: TestKind;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is an abbervation and should be all caps"
  @added(APIVersions.v2023_04_01_preview)
  @doc("Inject load test engines without deploying public IP for outbound access")
  publicIPDisabled?: boolean;

  @doc("Type of the managed identity referencing the Key vault.")
  keyvaultReferenceIdentityType?: string;

  @doc("Resource Id of the managed identity referencing the Key vault.")
  keyvaultReferenceIdentityId?: string;

  @doc("Type of the managed identity referencing the metrics.")
  @added(APIVersions.v2024_07_01_preview)
  metricsReferenceIdentityType?: ManagedIdentityType = ManagedIdentityType.SystemAssigned;

  @doc("Resource Id of the managed identity referencing the metrics.")
  @added(APIVersions.v2024_07_01_preview)
  metricsReferenceIdentityId?: string;

  @doc("Type of the managed identity built in load test engines")
  @added(APIVersions.v2024_12_01_preview)
  engineBuiltInIdentityType?: ManagedIdentityType;

  @doc("Resource Ids of the managed identity built in to load test engines. Required if engineBuiltInIdentityType is UserAssigned.")
  @added(APIVersions.v2024_12_01_preview)
  engineBuiltInIdentityIds?: string[];

  @added(APIVersions.v2025_03_01_preview)
  @doc("Estimated virtual user hours for the test.")
  @visibility(Lifecycle.Read)
  estimatedVirtualUserHours?: float64;

  ...SystemMetaData;
}

@doc("Pass fail criteria for a test.")
model PassFailCriteria {
  @doc("Map of id and pass fail metrics { id  : pass fail metrics }.")
  passFailMetrics?: Record<PassFailMetric>;

  @doc("Map of id and pass fail server metrics { id  : pass fail metrics }.")
  @added(APIVersions.v2024_07_01_preview)
  passFailServerMetrics?: Record<PassFailServerMetric>;
}

@doc("Pass fail metric")
model PassFailMetric {
  @doc("The client metric on which the criteria should be applied.")
  clientMetric?: PFMetrics;

  @doc("""
    The aggregation function to be applied on the client metric. Allowed functions
    - ‘percentage’ - for error metric , ‘avg’, percentiles like ‘p50’, ‘p90’, & so on, ‘min’,
    ‘max’ - for response_time_ms and latency metric, ‘avg’ - for requests_per_sec,
    ‘count’ - for requests
    """)
  aggregate?: PassFailAggregationFunction;

  @doc("The comparison operator. Supported types ‘>’, ‘<’ ")
  condition?: string;

  @doc("Request name for which the Pass fail criteria has to be applied ")
  requestName?: string;

  @doc("""
    The value to compare with the client metric. Allowed values - ‘error : [0.0 ,
    100.0] unit- % ’, response_time_ms and latency : any integer value unit- ms.
    """)
  value?: float64;

  @doc("Action taken after the threshold is met. Default is ‘continue’.")
  action?: PassFailAction = PassFailAction.continue;

  @doc("The actual value of the client metric for the test run.")
  @visibility(Lifecycle.Read)
  actualValue?: float64;

  @doc("Outcome of the test run.")
  @visibility(Lifecycle.Read)
  result?: PassFailResult;
}

@doc("Pass fail server metric")
model PassFailServerMetric {
  @doc("The resource id of the resource emitting the metric.")
  resourceId: armResourceIdentifier;

  @doc("The server metric namespace.")
  metricNamespace: string;

  @doc("The server metric name.")
  metricName: string;

  @doc("Aggregation Type")
  aggregation: string;

  @doc("The comparison operator. Supported types ‘>’, ‘<’ ")
  condition: string;

  @doc("The value to compare with the server metric.")
  value: float64;

  @doc("Action taken after the threshold is met. Default is ‘continue’.")
  action?: PassFailAction = PassFailAction.continue;

  @doc("The actual value of the server metric ")
  @visibility(Lifecycle.Read)
  actualValue?: float64;

  @doc("Outcome of the test run.")
  @visibility(Lifecycle.Read)
  result?: PassFailResult;
}

@doc("Secret")
model Secret {
  @doc("The value of the secret for the respective type")
  value?: string;

  @doc("Type of secret")
  type?: SecretType;
}

@doc("Certificates metadata")
model CertificateMetadata {
  @doc("The value of the certificate for respective type")
  value?: string;

  @doc("Type of certificate")
  type?: CertificateType;

  @doc("Name of the certificate.")
  name?: string;
}

@added(APIVersions.v2023_04_01_preview)
@doc("Auto stop criteria for a test. This will automatically stop a load test if the error percentage is high for a certain time window.")
model AutoStopCriteria {
  @doc("Whether auto-stop should be disabled. The default value is false.")
  autoStopDisabled?: boolean = false;

  @doc("Threshold percentage of errors on which test run should be automatically stopped. Allowed values are in range of 0.0-100.0")
  errorRate?: float32 = 90;

  @doc("Time window during which the error percentage should be evaluated in seconds.")
  @encode(DurationKnownEncoding.seconds, int32)
  errorRateTimeWindowInSeconds?: duration = duration.fromISO("PT60S");

  @added(APIVersions.v2025_03_01_preview)
  @doc("Maximum number of virtual users per load testing engine, at which the test run should be automatically stopped.")
  maximumVirtualUsersPerEngine?: int32 = 5000;
}

@doc("Configurations for the load test.")
model LoadTestConfiguration {
  @doc("""
    The number of engine instances to execute load test. Supported values are in range of 1-400. Required for creating a new test.
    """)
  engineInstances?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "CSV is an abbervation and should be all caps"
  @doc("""
    If false, Azure Load Testing copies and processes your input files unmodified
    across all test engine instances. If true, Azure Load Testing splits the CSV
    input data evenly across all engine instances. If you provide multiple CSV
    files, each file will be split evenly.
    """)
  splitAllCSVs?: boolean = false;

  @doc("""
    If true, optionalLoadTestConfig is required and JMX script for the load test is
    not required to upload.
    """)
  quickStartTest?: boolean = false;

  @doc("Configuration for quick load test")
  optionalLoadTestConfig?: OptionalLoadTestConfiguration;

  @added(APIVersions.v2024_03_01_preview)
  @doc("Region distribution configuration for the load test.")
  regionalLoadTestConfig?: RegionalConfiguration[];
}

@doc("Region distribution configuration for the load test.")
model RegionalConfiguration {
  @doc("""
      The number of engine instances to execute load test in specified region. Supported values are in range of 1-400.
    """)
  engineInstances: int32;

  @doc("""
    Azure region name.
    The region name should of format accepted by ARM, and should be a region supported by Azure Load Testing. For example, East US should be passed as "eastus".
    The region name must match one of the strings in the "Name" column returned from running the "az account list-locations -o table" Azure CLI command.
    """)
  region: azureLocation;
}

@doc("Configuration for quick load test")
model OptionalLoadTestConfiguration {
  @doc("Test URL. Provide the complete HTTP URL. For example, https://contoso-app.azurewebsites.net/login")
  endpointUrl?: string;

  @doc("Target throughput (requests per second). This may not be necessarily achieved. The actual throughput will be lower if the application is not capable of handling it.")
  @added(APIVersions.v2023_04_01_preview)
  requestsPerSecond?: int32;

  @doc("Maximum response time in milliseconds of the API/endpoint.")
  @added(APIVersions.v2023_04_01_preview)
  maxResponseTimeInMs?: int32;

  @doc("No of concurrent virtual users.")
  virtualUsers?: int32;

  @doc("Ramp up time in seconds.")
  rampUpTime?: int32;

  @doc("Test run duration in seconds.")
  @encode(DurationKnownEncoding.seconds, int32)
  duration?: duration;
}

@doc("The input artifacts for the test.")
model TestInputArtifacts {
  @doc("The load test YAML file that contains the the test configuration")
  configFileInfo?: TestFileInfo;

  @doc("The test script file for the test run")
  testScriptFileInfo?: TestFileInfo;

  @doc("The user properties file")
  userPropFileInfo?: TestFileInfo;

  @doc("The zip file with all input artifacts")
  inputArtifactsZipFileInfo?: TestFileInfo;

  @added(APIVersions.v2023_04_01_preview)
  @doc("The config json file for url based test")
  urlTestConfigFileInfo?: TestFileInfo;

  @doc("Additional supported files for the test run")
  @visibility(Lifecycle.Read)
  additionalFileInfo?: TestFileInfo[];
}

@doc("File info")
model FileInfo {
  #suppress "@azure-tools/typespec-azure-core/key-visibility-required" "model is output only"
  @doc("Name of the file.")
  @key
  fileName: string;

  @doc("File URL.")
  //update description
  @visibility(Lifecycle.Read)
  url?: url;

  @doc("File type")
  @visibility(Lifecycle.Read)
  fileType?: FileType;

  @doc("Expiry time of the file (RFC 3339 literal format)")
  @visibility(Lifecycle.Read)
  expireDateTime?: utcDateTime;

  @doc("Validation status of the file")
  @visibility(Lifecycle.Read)
  validationStatus?: FileValidationStatus;

  @doc("Validation failure error details")
  @visibility(Lifecycle.Read)
  validationFailureDetails?: string;
}

@doc("Test app components")
model TestAppComponents {
  @doc("""
    Azure resource collection { resource id (fully qualified resource Id e.g
    subscriptions/{subId}/resourceGroups/{rg}/providers/Microsoft.LoadTestService/loadtests/{resName})
    : resource object } 
    """)
  components: Record<AppComponent>;

  @doc("Test identifier")
  @visibility(Lifecycle.Read)
  testId?: string;

  ...SystemMetaData;
}

@doc("""
  An Azure resource object (Refer azure generic resource model :https://learn.microsoft.com/en-us/rest/api/resources/resources/get-by-id#genericresource)
  """)
model AppComponent {
  @doc("""
    fully qualified resource Id e.g subscriptions/{subId}/resourceGroups/{rg}/providers/Microsoft.LoadTestService/loadtests/{resName}
    """)
  @visibility(Lifecycle.Read)
  resourceId: armResourceIdentifier;

  @doc("Azure resource name, required while creating the app component.")
  resourceName: string;

  @doc("Azure resource type, required while creating the app component.")
  resourceType: string;

  @doc("Azure resource display name")
  displayName?: string;

  @doc("Resource group name of the Azure resource")
  @visibility(Lifecycle.Read)
  resourceGroup?: string;

  @doc("Subscription Id of the Azure resource")
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  @doc("Kind of Azure resource type")
  kind?: string;
}

@doc("Test server metrics configuration")
model TestServerMetricsConfiguration {
  @doc("Test identifier")
  @visibility(Lifecycle.Read)
  testId?: string;

  @doc("""
    Azure resource metrics collection {metric id : metrics object} (Refer :
    https://learn.microsoft.com/en-us/rest/api/monitor/metric-definitions/list#metricdefinition
    for metric id).
    """)
  metrics: Record<ResourceMetric>;

  ...SystemMetaData;
}

@doc("""
  Associated metric definition for particular metrics of the azure resource (
  Refer :
  https://learn.microsoft.com/en-us/rest/api/monitor/metric-definitions/list#metricdefinition).
  """)
model ResourceMetric {
  @doc("Unique name for metric.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("Azure resource id.")
  resourceId: armResourceIdentifier;

  @doc("Metric name space.")
  metricNamespace: string;

  @doc("Metric description.")
  displayDescription?: string;

  @doc("The invariant value of metric name")
  name: string;

  @doc("Metric aggregation.")
  aggregation: string;

  @doc("Metric unit.")
  unit?: string;

  @doc("Azure resource type.")
  resourceType: string;
}

@doc("Load test run model")
@resource("test-runs")
model TestRun {
  ...TestRunIdPathParameter;

  @doc("Pass fail criteria for a test.")
  passFailCriteria?: PassFailCriteria;

  @doc("Auto stop criteria for a test. This will automatically stop a load test if the error percentage is high for a certain time window.")
  @added(APIVersions.v2023_04_01_preview)
  autoStopCriteria?: AutoStopCriteria;

  @doc("""
    Secrets can be stored in an Azure Key Vault or any other secret store. If the
    secret is stored in an Azure Key Vault, the value should be the secret
    identifier and the type should be AKV_SECRET_URI. If the secret is stored
    elsewhere, the secret value should be provided directly and the type should be
    SECRET_VALUE.
    """)
  secrets?: Record<Secret>;

  @doc("Certificates metadata")
  certificate?: CertificateMetadata;

  @doc("Environment variables which are defined as a set of <name,value> pairs.")
  environmentVariables?: Record<string>;

  @doc("Error details if there is any failure in load test run")
  @visibility(Lifecycle.Read)
  errorDetails?: ErrorDetails[];

  @doc("""
    Test run statistics. Key is the sampler name and value is the set of statistics for performance metrics like response time, throughput, etc. from the load test run.
    The sampler name is the same as the name mentioned in the test script.
    Sampler name "Total" represents the aggregated statistics of all the samplers.
    """)
  @visibility(Lifecycle.Read)
  testRunStatistics?: Record<TestRunStatistics>;

  @doc("""
    Regional statistics. Key is the Azure region name and value is the test run statistics.
    The region name should of format accepted by ARM, and should be a region supported by Azure Load Testing. For example, East US should be passed as "eastus".
    The region name must match one of the strings in the "Name" column returned from running the "az account list-locations -o table" Azure CLI command.
    """)
  @visibility(Lifecycle.Read)
  @added(APIVersions.v2024_03_01_preview)
  regionalStatistics?: Record<TestRunStatistics>;

  @doc("The load test configuration.")
  @visibility(Lifecycle.Read)
  loadTestConfiguration?: LoadTestConfiguration;

  @doc("Collection of test run artifacts")
  @visibility(Lifecycle.Read)
  testArtifacts?: TestRunArtifacts;

  @doc("Test result for pass/Fail criteria used during the test run.")
  @visibility(Lifecycle.Read)
  testResult?: PassFailTestResult;

  @doc("Number of virtual users, for which test has been run.")
  @visibility(Lifecycle.Read)
  virtualUsers?: int32;

  @maxLength(50)
  @minLength(2)
  @doc("Display name of a testRun.")
  displayName?: string;

  @maxLength(50)
  @minLength(2)
  @doc("Associated test Id.")
  testId?: string;

  @maxLength(100)
  @doc("The test run description.")
  description?: string;

  @doc("The test run status.")
  @visibility(Lifecycle.Read)
  status?: TestRunStatus;

  @doc("The test run start DateTime(RFC 3339 literal format).")
  @visibility(Lifecycle.Read)
  startDateTime?: utcDateTime;

  @doc("The test run end DateTime(RFC 3339 literal format).")
  @visibility(Lifecycle.Read)
  endDateTime?: utcDateTime;

  @doc("Test run initiated time.")
  @visibility(Lifecycle.Read)
  executedDateTime?: utcDateTime;

  @doc("Portal url.")
  @visibility(Lifecycle.Read)
  portalUrl?: string;

  @doc("Test run duration in milliseconds.")
  @visibility(Lifecycle.Read)
  duration?: int64;

  @doc("Virtual user hours consumed by the test run.")
  @visibility(Lifecycle.Read)
  @added(APIVersions.v2024_07_01_preview)
  virtualUserHours?: float64;

  @doc("Subnet ID on which the load test instances should run.")
  @visibility(Lifecycle.Read)
  subnetId?: string;

  @added(APIVersions.v2023_04_01_preview)
  @doc("Type of test.")
  @visibility(Lifecycle.Read)
  kind?: TestKind;

  @added(APIVersions.v2024_05_01_preview)
  @doc("Request data collection level for test run")
  requestDataLevel?: RequestDataLevel;

  @added(APIVersions.v2024_05_01_preview)
  @doc("Enable or disable debug level logging. True if debug logs are enabled for the test run. False otherwise")
  debugLogsEnabled?: boolean;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is an abbervation and should be all caps"
  @added(APIVersions.v2023_04_01_preview)
  @doc("Inject load test engines without deploying public IP for outbound access")
  @visibility(Lifecycle.Read)
  publicIPDisabled?: boolean;

  @added(APIVersions.v2024_07_01_preview)
  @doc("The type of the entity that created the test run. (E.x. User, ScheduleTrigger, etc).")
  createdByType?: CreatedByType;

  @visibility(Lifecycle.Read)
  @added(APIVersions.v2025_03_01_preview)
  @doc("The URI pointing to the entity that created the test run.")
  createdByUri?: url;

  @added(APIVersions.v2025_03_01_preview)
  @doc("Estimated virtual user hours for the test run.")
  @visibility(Lifecycle.Read)
  estimatedVirtualUserHours?: float64;

  ...SystemMetaData;
}

@doc("Represents insights for the test run.")
@added(APIVersions.v2025_03_01_preview)
model TestRunInsights {
  @doc("The columns of the insights.")
  @visibility(Lifecycle.Read)
  columns?: TestRunInsightColumn[];

  @doc("The rows of the insights.")
  @visibility(Lifecycle.Read)
  rows?: Record<string>[];

  @doc("The version of the insights.")
  @visibility(Lifecycle.Read)
  version?: int64;

  @doc("The status of the insights.")
  @visibility(Lifecycle.Read)
  status?: Foundations.OperationState;
}

@doc("Represents a column of the test run insight")
@added(APIVersions.v2025_03_01_preview)
model TestRunInsightColumn {
  @doc("Name of the column.")
  name: string;

  @doc("The data type of the column.")
  dataType: string;
}

@doc("Error details if there is any failure in load test run")
model ErrorDetails {
  @doc("Error code if there is any failure in load test run.")
  @visibility(Lifecycle.Read)
  @added(APIVersions.v2025_03_01_preview)
  code?: string;

  @doc("Error details in case test run was not successfully run.")
  @visibility(Lifecycle.Read)
  message?: string;

  @added(APIVersions.v2025_03_01_preview)
  @doc("A dictionary for storing additional error information for better context. Each key is a property name (e.g., \"Description\", \"Resolution\", \"Category\", \"Region\"), and its value is an array of strings with relevant details.")
  @visibility(Lifecycle.Read)
  properties?: Record<string[]>;
}

@doc("Test run statistics.")
model TestRunStatistics {
  @doc("Transaction name.")
  @visibility(Lifecycle.Read)
  transaction?: string;

  @doc("Sampler count.")
  @visibility(Lifecycle.Read)
  sampleCount?: float64;

  @doc("Error count.")
  @visibility(Lifecycle.Read)
  errorCount?: float64;

  @doc("Error percentage.")
  @visibility(Lifecycle.Read)
  errorPct?: float64;

  @doc("Mean response time.")
  @visibility(Lifecycle.Read)
  meanResTime?: float64;

  @doc("Median response time.")
  @visibility(Lifecycle.Read)
  medianResTime?: float64;

  @doc("Max response time.")
  @visibility(Lifecycle.Read)
  maxResTime?: float64;

  @doc("Minimum response time.")
  @visibility(Lifecycle.Read)
  minResTime?: float64;

  @doc("90 percentile response time.")
  @visibility(Lifecycle.Read)
  pct1ResTime?: float64;

  @doc("95 percentile response time.")
  @visibility(Lifecycle.Read)
  pct2ResTime?: float64;

  @doc("99 percentile response time.")
  @visibility(Lifecycle.Read)
  pct3ResTime?: float64;

  @added(APIVersions.v2024_05_01_preview)
  @doc("75 percentile response time.")
  @visibility(Lifecycle.Read)
  pct75ResTime?: float64;

  @added(APIVersions.v2024_05_01_preview)
  @doc("96 percentile response time.")
  @visibility(Lifecycle.Read)
  pct96ResTime?: float64;

  @added(APIVersions.v2024_05_01_preview)
  @doc("97 percentile response time.")
  @visibility(Lifecycle.Read)
  pct97ResTime?: float64;

  @added(APIVersions.v2024_05_01_preview)
  @doc("98 percentile response time.")
  @visibility(Lifecycle.Read)
  pct98ResTime?: float64;

  @added(APIVersions.v2024_05_01_preview)
  @doc("99.9 percentile response time.")
  @visibility(Lifecycle.Read)
  pct999ResTime?: float64;

  @added(APIVersions.v2024_05_01_preview)
  @doc("99.99 percentile response time.")
  @visibility(Lifecycle.Read)
  pct9999ResTime?: float64;

  @doc("Throughput.")
  @visibility(Lifecycle.Read)
  throughput?: float64;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "KBytes is expected"
  @doc("Received network bytes.")
  @visibility(Lifecycle.Read)
  receivedKBytesPerSec?: float64;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "KBytes is expected"
  @doc("Send network bytes.")
  @visibility(Lifecycle.Read)
  sentKBytesPerSec?: float64;
}

@doc("Collection of test run artifacts")
model TestRunArtifacts {
  @doc("The input artifacts for the test run.")
  @visibility(Lifecycle.Read)
  inputArtifacts?: TestRunInputArtifacts;

  @doc("The output artifacts for the test run.")
  outputArtifacts?: TestRunOutputArtifacts;
}

@doc("The input artifacts for the test run.")
model TestRunInputArtifacts {
  @doc("The load test YAML file that contains the the test configuration")
  configFileInfo?: TestRunFileInfo;

  @doc("The test script file for the test run")
  testScriptFileInfo?: TestRunFileInfo;

  @doc("The user properties file")
  userPropFileInfo?: TestRunFileInfo;

  @doc("The zip file for all input artifacts")
  inputArtifactsZipFileInfo?: TestRunFileInfo;

  @added(APIVersions.v2023_04_01_preview)
  @doc("The config json file for url based test")
  urlTestConfigFileInfo?: TestRunFileInfo;

  @doc("Additional supported files for the test run")
  @visibility(Lifecycle.Read)
  additionalFileInfo?: TestRunFileInfo[];
}

@doc("The output artifacts for the test run.")
model TestRunOutputArtifacts {
  @doc("The test run results file")
  resultFileInfo?: TestRunFileInfo;

  @doc("The test run report with metrics")
  logsFileInfo?: TestRunFileInfo;

  @doc("The container for test run artifacts.")
  @added(APIVersions.v2023_04_01_preview)
  artifactsContainerInfo?: ArtifactsContainerInfo;

  @added(APIVersions.v2024_05_01_preview)
  @doc("The report file for the test run.")
  reportFileInfo?: TestRunFileInfo;
}

@doc("Artifacts container info.")
@added(APIVersions.v2023_04_01_preview)
model ArtifactsContainerInfo {
  @doc("This is a SAS URI to an Azure Storage Container that contains the test run artifacts.")
  url?: url;

  @doc("Expiry time of the container (RFC 3339 literal format)")
  expireDateTime?: utcDateTime;
}

@doc("Request to clone an existing test into a new test.")
@added(APIVersions.v2025_03_01_preview)
model CloneTestRequest {
  @doc("Unique identifier for the new test that will be created.")
  @pattern("^[a-z0-9_-]*$")
  newTestId: string;

  @doc("Display Name override for the newly created test.")
  @maxLength(50)
  @minLength(2)
  displayName?: string;

  @doc("Description override for the newly created test.")
  @maxLength(100)
  description?: string;
}

@doc("Represents collection of metric namespaces.")
model MetricNamespaceCollection {
  @doc("The values for the metric namespaces.")
  value: MetricNamespace[];
}

@doc("Metric namespace class specifies the metadata for a metric namespace.")
model MetricNamespace {
  @doc("The namespace description.")
  description?: string;

  @doc("The metric namespace name.")
  name?: string;
}

@doc("Represents collection of metric definitions.")
model MetricDefinitionCollection {
  @doc("the values for the metric definitions.")
  value: MetricDefinition[];
}

@doc("Metric definition")
model MetricDefinition {
  @doc("List of dimensions")
  dimensions?: NameAndDescription[];

  @doc("The metric description")
  description?: string;

  @doc("The metric name")
  name?: string;

  @doc("The namespace the metric belongs to.")
  `namespace`?: string;

  @doc("The primary aggregation type value defining how to use the values for display.")
  primaryAggregationType?: Aggregation;

  @doc("The collection of what all aggregation types are supported.")
  supportedAggregationTypes?: string[];

  @doc("The unit of the metric.")
  unit?: MetricUnit;

  @doc("""
    Metric availability specifies the time grain (aggregation interval or
    frequency).
    """)
  metricAvailabilities?: MetricAvailability[];
}

@doc("The name and description")
model NameAndDescription {
  @doc("The description")
  description?: string;

  @doc("The name")
  name?: string;
}

@doc("Metric availability specifies the time grain (aggregation interval or frequency)")
model MetricAvailability {
  @doc("""
    The time grain specifies the aggregation interval for the metric. Expressed as
    a duration 'PT1M', 'PT1H', etc.
    """)
  timeGrain?: TimeGrain;
}

@doc("Filters to fetch the set of metric.")
model MetricRequestPayload {
  @doc("""
    Get metrics for specific dimension values. Example: Metric contains dimension
    like SamplerName, Error. To retrieve all the time series data where SamplerName
    is equals to HTTPRequest1 or HTTPRequest2, the DimensionFilter value will be
    {\"SamplerName\", [\"HTTPRequest1\", \"HTTPRequest2\"}
    """)
  filters?: DimensionFilter[];
}

@doc("Dimension name and values to filter")
model DimensionFilter {
  @doc("The dimension name")
  name?: string;

  @doc("The dimension values. Maximum values can be 20.")
  values?: string[];
}

@doc("The response to a metrics query.")
// using friendlyName to change the name of the model due to issue in using projectedName '@encodedName("application/json", "Metrics")' https://github.com/microsoft/typespec/issues/2276
model Metrics is Azure.Core.Page<TimeSeriesElement>;

@doc("The time series returned when a data query is performed.")
model TimeSeriesElement {
  @doc("An array of data points representing the metric values.")
  data?: MetricValue[];

  @doc("The dimension values ")
  dimensionValues?: DimensionValue[];
}

@doc("Represents a metric value.")
model MetricValue {
  @doc("The timestamp for the metric value in RFC 3339 format.")
  timestamp?: utcDateTime;

  @doc("The metric value.")
  value?: float64;
}

@doc("Represents a metric dimension value.")
model DimensionValue {
  @doc("The name of the dimension.")
  name?: string;

  @doc("The value of the dimension.")
  value?: string;
}

@doc("Metrics dimension values.")
model DimensionValueList {
  @doc("The dimension name")
  @visibility(Lifecycle.Read)
  @added(APIVersions.v2023_04_01_preview)
  name?: string;

  @doc("The dimension value")
  @pageItems
  value?: string[];

  @doc("Link for the next set of values in case of paginated results, if applicable.")
  @nextLink
  nextLink?: ResourceLocation<DimensionValueList>;
}

@doc("Metric Dimensions")
model MetricDimensionsRequest {
  @doc("Metric name")
  @query
  metricname: string;

  @doc("The interval (i.e. timegrain) of the query.")
  @query
  interval?: TimeGrain = TimeGrain.PT1M;

  @doc("Metric namespace to query metric definitions for.")
  @query
  metricNamespace: string;

  @doc("""
    The timespan of the query. It is a string with the following format 'startDateTime_ISO/endDateTime_ISO'.
    """)
  @query
  timespan: string;
}

@doc("Test run app component")
model TestRunAppComponents {
  @doc("""
    Azure resource collection { resource id (fully qualified resource Id e.g
    subscriptions/{subId}/resourceGroups/{rg}/providers/Microsoft.LoadTestService/loadtests/{resName})
    : resource object } 
    """)
  components: Record<AppComponent>;

  @doc("Test run identifier")
  @visibility(Lifecycle.Read)
  testRunId?: string;

  ...SystemMetaData;
}

@doc("Test run server metrics configuration")
model TestRunServerMetricsConfiguration {
  @doc("Test run identifier")
  @visibility(Lifecycle.Read)
  testRunId?: string;

  @doc("""
    Azure resource metrics collection {metric id : metrics object} (Refer :
    https://learn.microsoft.com/en-us/rest/api/monitor/metric-definitions/list#metricdefinition
    for metric id).
    """)
  metrics?: Record<ResourceMetric>;

  ...SystemMetaData;
}

@doc("Query parameters for list test run operation")
model OldTestRunIdQueryParam {
  @doc("""
    Existing test run identifier that should be rerun, if this is provided, the
    test will run with the JMX file, configuration and app components from the
    existing test run. You can override the configuration values for new test run
    in the request body.
    """)
  @query
  oldTestRunId?: string;
}

@doc("Parameters for list test run operation")
model ListTestRunQueryParams {
  @doc("""
    Sort on the supported fields in (field asc/desc) format. eg: executedDateTime
    asc. Supported fields - executedDateTime
    """)
  @query
  orderby?: string;

  @doc("""
    Prefix based, case sensitive search on searchable fields - description,
    executedUser. For example, to search for a test run, with description 500 VUs,
    the search parameter can be 500.
    """)
  @query
  search?: string;

  @doc("Unique name of an existing load test.")
  @query
  testId?: string;

  @doc("Start DateTime(RFC 3339 literal format) of test-run execution time filter range.")
  @query
  executionFrom?: utcDateTime;

  @doc("End DateTime(RFC 3339 literal format) of test-run execution time filter range.")
  @query
  executionTo?: utcDateTime;

  @doc("Comma separated list of test run status.")
  @query
  status?: string;

  @doc("Number of results in response.")
  @query
  maxpagesize?: int32 = 50;

  @doc("Comma separated list of type of entities that have created the test run.")
  @query(#{ explode: false })
  @added(APIVersions.v2024_07_01_preview)
  createdByTypes?: string[];

  @doc("Comma-separated list of test IDs. If you are using testIds, do not send a value for testId.")
  @query(#{ explode: false })
  @added(APIVersions.v2025_03_01_preview)
  testIds?: string[];
}

@doc("Parameters for list test operation")
model ListTestQueryParams {
  @doc("""
    Sort on the supported fields in (field asc/desc) format. eg:
    lastModifiedDateTime asc. Supported fields - lastModifiedDateTime
    """)
  @query
  orderby?: string;

  @doc("""
    Prefix based, case sensitive search on searchable fields - displayName,
    createdBy. For example, to search for a test, with display name is Login Test,
    the search parameter can be Login.
    """)
  @query
  search?: string;

  @doc("""
    Start DateTime(RFC 3339 literal format) of the last updated time range to filter tests.
    """)
  @query
  lastModifiedStartTime?: utcDateTime;

  @doc("""
    End DateTime(RFC 3339 literal format) of the last updated time range to filter tests.
    """)
  @query
  lastModifiedEndTime?: utcDateTime;

  @doc("Number of results in response.")
  @query
  maxpagesize?: int32 = 50;
}

@doc("System metadata.")
model SystemMetaData {
  @doc("The creation datetime(RFC 3339 literal format).")
  @visibility(Lifecycle.Read)
  createdDateTime?: utcDateTime;

  @doc("The user that created.")
  @visibility(Lifecycle.Read)
  createdBy?: string;

  @doc("The last Modified datetime(RFC 3339 literal format).")
  @visibility(Lifecycle.Read)
  lastModifiedDateTime?: utcDateTime;

  @doc("The user that last modified.")
  @visibility(Lifecycle.Read)
  lastModifiedBy?: string;
}

@doc("Test Id path parameter.")
model TestIdPathParameter {
  @doc("Unique test identifier for the load test, must contain only lower-case alphabetic, numeric, underscore or hyphen characters.")
  @maxLength(50)
  @minLength(2)
  @key
  @visibility(Lifecycle.Read)
  @pattern("^[a-z0-9_-]*$")
  testId: string;
}

@doc("Test run Id path parameter.")
model TestRunIdPathParameter {
  @doc("Unique test run identifier for the load test run, must contain only lower-case alphabetic, numeric, underscore or hyphen characters.")
  @visibility(Lifecycle.Read)
  @maxLength(50)
  @minLength(2)
  @key
  @pattern("^[a-z0-9_-]*$")
  testRunId: string;
}

@added(APIVersions.v2024_05_01_preview)
@doc("Request data collection level for test run")
union RequestDataLevel {
  string,

  @doc("No request data will be collected")
  NONE: "NONE",

  @doc("Request data will be collected in case of failed requests")
  ERRORS: "ERRORS",
}

@added(APIVersions.v2025_03_01_preview)
@doc("Kind of the long running operation.")
union OperationKind {
  string,

  @doc("Operation represents a clone test operation")
  CloneTest: "CloneTest",

  @doc("Operation represents a test run insights generation operation")
  GenerateTestRunInsights: "GenerateTestRunInsights",
}

@added(APIVersions.v2025_03_01_preview)
@doc("Status of a long running operation.")
@resource("operations")
model OperationStatus {
  @added(APIVersions.v2025_03_01_preview)
  @doc("The unique ID of the operation.")
  @key("operationId")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The state of the operation.")
  status: Foundations.OperationState;

  @doc("The kind of the operation.")
  kind: OperationKind;

  @doc("Error object that describes the error when status is \"Failed\".")
  error?: Foundations.Error;
}

alias ResourceCreatedResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<201> &
  T;

alias ResourceCreatedOrOkResponse<T extends TypeSpec.Reflection.Model> = ResourceCreatedResponse<T> | (TypeSpec.Http.Response<200> &
  T);
