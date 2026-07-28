import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../common/common.tsp";
import "../common/Job.tsp";
import "../common/ChildJob.tsp";
import "./drillRun.models.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
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
@removed(Versions.v2026_04_01_preview)
model ChaosJob is ProxyResource<ChaosJobProperties> {
  @doc("The unique name of the chaos job (GUID).")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @key("chaosJobName")
  @segment("chaosJobs")
  @path
  name: string;
}

@doc("Definition of Chaos job properties.")
@removed(Versions.v2026_04_01_preview)
model ChaosJobProperties extends JobProperties {
  @doc("Discriminator for the Job Type hierarchy.")
  jobType: JobType.ChaosExperiment;

  @doc("The provisioning state of the recovery child job.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
