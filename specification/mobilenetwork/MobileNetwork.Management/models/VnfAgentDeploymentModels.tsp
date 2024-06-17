import "@typespec/versioning";

import "../common/CommonModels.tsp";

using TypeSpec.Versioning;

namespace Microsoft.MobileNetwork;

@added(Versions.v2024_05_15_preview)
@doc("Virtual Network Function (VNF) Agent Deployment Properties.")
model VnfAgentDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Azure for Operators 5G Core Virtual Network Function (VNF) Agent component parameters")
  componentParameters?: ComponentDeploymentParameters;

  @doc("Azure for Operators 5G Core Virtual Network Function (VNF) Agent secrets parameters")
  @visibility("create", "update")
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

  @doc("Associated Virtual Network Function resource identifiers")
  @visibility("read")
  associatedVirtualNetworkFunctions?: AssociatedVirtualNetworkFunctionIdProperty[];
}
