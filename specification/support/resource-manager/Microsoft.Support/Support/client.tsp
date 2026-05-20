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
@@clientName(CheckNameAvailabilityInput.type, "ResourceType", "csharp");
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
@@clientName(Consent, "AdvancedDiagnosticConsent", "csharp");
@@clientName(MessageProperties, "ChatTranscriptMessageProperties", "csharp");
@@clientName(UploadFile, "UploadFileContent", "csharp");
@@clientName(ProblemClassificationProperties.secondaryConsentEnabled,
  "SecondaryConsentEnabledInfo",
  "csharp"
);
@@clientName(SecondaryConsent.type, "SecondaryConsentType", "csharp");
@@clientName(SecondaryConsentEnabled.type,
  "SecondaryConsentEnabledType",
  "csharp"
);
@@clientName(ServiceProperties.resourceTypes, "ArmResourceTypes", "csharp");
@@clientName(SeverityLevel, "SupportSeverityLevel", "csharp");
@@clientName(ContactProfile, "SupportContactProfile", "csharp");
@@clientName(ServiceLevelAgreement, "SupportServiceLevelAgreement", "csharp");
@@clientName(LookUpResourceIdRequest,
  "SupportLookUpResourceIdContent",
  "csharp"
);
@@clientName(LookUpResourceIdResponse,
  "SupportLookUpResourceIdResult",
  "csharp"
);
@@clientName(ServiceClassificationRequest,
  "SupportServiceClassificationContent",
  "csharp"
);
@@clientName(ChatTranscriptDetails, "ChatTranscriptDetail", "csharp");
@@clientName(FileWorkspaceDetails, "FileWorkspaceDetail", "csharp");
@@clientName(FileDetails, "SupportFileDetail", "csharp");
@@clientName(FileWorkspaces, "SubscriptionFileWorkspace", "csharp");
@@clientName(SupportTickets, "SubscriptionSupportTicket", "csharp");
@@clientName(SupportTickets.checkNameAvailability,
  "CheckCommunicationNameAvailability",
  "csharp"
);
@@clientName(ChatTranscripts, "SupportTicketChatTranscript", "csharp");
@@clientName(Communications, "SupportTicketCommunication", "csharp");
@@clientName(Files, "SupportTicketFile", "csharp");
@@clientName(ChatTranscriptsNoSubscription,
  "SupportTicketNoSubChatTranscript",
  "csharp"
);
@@clientName(CommunicationsNoSubscription,
  "SupportTicketNoSubCommunication",
  "csharp"
);
@@clientName(FilesNoSubscription, "SupportTicketNoSubFile", "csharp");
@@clientName(ClassificationService, "SupportClassificationService", "csharp");
@@clientName(DirectConnectEscalation,
  "SupportDirectConnectEscalation",
  "csharp"
);
@@clientName(EscalationStatus, "SupportEscalationStatus", "csharp");
@@clientName(ServiceClassificationAnswer,
  "SupportServiceClassificationAnswer",
  "csharp"
);
@@clientName(ServiceClassificationOutput,
  "SupportServiceClassificationOutput",
  "csharp"
);
@@clientName(FileWorkspacesNoSubscription, "TenantFileWorkspace", "csharp");
@@clientName(SupportTicketsNoSubscription, "TenantSupportTicket", "csharp");
@@clientName(SupportTicketsNoSubscription.checkNameAvailability,
  "CheckNameAvailabilityCommunicationsNoSubscription",
  "csharp"
);
@@clientName(SupportTicketsOperationGroup.checkNameAvailability,
  "CheckSupportTicketNameAvailability",
  "csharp"
);
@@clientName(SupportTicketsNoSubscriptionOperationGroup.checkNameAvailability,
  "CheckNameAvailabilitySupportTicketsNoSubscription",
  "csharp"
);
@@alternateType(LookUpResourceIdRequest.identifier,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(LookUpResourceIdResponse.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(TechnicalTicketDetails.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ClassificationService.resourceTypes,
  Azure.Core.armResourceType[],
  "csharp"
);
@@usage(ProblemClassification, Usage.input, "csharp");
@@usage(Service, Usage.input, "csharp");
@@usage(MessageProperties, Usage.input, "csharp");
@@usage(SecondaryConsentEnabled, Usage.input, "csharp");
@@clientName(MessageProperties.contentType, "TranscriptContentType", "csharp");
