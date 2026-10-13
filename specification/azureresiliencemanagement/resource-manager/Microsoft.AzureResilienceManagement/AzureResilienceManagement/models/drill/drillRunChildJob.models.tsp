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
 * Resource definition for the DrillRunChildJob resource.
 * This resource represents a child job of a Drill Run in the Azure Resilience Management provider namespace.
 */
@parentResource(DrillRun)
@doc("DrillRun Child Job a AzureResilienceProviderHub resource")
@removed(Versions.v2026_04_01_preview)
model DrillRunChildJob is ProxyResource<DrillRunChildJobProperties> {
  @doc("The unique name (Guid) of the DrillRun child job")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @key("drillRunChildJobName")
  @segment("drillRunChildJobs")
  @path
  name: string;
}

@doc("Definition of Drill Run child job properties.")
@removed(Versions.v2026_04_01_preview)
model DrillRunChildJobProperties extends ChildJobProperties {
  @doc("Discriminator for the Job Type hierarchy.")
  jobType: JobType.DrillRunChild;

  @doc("The provisioning state of the recovery child job.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
