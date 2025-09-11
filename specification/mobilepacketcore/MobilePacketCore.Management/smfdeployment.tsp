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

@doc("Azure for Operators 5G Core Session Management Function (SMF) Deployment Resource")
@resource("smfDeployments")
model SmfDeploymentResource
  is TrackedResource<SmfDeploymentResourceProperties> {
  @doc("The name of the SMF Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("smfDeploymentName")
  @path
  @segment("smfDeployment")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;
}

@doc("SMF Deployment Properties.")
model SmfDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Azure for Operators 5G Core SMF component parameters")
  componentParameters?: ComponentDeploymentParameters;

  @doc("Azure for Operators 5G Core SMF secrets parameters")
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

@armResourceOperations(SmfDeploymentResource)
interface SmfDeployments {
  get is ArmResourceRead<SmfDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<SmfDeploymentResource>;
  updateTags is ArmTagsPatchSync<SmfDeploymentResource>;
  delete is ArmResourceDeleteWithoutOkAsync<SmfDeploymentResource>;
  @doc("List all Session Management Function Deployments by Resource Group.")
  listByResourceGroup is ArmResourceListByParent<SmfDeploymentResource>;
  @doc("List all Session Management Function Deployments by Subscription ID.")
  listBySubscription is ArmListBySubscription<SmfDeploymentResource>;
}
