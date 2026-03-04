import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Support;

@@clientName(CommunicationDetails, "SupportTicketCommunication", "csharp");
@@clientName(CommunicationDirection,
  "SupportTicketCommunicationDirection",
  "csharp"
);
@@clientName(CommunicationType, "SupportTicketCommunicationType", "csharp");
@@clientName(SupportTicketDetails, "SupportTicket", "csharp");
@@clientName(CheckNameAvailabilityInput,
  "SupportNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityOutput,
  "SupportNameAvailabilityResult",
  "csharp"
);
@@clientName(CheckNameAvailabilityOutput.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(QuotaChangeRequest, "SupportQuotaChangeContent", "csharp");
@@clientName(ServiceLevelAgreement.slaMinutes, "SlaInMinutes", "csharp");
@@clientName(Status, "SupportTicketStatus", "csharp");
@@clientName(UpdateContactProfile, "SupportContactProfileContent", "csharp");
@@clientName(Type, "SupportResourceType", "csharp");
@@clientName(Service, "SupportAzureService", "csharp");
@@alternateType(TechnicalTicketDetails.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(Consent, "AdvancedDiagnosticConsent", "csharp");
@@clientName(MessageProperties, "ChatTranscriptMessageProperties", "csharp");
@@clientName(UploadFile, "UploadFileContent", "csharp");
@@clientName(ProblemClassificationProperties.secondaryConsentEnabled,
  "SecondaryConsentEnabledInfo",
  "csharp"
);
@@clientName(ServiceProperties.resourceTypes, "ArmResourceTypes", "csharp");
