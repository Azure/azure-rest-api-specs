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

@doc("Azure for Operators 5G Core Observability Service Resource")
@resource("observabilityServices")
model ObservabilityServiceResource
  is TrackedResource<ObservabilityServiceResourceProperties> {
  @doc("The name of the Observability Service")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("observabilityServiceName")
  @path
  @segment("observabilityServices")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;
}

@doc("Observability Service Properties.")
model ObservabilityServiceResourceProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Azure for Operators 5G Core Observability component parameters.  One set per component type")
  @identifiers(#["type"])
  componentParameters: QualifiedComponentDeploymentParameters[];

  @doc("Reference to cluster where the observability components are deployed")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  clusterService: ClusterServiceIdProperty;

  @doc("Release version. This is inherited from the cluster")
  @visibility(Lifecycle.Read)
  releaseVersion?: ReleaseVersion;

  @doc("Operational status")
  @visibility(Lifecycle.Read)
  operationalStatus?: OperationalStatus;
}

@armResourceOperations(ObservabilityServiceResource)
interface ObservabilityServices {
  get is ArmResourceRead<ObservabilityServiceResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<ObservabilityServiceResource>;
  updateTags is ArmTagsPatchSync<ObservabilityServiceResource>;
  delete is ArmResourceDeleteWithoutOkAsync<ObservabilityServiceResource>;
  @doc("List all Observability Services by Resource Group.")
  listByResourceGroup is ArmResourceListByParent<ObservabilityServiceResource>;
  @doc("List all Observability Services by Subscription ID.")
  listBySubscription is ArmListBySubscription<ObservabilityServiceResource>;
}
