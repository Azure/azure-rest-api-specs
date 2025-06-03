import "./Microsoft.Communication/AzureCommunicationServices.tsp";
import "./Microsoft.EventHub/EventHub.tsp";
import "./Microsoft.HealthcareApis/HealthcareApis.tsp";
import "./Microsoft.Devices/IotHub.tsp";
import "./Microsoft.ResourceNotifications/HealthResources.tsp";
import "./Microsoft.ResourceNotifications/Resources.tsp";
import "./Microsoft.Storage/Storage.tsp";
import "./Microsoft.DataBox/DataBox.tsp";
import "./Microsoft.EventGrid/EventGrid.tsp";
import "./propertyNameOverrideGo.tsp";
import "./propertyNameOverrideCsharp.tsp";
import "./propertyNameOverrideJs.tsp";
import "./propertyNameOverrideJava.tsp";

import "@azure-tools/typespec-client-generator-core";

using Microsoft.EventGrid.SystemEvents;
using Azure.ClientGenerator.Core;

@@clientName(ApiManagementNearExpiryGatewayTokenProperties.expiredAtUtc,
  "expiresOn",
  "autorest"
);
@@clientName(ApiManagementExpiredGatewayTokenProperties.expiredAtUtc,
  "expiresOn",
  "autorest"
);
@@clientName(ApiManagementGatewayTokenNearExpiryEventData.gatewayInfo,
  "gateway",
  "autorest"
);
@@clientName(ApiManagementGatewayTokenNearExpiryEventData.tokenInfo,
  "token",
  "autorest"
);
@@clientName(ApiManagementGatewayTokenExpiredEventData.gatewayInfo,
  "gateway",
  "autorest"
);
@@clientName(ApiManagementGatewayTokenExpiredEventData.tokenInfo,
  "token",
  "autorest"
);
@@clientName(AcsIncomingCallEventData.to,
  "toCommunicationIdentifier",
  "autorest"
);
@@clientName(AcsIncomingCallEventData.from,
  "fromCommunicationIdentifier",
  "autorest"
);
@@clientName(AcsRouterWorkerSelector.value, "labelValue", "autorest");

@@clientName(AcsEmailEngagementTrackingReportReceivedEventData.engagementType,
  "engagement",
  "autorest"
);

@@clientName(EventHubCaptureFileCreatedEventData.fileUrl,
  "fileurl",
  "autorest"
);

@@clientName(HealthcareFhirResourceCreatedEventData.resourceFhirAccount,
  "FhirServiceHostName",
  "autorest"
);
@@clientName(HealthcareFhirResourceCreatedEventData.resourceFhirId,
  "FhirResourceId",
  "autorest"
);
@@clientName(HealthcareFhirResourceCreatedEventData.resourceVersionId,
  "FhirResourceVersionId",
  "autorest"
);
@@clientName(HealthcareFhirResourceCreatedEventData.resourceType,
  "FhirResourceType",
  "autorest"
);
@@clientName(HealthcareFhirResourceUpdatedEventData.resourceFhirAccount,
  "FhirServiceHostName",
  "autorest"
);
@@clientName(HealthcareFhirResourceUpdatedEventData.resourceFhirId,
  "FhirResourceId",
  "autorest"
);
@@clientName(HealthcareFhirResourceUpdatedEventData.resourceVersionId,
  "FhirResourceVersionId",
  "autorest"
);
@@clientName(HealthcareFhirResourceUpdatedEventData.resourceType,
  "FhirResourceType",
  "autorest"
);
@@clientName(HealthcareFhirResourceDeletedEventData.resourceFhirAccount,
  "FhirServiceHostName",
  "autorest"
);
@@clientName(HealthcareFhirResourceDeletedEventData.resourceFhirId,
  "FhirResourceId",
  "autorest"
);
@@clientName(HealthcareFhirResourceDeletedEventData.resourceVersionId,
  "FhirResourceVersionId",
  "autorest"
);
@@clientName(HealthcareFhirResourceDeletedEventData.resourceType,
  "FhirResourceType",
  "autorest"
);

