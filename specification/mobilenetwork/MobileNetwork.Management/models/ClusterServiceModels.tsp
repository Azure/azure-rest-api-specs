import "@typespec/openapi";

import "../common/CommonModels.tsp";

using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Cluster Service Properties.")
model ClusterServiceResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Cluster type (Lab or Production)")
  @visibility("create", "read")
  deploymentType: SkuDeploymentType;

  @doc("Azure for Operators 5G Core Release Version.  This is applied to all platform as a service (PaaS) components and running workloads in this cluster")
  releaseVersion: ReleaseVersion;

  @doc("Cluster type specific data.  Contents depend on the cluster type")
  clusterTypeSpecificData: ClusterServiceClusterTypeSpecificData;

  @doc("Azure for Operators 5G Core Local PaaS component parameters.  One set per component type")
  @extension("x-ms-identifiers", ["type"])
  componentParameters: QualifiedComponentDeploymentParameters[];

  @doc("Operational status")
  @visibility("read")
  operationalStatus?: OperationalStatus;
}

@doc("Cluster Service cluster type specific data.")
@discriminator("type")
model ClusterServiceClusterTypeSpecificData {
  @doc("Cluster Type")
  type: ClusterType;

  @doc("Custom Location resource ID")
  customLocationId: CustomLocationIdProperty;
}

@doc("AKS Cluster specific data.")
model ClusterServiceAksClusterData
  extends ClusterServiceClusterTypeSpecificData {
  @doc("Azure Kubernetes Service Properties.")
  type: ClusterType.Aks;
}

@doc("Nexus AKS Cluster specific data.")
model ClusterServiceNexusAksClusterData
  extends ClusterServiceClusterTypeSpecificData {
  @doc("Nexus Operator Kubenetes Service Properties.")
  type: ClusterType.NexusAks;
}
