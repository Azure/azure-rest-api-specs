import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../common/common.tsp";
import "../common/Job.tsp";
import "../common/ChildJob.tsp";
import "./drillRun.models.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

/**
 * Resource definition for the ChaosJob-ChildJob resource.
 * This resource represents a child job of a Chaos Job in the Azure Resilience Management provider namespace.
 */
@parentResource(ChaosJob)
@doc("Chaos job Child job a AzureResilienceProviderHub resource")
model ChaosJobChildJob is ProxyResource<ChaosJobChildJobProperties> {
  @doc("The unique name (Guid) of the Chaos job child job")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @key("chaosJobChildJobName")
  @segment("chaosJobChildJobs")
  @path
  name: string;
}

@doc("Definition of Chaos job child job properties.")
model ChaosJobChildJobProperties extends ChildJobProperties {
  @doc("Discriminator for the Job Type hierarchy.")
  jobType: JobType.ChaosExperimentChild;

  @doc("The provisioning state of the recovery child job.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
