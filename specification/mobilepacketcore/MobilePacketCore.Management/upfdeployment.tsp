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
  @doc("The name of the UpfDeployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("upfDeploymentName")
  @path
  @segment("upfDeployments")
  @visibility("create", "read")
  name: string;
}

@doc("UPF Deployment Properties.")
model UpfDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Azure for Operators 5G Core UPF component parameters")
  componentParameters: ComponentDeploymentParameters;

  @doc("Azure for Operators 5G Core F secrets parameters")
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
