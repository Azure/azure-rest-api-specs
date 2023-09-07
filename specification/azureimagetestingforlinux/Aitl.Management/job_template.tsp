namespace Microsoft.AzureImageTestingForLinux;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Autorest;
using Azure.Core;
using Azure.Core.Foundations;
using OpenAPI;

@doc("A template defining the parameters for a test job.")
model JobTemplate is TrackedResource<JobTemplateResourceProperties> {
  @doc("Job template name")
  @pattern("^[a-zA-Z0-9-_]{3,60}$")
  @key("jobTemplateName")
  @segment("jobTemplates")
  @visibility("read")
  @path
  name: string;
}

@doc("The job template properties")
model JobTemplateResourceProperties is ResourceProperties {
  @doc("Tags used to organized templates.")
  templateTags: string[];

  @doc("Azure region to run test in.")
  region: string[];

  @doc("VM sizes to run test on.")
  vmSize: string[];

  @doc("Test Selections. Default is to run the smoke_test case")
  selections?: Selections[];

  @doc("Custom parameters for different test cases")
  customParameters?: Record<string>;

  @doc("The number of concurrent environments. Default is 4.")
  concurrency?: int32 = 4;
}

@doc("Action to take on a particular test case")
enum TestCaseAction {
  @doc("Include test case")
  include,

  @doc("Exclude test case")
  exclude,

  @doc("Force include test case")
  forceInclude,

  @doc("Force exclude test case")
  forceExclude,
}

@minValue(0)
@maxValue(4)
scalar CasePriorityLevel extends int32;

@doc("Details test case criteria")
model Selections {
  @doc("Test case name. Default is empty.")
  caseName?: string[] = [];

  @doc("Test case area. Default is empty.")
  caseArea?: string[] = [];

  @doc("Test case category. Default is empty.")
  caseCategory?: string[] = [];

  @doc("Test case priority. Default is empty and represents all priorities. Valid values are from 0-4")
  casePriority?: CasePriorityLevel[] = [];

  @doc("Test case tags. Default empty")
  caseTags?: string[] = [];

  @doc("Action to take. Default is include")
  action?: TestCaseAction = TestCaseAction.include;

  @doc("Test iterations to run. Default 1")
  testIterations?: int32 = 1;

  @doc("Retry on failure. Default 0")
  retryCount?: int32 = 0;

  @doc("Use new environment for each test case. Default false")
  useNewEnvironment?: boolean = false;

  @doc("Ignore failed test cases. Default false")
  ignoreFailure?: boolean = false;
}

@doc("JobTemplate operations.")
@armResourceOperations(JobTemplate)
interface JobTemplates {
  listByResourceGroup is ArmResourceListByParent<JobTemplate>;
  listbySubscription is ArmListBySubscription<JobTemplate>;
  get is ArmResourceRead<JobTemplate>;
  createOrUpdate is ArmResourceCreateOrUpdateSyncCompliant<JobTemplate>;
  update is ArmResourcePatchSync<JobTemplate, JobTemplateResourceProperties>;
  delete is ArmResourceDeleteSync<JobTemplate>;
}
