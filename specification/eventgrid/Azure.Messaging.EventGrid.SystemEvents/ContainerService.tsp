/** Describes the schema of the Azure Kubernetes Service events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent */
namespace Microsoft.EventGrid.SystemEvents;

/** Schema of the Data property of an EventGridEvent for a Microsoft.ContainerService.NewKubernetesVersionAvailable event */
model ContainerServiceNewKubernetesVersionAvailableEventData {
  /** The highest PATCH Kubernetes version for the highest MINOR version supported by ManagedCluster resource */
  latestSupportedKubernetesVersion?: string;

  /** The highest PATCH Kubernetes version for the MINOR version considered stable for the ManagedCluster resource */
  latestStableKubernetesVersion?: string;

  /** The highest PATCH Kubernetes version for the lowest applicable MINOR version available for the ManagedCluster resource */
  lowestMinorKubernetesVersion?: string;

  /** The highest PATCH Kubernetes version considered preview for the ManagedCluster resource. There might not be any version in preview at the time of publishing the event */
  latestPreviewKubernetesVersion?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ContainerService.ClusterSupportEnded event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model ContainerServiceClusterSupportEndedEventData
  extends ContainerServiceClusterSupportEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ContainerService.ClusterSupportEnding event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model ContainerServiceClusterSupportEndingEventData
  extends ContainerServiceClusterSupportEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ContainerService.NodePoolRollingStarted event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model ContainerServiceNodePoolRollingStartedEventData
  extends ContainerServiceNodePoolRollingEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ContainerService.NodePoolRollingSucceeded event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model ContainerServiceNodePoolRollingSucceededEventData
  extends ContainerServiceNodePoolRollingEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ContainerService.NodePoolRollingFailed event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model ContainerServiceNodePoolRollingFailedEventData
  extends ContainerServiceNodePoolRollingEventData {}

/** Schema of common properties of cluster support events */
model ContainerServiceClusterSupportEventData {
  /** The Kubernetes version of the ManagedCluster resource */
  kubernetesVersion?: string;
}

/** Schema of common properties of node pool rolling events */
model ContainerServiceNodePoolRollingEventData {
  /** The name of the node pool in the ManagedCluster resource */
  nodePoolName?: string;
}
