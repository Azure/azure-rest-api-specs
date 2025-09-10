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
 * Resource definition for the DrillRun Chaos job resource.
 * This resource represents a child job of a Drill Run, corresponding to the Chaos stage.
 */
@parentResource(DrillRun)
@doc("ChaosJob a AzureResilienceProviderHub resource")
model ChaosJob is ProxyResource<ChaosJobProperties> {
  @doc("The unique name of the chaos job (GUID).")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @key("chaosJobName")
  @segment("chaosJobs")
  @path
  name: string;
}

@doc("Definition of Chaos job properties.")
model ChaosJobProperties extends JobProperties {
  @doc("Discriminator for the Job Type hierarchy.")
  jobType: JobType.ChaosExperiment;

  @doc("The provisioning state of the recovery child job.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
