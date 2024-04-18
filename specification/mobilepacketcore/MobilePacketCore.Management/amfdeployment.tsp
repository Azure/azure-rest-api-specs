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

@doc("Azure for Operators 5G Core Access and Mobility Function (AMF) Deployment Resource")
@resource("amfDeployments")
model AmfDeploymentResource
  is TrackedResource<AmfDeploymentResourceProperties> {
  @doc("The name of the AMF Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("amfDeploymentName")
  @path
  @segment("amfDeployments")
  @visibility("create", "read")
  name: string;
}

@doc("AMF Deployment Properties.")
model AmfDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Azure for Operators 5G Core AMF component parameters")
  componentParameters?: ComponentDeploymentParameters;

  @doc("Azure for Operators 5G Core AMF secrets parameters")
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

@armResourceOperations(AmfDeploymentResource)
interface AmfDeployments {
  get is ArmResourceRead<AmfDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<AmfDeploymentResource>;
  updateTags is ArmTagsPatchSync<AmfDeploymentResource>;
  delete is ArmResourceDeleteWithoutOkAsync<AmfDeploymentResource>;
  @doc("List all Access and Mobility Function Deployments by Resource Group.")
  listByResourceGroup is ArmResourceListByParent<AmfDeploymentResource>;
  @doc("List all Access and Mobility Function Deployments by Subscription ID.")
  listBySubscription is ArmListBySubscription<AmfDeploymentResource>;
}
