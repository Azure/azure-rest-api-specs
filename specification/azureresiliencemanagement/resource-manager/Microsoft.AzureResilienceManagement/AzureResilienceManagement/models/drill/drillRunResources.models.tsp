import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../common/common.tsp";
import "../common/Job.tsp";
import "../common/JobResource.tsp";
import "./drillRun.models.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

/**
 * Resource definition for the DrillRun Resources.
 */
@doc("Represents a Drill Run job resource in the Azure Resilience Management provider namespace.")
@parentResource(DrillRun)
model DrillRunResource is ProxyResource<DrillRunResourceProperties> {
  @doc("The unique name (GUID) of the recovery job resource.")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @key("drillRunResourceName")
  @segment("drillRunResources")
  @path
  name: string;
}

@doc("Properties of a Drill Run resource.")
model DrillRunResourceProperties extends JobResourceProperties {
  @doc("Discriminator for the Job object hierarchy.")
  jobResourceType: JobResourceType.DrillRun;

  @doc("The provisioning state of the Drill Run Resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
