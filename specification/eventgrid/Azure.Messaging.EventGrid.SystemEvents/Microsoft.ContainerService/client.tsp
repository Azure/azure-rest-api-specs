import "@azure-tools/typespec-client-generator-core"; 
 
using Azure.ClientGenerator.Core; 
//Models 
@@usage(Microsoft.EventGrid.SystemEvents.ContainerServiceNewKubernetesVersionAvailableEventData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ContainerServiceNewKubernetesVersionAvailableEventData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ContainerServiceClusterSupportEndedEventData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ContainerServiceClusterSupportEndedEventData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ContainerServiceClusterSupportEndingEventData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ContainerServiceClusterSupportEndingEventData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ContainerServiceNodePoolRollingStartedEventData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ContainerServiceNodePoolRollingStartedEventData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ContainerServiceNodePoolRollingSucceededEventData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ContainerServiceNodePoolRollingSucceededEventData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ContainerServiceNodePoolRollingFailedEventData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ContainerServiceNodePoolRollingFailedEventData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ContainerServiceClusterSupportEventData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ContainerServiceClusterSupportEventData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.ContainerServiceNodePoolRollingEventData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.ContainerServiceNodePoolRollingEventData, Access.public);
//Enums 
