import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using OpenAPI;

namespace Microsoft.MobilePacketCore;

@doc("Azure for Operators 5G Core Network Repository Function (NRF) Deployment Resource")
@resource("nrfDeployments")
model NrfDeploymentResource
  is TrackedResource<NrfDeploymentResourceProperties> {
  @doc("The name of the NrfDeployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("nrfDeploymentName")
  @path
  @segment("nrfDeployments")
  @visibility("create", "read")
  name: string;
}

@doc("NRF Deployment Properties.")
model NrfDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Azure for Operators 5G Core NRF component parameters")
  componentParameters?: ComponentDeploymentParameters;

  @doc("Azure for Operators 5G Core NRF secrets parameters")
  @secret
  secretsParameters?: ComponentDeploymentSecrets;

  @doc("Reference to cluster where the Network Function is deployed")
  @visibility("create", "read")
  clusterService: ClusterServiceIdProperty;

  @doc("Release version. This is inherited from the cluster")
  @visibility("read")
  releaseVersion?: ReleaseVersion;

  @doc("Operational status")
  @visibility("read")
  operationalStatus?: OperationalStatus;
}

@armResourceOperations(NrfDeploymentResource)
interface NrfDeployments {
  get is ArmResourceRead<NrfDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<NrfDeploymentResource>;
  updateTags is ArmTagsPatchSync<NrfDeploymentResource>;
  delete is ArmResourceDeleteWithoutOkAsync<NrfDeploymentResource>;
  @doc("List all Network Repository Function Deployments by Resource Group.")
  listByResourceGroup is ArmResourceListByParent<NrfDeploymentResource>;
  @doc("List all Network Repository Function Deployments by Subscription ID.")
  listBySubscription is ArmListBySubscription<NrfDeploymentResource>;
}
