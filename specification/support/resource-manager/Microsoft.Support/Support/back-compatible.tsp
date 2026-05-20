import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Support;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Service.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProblemClassification.properties
);

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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SupportTicketDetails.properties
);

@@clientName(Communications.create::parameters.resource,
  "createCommunicationParameters"
);
@@clientName(CommunicationsNoSubscription.create::parameters.resource,
  "createCommunicationParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CommunicationDetails.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ChatTranscriptDetails.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(FileWorkspaceDetails.properties
);

@@clientName(Files.create::parameters.resource, "createFileParameters");
@@clientName(Files.upload::parameters.body, "uploadFile");
@@clientName(FilesNoSubscription.create::parameters.resource,
  "createFileParameters"
);
@@clientName(FilesNoSubscription.upload::parameters.body, "uploadFile");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(FileDetails.properties);

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
