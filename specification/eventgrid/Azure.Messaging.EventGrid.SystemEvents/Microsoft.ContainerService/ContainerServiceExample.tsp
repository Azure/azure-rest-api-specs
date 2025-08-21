import "./ContainerService.tsp";
namespace Microsoft.EventGrid.SystemEvents;

const MicrosoftContainerServiceNewKubernetesVersionAvailableExample: ContainerServiceNewKubernetesVersionAvailableEventData = #{
  latestSupportedKubernetesVersion: "1.20.7",
  latestStableKubernetesVersion: "1.19.11",
  lowestMinorKubernetesVersion: "1.18.19",
  latestPreviewKubernetesVersion: "1.21.1",
};

const MicrosoftContainerServiceClusterSupportEndedExample: ContainerServiceClusterSupportEndedEventData = #{
  kubernetesVersion: "1.23.15",
};

const MicrosoftContainerServiceClusterSupportEndingExample: ContainerServiceClusterSupportEndingEventData = #{
  kubernetesVersion: "1.24.10",
};

const MicrosoftContainerServiceNodePoolRollingStartedExample: ContainerServiceNodePoolRollingStartedEventData = #{
  nodePoolName: "nodepool1",
};

const MicrosoftContainerServiceNodePoolRollingSucceededExample: ContainerServiceNodePoolRollingSucceededEventData = #{
  nodePoolName: "nodepool1",
};

const MicrosoftContainerServiceNodePoolRollingFailedExample: ContainerServiceNodePoolRollingFailedEventData = #{
  nodePoolName: "nodepool1",
};
