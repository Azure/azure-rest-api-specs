import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Support;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProblemClassificationsClassificationResult.relatedService);

@@clientName(Services.classifyProblems::parameters.body,
  "problemClassificationsClassificationInput"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Service.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProblemClassification.properties);

@@clientName(SupportTicketDetailsOperationGroup, "SupportTicketDetails");
@@clientName(SupportTickets.create::parameters.resource,
  "createSupportTicketParameters"
);
@@clientName(SupportTickets.update::parameters.properties,
  "updateSupportTicket"
);
@@clientName(SupportTickets.checkNameAvailability::parameters.body,
  "checkNameAvailabilityInput"
);
@@clientName(SupportTicketsNoSubscription.create::parameters.resource,
  "createSupportTicketParameters"
);
@@clientName(SupportTicketsNoSubscription.update::parameters.properties,
  "updateSupportTicket"
);
@@clientName(SupportTicketsNoSubscription.checkNameAvailability::parameters.body,
  "checkNameAvailabilityInput"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SupportTicketDetails.properties);

@@clientName(CommunicationDetailsOperationGroup, "CommunicationDetails");
@@clientName(Communications.create::parameters.resource,
  "createCommunicationParameters"
);
@@clientName(CommunicationsNoSubscription.create::parameters.resource,
  "createCommunicationParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CommunicationDetails.properties);

@@clientName(ChatTranscriptDetailsOperationGroup, "ChatTranscriptDetails");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ChatTranscriptDetails.properties);

@@clientName(FileWorkspaceDetailsOperationGroup, "FileWorkspaceDetails");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FileWorkspaceDetails.properties);

@@clientName(FileDetailsOperationGroup, "FileDetails");
@@clientName(Files.create::parameters.resource, "createFileParameters");
@@clientName(Files.upload::parameters.body, "uploadFile");
@@clientName(FilesNoSubscription.create::parameters.resource,
  "createFileParameters"
);
@@clientName(FilesNoSubscription.upload::parameters.body, "uploadFile");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FileDetails.properties);
