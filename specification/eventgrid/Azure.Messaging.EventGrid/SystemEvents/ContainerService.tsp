@doc("Describes the schema of the Azure Kubernetes Service events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent")
namespace EventGrid;

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.ContainerService.NewKubernetesVersionAvailable event")
model ContainerServiceNewKubernetesVersionAvailableEventData {
  @doc("The highest PATCH Kubernetes version for the highest MINOR version supported by ManagedCluster resource")
  latestSupportedKubernetesVersion?: string;

  @doc("The highest PATCH Kubernetes version for the MINOR version considered stable for the ManagedCluster resource")
  latestStableKubernetesVersion?: string;

  @doc("The highest PATCH Kubernetes version for the lowest applicable MINOR version available for the ManagedCluster resource")
  lowestMinorKubernetesVersion?: string;

  @doc("The highest PATCH Kubernetes version considered preview for the ManagedCluster resource. There might not be any version in preview at the time of publishing the event")
  latestPreviewKubernetesVersion?: string;
}

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.ContainerService.ClusterSupportEnded event")
model ContainerServiceClusterSupportEndedEventData
  extends ContainerServiceClusterSupportEventData {}

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.ContainerService.ClusterSupportEnding event")
model ContainerServiceClusterSupportEndingEventData
  extends ContainerServiceClusterSupportEventData {}

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.ContainerService.NodePoolRollingStarted event")
model ContainerServiceNodePoolRollingStartedEventData
  extends ContainerServiceNodePoolRollingEventData {}

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.ContainerService.NodePoolRollingSucceeded event")
model ContainerServiceNodePoolRollingSucceededEventData
  extends ContainerServiceNodePoolRollingEventData {}

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.ContainerService.NodePoolRollingFailed event")
model ContainerServiceNodePoolRollingFailedEventData
  extends ContainerServiceNodePoolRollingEventData {}

@doc("Schema of common properties of cluster support events")
model ContainerServiceClusterSupportEventData {
  @doc("The Kubernetes version of the ManagedCluster resource")
  kubernetesVersion?: string;
}

@doc("Schema of common properties of node pool rolling events")
model ContainerServiceNodePoolRollingEventData {
  @doc("The name of the node pool in the ManagedCluster resource")
  nodePoolName?: string;
}
