import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "./Job.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

// Define the main model
@doc("Represents the properties of a child job within the Resiliency Hub.")
@removed(Versions.v2026_04_01_preview)
@discriminator("jobType")
model ChildJobProperties {
  ...BaseJobProperties;

  @doc("The unique identifier of the parent job under which this child job exists.")
  @visibility(Lifecycle.Read)
  parentJobId?: armResourceIdentifier;

  @doc("The unique identifier of the task within the parent job for which this child job is created.")
  @visibility(Lifecycle.Read)
  parentJobTaskId?: string;

  @doc("The friendly name of the task within the parent job for which this child job is created.")
  @visibility(Lifecycle.Read)
  parentJobTaskName?: string;

  @doc("The resource identifier of the parent job's job resource for which this child job is created.")
  @visibility(Lifecycle.Read)
  parentJobResourceId?: armResourceIdentifier;

  @doc("The retry count of the task within the parent job for which this child job is created.")
  @visibility(Lifecycle.Read)
  parentJobRetryAttempt?: int32;

  @doc("The discriminator for the Job Type hierarchy.")
  jobType: JobType;
}
