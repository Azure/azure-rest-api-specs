import "./ContainerServiceExample.tsp";

/** Describes the schema of the Azure Kubernetes Service events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent */
namespace Microsoft.EventGrid.SystemEvents;

/** Schema of the Data property of an EventGridEvent for a Microsoft.ContainerService.NewKubernetesVersionAvailable event */
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
@example(MicrosoftContainerServiceNewKubernetesVersionAvailableExample)
model ContainerServiceNewKubernetesVersionAvailableEventData {
  /** The highest PATCH Kubernetes version for the highest MINOR version supported by ManagedCluster resource */
  latestSupportedKubernetesVersion: string;

  /** The highest PATCH Kubernetes version for the MINOR version considered stable for the ManagedCluster resource */
  latestStableKubernetesVersion: string;

  /** The highest PATCH Kubernetes version for the lowest applicable MINOR version available for the ManagedCluster resource */
  lowestMinorKubernetesVersion: string;

  /** The highest PATCH Kubernetes version considered preview for the ManagedCluster resource. There might not be any version in preview at the time of publishing the event */
  latestPreviewKubernetesVersion?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ContainerService.ClusterSupportEnded event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
@example(MicrosoftContainerServiceClusterSupportEndedExample)
model ContainerServiceClusterSupportEndedEventData
  extends ContainerServiceClusterSupportEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ContainerService.ClusterSupportEnding event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
@example(MicrosoftContainerServiceClusterSupportEndingExample)
model ContainerServiceClusterSupportEndingEventData
  extends ContainerServiceClusterSupportEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ContainerService.NodePoolRollingStarted event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
@example(MicrosoftContainerServiceNodePoolRollingStartedExample)
model ContainerServiceNodePoolRollingStartedEventData
  extends ContainerServiceNodePoolRollingEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ContainerService.NodePoolRollingSucceeded event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
@example(MicrosoftContainerServiceNodePoolRollingSucceededExample)
model ContainerServiceNodePoolRollingSucceededEventData
  extends ContainerServiceNodePoolRollingEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.ContainerService.NodePoolRollingFailed event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
@example(MicrosoftContainerServiceNodePoolRollingFailedExample)
model ContainerServiceNodePoolRollingFailedEventData
  extends ContainerServiceNodePoolRollingEventData {}

/** Schema of common properties of cluster support events */
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ContainerServiceClusterSupportEventData {
  /** The Kubernetes version of the ManagedCluster resource */
  kubernetesVersion: string;
}

/** Schema of common properties of node pool rolling events */
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
model ContainerServiceNodePoolRollingEventData {
  /** The name of the node pool in the ManagedCluster resource */
  nodePoolName: string;
}
