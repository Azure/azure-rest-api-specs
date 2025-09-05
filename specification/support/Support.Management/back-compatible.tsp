import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Support;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Service.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProblemClassification.properties);

@@clientName(SupportTickets.create::parameters.resource,
  "createSupportTicketParameters"
);
@@clientName(SupportTickets.update::parameters.properties,
  "updateSupportTicket"
);
@@clientName(SupportTickets.checkNameAvailability::parameters.body,
  "checkNameAvailabilityInput"
);
@@clientName(SupportTicketsNoSubscriptionOperationGroup.checkNameAvailability::parameters.body,
  "checkNameAvailabilityInput"
);
@@clientName(SupportTicketsNoSubscription.create::parameters.resource,
  "createSupportTicketParameters"
);
@@clientName(SupportTicketsNoSubscription.checkNameAvailability::parameters.body,
  "checkNameAvailabilityInput"
);
@@clientName(SupportTicketsNoSubscription.update::parameters.properties,
  "updateSupportTicket"
);
@@clientName(SupportTicketsOperationGroup.checkNameAvailability::parameters.body,
  "checkNameAvailabilityInput"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SupportTicketDetails.properties);

@@clientName(Communications.create::parameters.resource,
  "createCommunicationParameters"
);
@@clientName(CommunicationsNoSubscription.create::parameters.resource,
  "createCommunicationParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CommunicationDetails.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ChatTranscriptDetails.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FileWorkspaceDetails.properties);

@@clientName(Files.create::parameters.resource, "createFileParameters");
@@clientName(Files.upload::parameters.body, "uploadFile");
@@clientName(FilesNoSubscription.create::parameters.resource,
  "createFileParameters"
);
@@clientName(FilesNoSubscription.upload::parameters.body, "uploadFile");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FileDetails.properties);

// @@clientLocation decorators for operations with custom @operationId
// These ensure consistent operationId generation in the output
@@clientLocation(SupportTickets.checkNameAvailability, Communications);
@@clientLocation(SupportTicketsOperationGroup.checkNameAvailability,
  SupportTickets
);
@@clientLocation(SupportTicketsNoSubscriptionOperationGroup.checkNameAvailability,
  SupportTicketsNoSubscription
);
@@clientLocation(SupportTicketsNoSubscription.checkNameAvailability,
  CommunicationsNoSubscription
);

@@clientName(ClassifyProblems.classifyProblems::parameters.body,
  "problemClassificationsClassificationInput"
);
@@clientName(ClassifyProblemsNoSubscription.classifyProblems::parameters.body,
  "problemClassificationsClassificationInput"
);
@@clientName(ClassifyServices.classifyServices::parameters.body,
  "serviceClassificationRequest"
);
@@clientName(ClassifyServicesNoSubscription.classifyServices::parameters.body,
  "serviceClassificationRequest"
);
@@clientName(SupportTickets.lookUpResourceId::parameters.body,
  "lookUpResourceIdRequest"
);
