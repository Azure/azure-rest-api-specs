import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "./Job.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

// Define the main model
@doc("Definition of job-resource.")
@discriminator("jobResourceType")
model JobResourceProperties {
  ...BaseJobProperties;

  @doc("Id of the Job under which this job-resource exists.")
  @visibility(Lifecycle.Read)
  jobId?: string;

  @doc("Id of the job-task to which this job resource is associated.")
  @visibility(Lifecycle.Read)
  taskId?: string;

  @doc("Friendly name of the job-task to which this job resource is associated.")
  @visibility(Lifecycle.Read)
  taskName?: string;

  @doc("Discriminator for the JobResource object hierarchy.")
  jobResourceType: JobResourceType;

  @doc("A setting that indicates the protection solution selected.")
  protectionSolutionType: ResourceProtectionSolutionType;
}