@@clientName(DeviceTwinMetadata.lastUpdated, "$lastUpdated", "autorest");
@@clientName(DeviceTwinProperties.metadata, "$metadata", "autorest");
@@clientName(DeviceTwinProperties.version, "$version", "autorest");

@@clientName(ResourceNotificationsResourceUpdatedEventData.resourceInfo,
  "resourceDetails",
  "autorest"
);
@@clientName(ResourceNotificationsResourceUpdatedEventData.operationalInfo,
  "operationalDetails",
  "autorest"
);
@@clientName(ResourceNotificationsResourceDeletedEventData.resourceInfo,
  "resourceDetails",
  "autorest"
);
@@clientName(ResourceNotificationsResourceDeletedEventData.operationalInfo,
  "operationalDetails",
  "autorest"
);

@@clientName(StorageTaskAssignmentQueuedEventData.queuedDateTime,
  "queuedOn",
  "autorest"
);
@@clientName(StorageTaskAssignmentCompletedEventData.completedDateTime,
  "completedOn",
  "autorest"
);
@@clientName(StorageTaskAssignmentCompletedEventData.summaryReportBlobUrl,
  "summaryReportBlobUri",
  "autorest"
);

@@clientName(AcsMessageDeliveryStatusUpdatedEventData.channelType,
  "channelKind",
  "autorest"
);

@@clientName(AcsMessageReceivedEventData.channelType,
  "channelKind",
  "autorest"
);

@@clientName(AcsMessageReceivedEventData.media, "mediaContent", "autorest");

@@clientName(AcsMessageReceivedEventData.interactive,
  "interactiveContent",
  "autorest"
);

@@clientName(AcsMessageMediaContent.id, "mediaId", "autorest");

@@clientName(AcsMessageContext.id, "messageId", "autorest");

@@clientName(AcsMessageInteractiveContent.type, "replyKind", "autorest");

@@clientName(AcsMessageInteractiveButtonReplyContent.id,
  "buttonId",
  "autorest"
);

@@clientName(AcsMessageInteractiveListReplyContent.id,
  "listItemId",
  "autorest"
);
@@clientName(AcsCallEndedByProperties.type, "kind", "autorest");

// Renames applying to all languages
@@clientName(recordingChannelType, "AcsRecordingChannelType");
@@clientName(recordingContentType, "AcsRecordingContentType");
@@clientName(recordingFormatType, "AcsRecordingFormatType");
@@clientName(KeyVaultAccessPolicyChangedEventData.NBF, "Nbf");
@@clientName(KeyVaultAccessPolicyChangedEventData.EXP, "Exp");
@@clientName(KeyVaultCertificateExpiredEventData.NBF, "Nbf");
@@clientName(KeyVaultCertificateExpiredEventData.EXP, "Exp");
@@clientName(KeyVaultCertificateNearExpiryEventData.NBF, "Nbf");
@@clientName(KeyVaultCertificateNearExpiryEventData.EXP, "Exp");
@@clientName(KeyVaultCertificateNewVersionCreatedEventData.NBF, "Nbf");
@@clientName(KeyVaultCertificateNewVersionCreatedEventData.EXP, "Exp");
@@clientName(KeyVaultKeyExpiredEventData.NBF, "Nbf");
@@clientName(KeyVaultKeyExpiredEventData.EXP, "Exp");
@@clientName(KeyVaultKeyNearExpiryEventData.NBF, "Nbf");
@@clientName(KeyVaultKeyNearExpiryEventData.EXP, "Exp");
@@clientName(KeyVaultKeyNewVersionCreatedEventData.NBF, "Nbf");
@@clientName(KeyVaultKeyNewVersionCreatedEventData.EXP, "Exp");
@@clientName(KeyVaultSecretExpiredEventData.NBF, "Nbf");
@@clientName(KeyVaultSecretExpiredEventData.EXP, "Exp");
@@clientName(KeyVaultSecretNearExpiryEventData.NBF, "Nbf");
@@clientName(KeyVaultSecretNearExpiryEventData.EXP, "Exp");
@@clientName(KeyVaultSecretNewVersionCreatedEventData.NBF, "Nbf");
@@clientName(KeyVaultSecretNewVersionCreatedEventData.EXP, "Exp");
