import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Communication;

@@clientName(Microsoft.Communication,
  "CommunicationServiceManagementClient",
  "javascript,python,java"
);
@@clientName(CommunicationServices_ProvisioningState,
  "CommunicationServicesProvisioningState",
  "python"
);
@@clientName(Domains_ProvisioningState, "DomainsProvisioningState", "python");
@@clientName(EmailServices_ProvisioningState,
  "EmailServicesProvisioningState",
  "python"
);

// Rename properties in DomainPropertiesVerificationStates to restore fluent method names
@@clientName(DomainPropertiesVerificationStates.DKIM, "dkim", "java");
@@clientName(DomainPropertiesVerificationStates.DKIM2, "dkim2", "java");
@@clientName(DomainPropertiesVerificationStates.SPF, "spf", "java");
@@clientName(DomainPropertiesVerificationStates.DMARC, "dmarc", "java");

// Rename properties in DomainPropertiesVerificationRecords to restore fluent method names
@@clientName(DomainPropertiesVerificationRecords.DKIM, "dkim", "java");
@@clientName(DomainPropertiesVerificationRecords.DKIM2, "dkim2", "java");
@@clientName(DomainPropertiesVerificationRecords.SPF, "spf", "java");
@@clientName(DomainPropertiesVerificationRecords.DMARC, "dmarc", "java");

@@clientName(CommunicationServiceProperties.hostName, "hostname", "java");
@@clientName(SuppressionListProperties.createdTimeStamp,
  "createdTimestamp",
  "java"
);
@@clientName(SuppressionListProperties.lastUpdatedTimeStamp,
  "lastUpdatedTimestamp",
  "java"
);
@@clientName(NameAvailabilityParameters,
  "CommunicationServiceNameAvailabilityContent",
  "csharp"
);
@@clientName(TaggedResource, "CommunicationAcceptTags", "csharp");
@@clientName(DomainResource, "CommunicationDomainResource", "csharp");
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityReason,
  "CommunicationNameAvailabilityReason",
  "csharp"
);
@@clientName(RegenerateKeyParameters,
  "RegenerateCommunicationServiceKeyContent",
  "csharp"
);
@@clientName(VerificationParameter,
  "DomainsRecordVerificationContent",
  "csharp"
);
@@clientName(VerificationType, "DomainRecordVerificationType", "csharp");
@@clientName(VerificationStatus, "DomainRecordVerificationStatus", "csharp");
@@clientName(VerificationStatusRecord,
  "DomainVerificationStatusRecord",
  "csharp"
);
@@clientName(KeyType, "CommunicationServiceKeyType", "csharp");
@@clientName(DnsRecord.ttl, "TimeToLiveInSeconds", "csharp");
@@clientName(DnsRecord, "VerificationDnsRecord", "csharp");
@@clientName(Domains_ProvisioningState, "DomainProvisioningState", "csharp");
@@clientName(ProvisioningState,
  "CommunicationServiceProvisioningState",
  "csharp"
);
@@clientName(SuppressionListProperties.createdTimeStamp, "CreatedOn", "csharp");
@@clientName(SuppressionListProperties.lastUpdatedTimeStamp,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(CommunicationServiceProperties.disableLocalAuth,
  "IsLocalAuthDisabled",
  "csharp"
);
@@clientName(SmtpUsernameResource, "CommunicationSmtpUsername", "csharp");
@@clientName(SuppressionListAddressResource,
  "EmailSuppressionListAddress",
  "csharp"
);
@@clientName(SuppressionListResource, "EmailSuppressionList", "csharp");
@@clientName(Azure.ResourceManager.CommonTypes.PublicNetworkAccess,
  "CommunicationPublicNetworkAccess",
  "csharp"
);
@@alternateType(SmtpUsernameProperties.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(CommunicationServiceProperties.immutableResourceId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(CommunicationServiceProperties.notificationHubId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(LinkNotificationHubParameters.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(LinkedNotificationHub.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(CommunicationServices.checkNameAvailability,
  "CheckCommunicationNameAvailability",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
  "CommunicationNameAvailabilityContent",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,
  "CommunicationNameAvailabilityResult",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(LinkNotificationHubParameters,
  "LinkNotificationHubContent",
  "csharp"
);
@@clientName(SenderUsernameResourceCollection,
  "SenderUsernameResourceListResult",
  "csharp"
);
@@clientName(DomainPropertiesVerificationRecords.SPF, "Spf", "csharp");
@@clientName(DomainPropertiesVerificationRecords.DKIM, "Dkim", "csharp");
@@clientName(DomainPropertiesVerificationRecords.DKIM2, "Dkim2", "csharp");
@@clientName(DomainPropertiesVerificationRecords.DMARC, "Dmarc", "csharp");
@@clientName(DomainPropertiesVerificationStates.SPF, "Spf", "csharp");
@@clientName(DomainPropertiesVerificationStates.DKIM, "Dkim", "csharp");
@@clientName(DomainPropertiesVerificationStates.DKIM2, "Dkim2", "csharp");
@@clientName(DomainPropertiesVerificationStates.DMARC, "Dmarc", "csharp");
@@clientName(VerificationType.SPF, "Spf", "csharp");
@@clientName(VerificationType.DKIM, "Dkim", "csharp");
@@clientName(VerificationType.DKIM2, "Dkim2", "csharp");
@@clientName(VerificationType.DMARC, "Dmarc", "csharp");
@@alternateType(SuppressionListProperties.createdTimeStamp,
  utcDateTime,
  "csharp"
);
@@alternateType(SuppressionListProperties.lastUpdatedTimeStamp,
  utcDateTime,
  "csharp"
);
@@clientName(DnsRecord.type, "DnsRecordType", "csharp");
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest.type,
  "ResourceType",
  "csharp"
);
@@alternateType(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest.type,
  Azure.Core.armResourceType,
  "csharp"
);
@@clientName(EmailServices.listVerifiedExchangeOnlineDomains,
  "GetVerifiedExchangeOnlineDomainsEmailServices",
  "csharp"
);
