import "@typespec/openapi";

import "../common/CommonModels.tsp";

using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Observability Service Properties.")
model ObservabilityServiceResourceProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Azure for Operators 5G Core Observability component parameters.  One set per component type")
  @extension("x-ms-identifiers", #["type"])
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
