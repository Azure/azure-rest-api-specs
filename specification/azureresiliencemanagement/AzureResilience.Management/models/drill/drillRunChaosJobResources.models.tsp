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
 * Resource definition for the Chaos job Resources.
 */
@doc("Represents a chaos job resource in the Azure Resilience Management provider namespace.")
@parentResource(ChaosJob)
model ChaosJobResource is ProxyResource<ChaosJobResourceProperties> {
  @doc("The unique name (GUID) of the chaos job resource.")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @key("chaosJobResourceName")
  @segment("chaosJobResources")
  @path
  name: string;
}

@doc("Properties of a Chaos job resource.")
model ChaosJobResourceProperties extends JobResourceProperties {
  @doc("Discriminator for the Job object hierarchy.")
  jobResourceType: JobResourceType.ChaosExperiment;

  @doc("The provisioning state of the Drill Run Resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
