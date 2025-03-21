import "@typespec/versioning";

import "../common/CommonModels.tsp";

using TypeSpec.Versioning;

namespace Microsoft.MobileNetwork;

@added(Versions.v2024_05_15_preview)
@doc("Virtual Network Function (VNF) Agent Deployment Properties.")
model VnfAgentDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Azure for Operators 5G Core Virtual Network Function (VNF) Agent component parameters")
  componentParameters?: ComponentDeploymentParameters;

  @doc("Azure for Operators 5G Core Virtual Network Function (VNF) Agent secrets parameters")
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

  @doc("Associated Virtual Network Function resource identifiers")
  @visibility(Lifecycle.Read)
  associatedVirtualNetworkFunctions?: AssociatedVirtualNetworkFunctionIdProperty[];
}
