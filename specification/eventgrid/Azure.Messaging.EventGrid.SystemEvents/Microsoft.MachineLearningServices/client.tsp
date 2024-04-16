import "@azure-tools/typespec-client-generator-core"; 
 
using Azure.ClientGenerator.Core; 
//Models 
@@usage(Microsoft.EventGrid.SystemEvents.MachineLearningServicesModelRegisteredEventData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.MachineLearningServicesModelRegisteredEventData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.MachineLearningServicesModelDeployedEventData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.MachineLearningServicesModelDeployedEventData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.MachineLearningServicesRunCompletedEventData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.MachineLearningServicesRunCompletedEventData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.MachineLearningServicesDatasetDriftDetectedEventData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.MachineLearningServicesDatasetDriftDetectedEventData, Access.public);
@@usage(Microsoft.EventGrid.SystemEvents.MachineLearningServicesRunStatusChangedEventData, Usage.output);
@@access(Microsoft.EventGrid.SystemEvents.MachineLearningServicesRunStatusChangedEventData, Access.public);
//Enums 
