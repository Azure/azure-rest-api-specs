import "@typespec/openapi";
import "@typespec/versioning";

import "../common/CommonModels.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MobileNetwork;

@added(Versions.v2024_05_15_preview)
@doc("SDM Deployment Properties.")
model SdmDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Azure for Operators 5G Core Subscriber Data Management component parameters.  One set per component type")
  @extension("x-ms-identifiers", ["type"])
  componentParameters: QualifiedComponentDeploymentParameters[];

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
