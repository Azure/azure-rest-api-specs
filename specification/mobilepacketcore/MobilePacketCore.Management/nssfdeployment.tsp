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

@doc("Azure for Operators 5G Core Network Slice Selection Function (NSSF) Deployment Resource")
@resource("nssfDeployments")
model NssfDeploymentResource
  is TrackedResource<NssfDeploymentResourceProperties> {
  @doc("The name of the NSSF Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("nssfDeploymentName")
  @path
  @segment("nssfDeployments")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;
}

@doc("NSSF Deployment Properties.")
model NssfDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Azure for Operators 5G Core NSSF component parameters")
  componentParameters?: ComponentDeploymentParameters;

  @doc("Azure for Operators 5G Core NSSF secrets parameters")
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  secretsParameters?: ComponentDeploymentSecrets;

  @doc("Reference to cluster where the Network Function is deployed")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  clusterService: ClusterServiceIdProperty;

  @doc("Release version. This is inherited from the cluster")
  @visibility(Lifecycle.Read)
  releaseVersion?: ReleaseVersion;

  @doc("Operational status")
  @visibility(Lifecycle.Read)
  operationalStatus?: OperationalStatus;
}

@armResourceOperations(NssfDeploymentResource)
interface NssfDeployments {
  get is ArmResourceRead<NssfDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<NssfDeploymentResource>;
  updateTags is ArmTagsPatchSync<NssfDeploymentResource>;
  delete is ArmResourceDeleteWithoutOkAsync<NssfDeploymentResource>;
  @doc("List all Network Slice Selection Function Deployments by Resource Group.")
  listByResourceGroup is ArmResourceListByParent<NssfDeploymentResource>;
  @doc("List all Network Slice Selection Function Deployments by Subscription ID.")
  listBySubscription is ArmListBySubscription<NssfDeploymentResource>;
}
