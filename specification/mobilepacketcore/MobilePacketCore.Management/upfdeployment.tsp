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

@doc("Azure for Operators 5G Core User Plane Function (UPF) Deployment Resource")
@resource("upfDeployments")
model UpfDeploymentResource
  is TrackedResource<UpfDeploymentResourceProperties> {
  @doc("The name of the UPF Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("upfDeploymentName")
  @path
  @segment("upfDeployments")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;
}

@doc("UPF Deployment Properties.")
model UpfDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Azure for Operators 5G Core UPF component parameters")
  componentParameters: ComponentDeploymentParameters;

  @doc("Azure for Operators 5G Core F secrets parameters")
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

@armResourceOperations(UpfDeploymentResource)
interface UpfDeployments {
  get is ArmResourceRead<UpfDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<UpfDeploymentResource>;
  updateTags is ArmTagsPatchSync<UpfDeploymentResource>;
  delete is ArmResourceDeleteWithoutOkAsync<UpfDeploymentResource>;
  @doc("List all User Plane Function Deployments by Resource ID.")
  listByResourceGroup is ArmResourceListByParent<UpfDeploymentResource>;
  @doc("List all User Plane Function Deployments by Subscription ID.")
  listBySubscription is ArmListBySubscription<UpfDeploymentResource>;
}
