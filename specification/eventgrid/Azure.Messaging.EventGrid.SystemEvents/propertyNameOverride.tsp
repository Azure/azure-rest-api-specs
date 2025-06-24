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

// Renames applying to all languages
@@clientName(ApiManagementNearExpiryGatewayTokenProperties.expiredAtUtc,
  "expiresOn"
);
@@clientName(ApiManagementExpiredGatewayTokenProperties.expiredAtUtc,
  "expiresOn"
);
@@clientName(ApiManagementGatewayTokenNearExpiryEventData.gatewayInfo,
  "gateway"
);
@@clientName(ApiManagementGatewayTokenNearExpiryEventData.tokenInfo, "token");
@@clientName(ApiManagementGatewayTokenExpiredEventData.gatewayInfo, "gateway");
@@clientName(ApiManagementGatewayTokenExpiredEventData.tokenInfo, "token");
@@clientName(AcsIncomingCallEventData.to, "toCommunicationIdentifier");
@@clientName(AcsIncomingCallEventData.from, "fromCommunicationIdentifier");
@@clientName(AcsRouterWorkerSelector.value, "labelValue");
@@clientName(AcsEmailEngagementTrackingReportReceivedEventData.engagementType,
  "engagement"
);
@@clientName(HealthcareFhirResourceCreatedEventData.resourceFhirAccount,
  "FhirServiceHostName"
);
@@clientName(HealthcareFhirResourceCreatedEventData.resourceFhirId,
  "FhirResourceId"
);
@@clientName(HealthcareFhirResourceCreatedEventData.resourceVersionId,
  "FhirResourceVersionId"
);
@@clientName(HealthcareFhirResourceCreatedEventData.resourceType,
  "FhirResourceType"
);
@@clientName(HealthcareFhirResourceUpdatedEventData.resourceFhirAccount,
  "FhirServiceHostName"
);
@@clientName(HealthcareFhirResourceUpdatedEventData.resourceFhirId,
  "FhirResourceId"
);
@@clientName(HealthcareFhirResourceUpdatedEventData.resourceVersionId,
  "FhirResourceVersionId"
);
@@clientName(HealthcareFhirResourceUpdatedEventData.resourceType,
  "FhirResourceType"
);
@@clientName(HealthcareFhirResourceDeletedEventData.resourceFhirAccount,
  "FhirServiceHostName"
);
@@clientName(HealthcareFhirResourceDeletedEventData.resourceFhirId,
  "FhirResourceId"
);
@@clientName(HealthcareFhirResourceDeletedEventData.resourceVersionId,
  "FhirResourceVersionId"
);
@@clientName(HealthcareFhirResourceDeletedEventData.resourceType,
  "FhirResourceType"
);
@@clientName(ResourceNotificationsResourceUpdatedEventData.resourceInfo,
  "resourceDetails"
);
@@clientName(ResourceNotificationsResourceUpdatedEventData.operationalInfo,
  "operationalDetails"
);
@@clientName(ResourceNotificationsResourceDeletedEventData.resourceInfo,
  "resourceDetails"
);
@@clientName(ResourceNotificationsResourceDeletedEventData.operationalInfo,
  "operationalDetails"
);
@@clientName(StorageTaskAssignmentQueuedEventData.queuedDateTime, "queuedOn");
@@clientName(StorageTaskAssignmentCompletedEventData.completedDateTime,
  "completedOn"
);
@@clientName(AcsMessageDeliveryStatusUpdatedEventData.channelType,
  "channelKind"
);
@@clientName(AcsMessageReceivedEventData.channelType, "channelKind");
@@clientName(AcsMessageReceivedEventData.media, "mediaContent");
@@clientName(AcsMessageReceivedEventData.interactive, "interactiveContent");
@@clientName(AcsMessageMediaContent.id, "mediaId");
@@clientName(AcsMessageContext.id, "messageId");
@@clientName(AcsMessageInteractiveContent.type, "replyKind");
@@clientName(AcsMessageInteractiveButtonReplyContent.id, "buttonId");
@@clientName(AcsMessageInteractiveListReplyContent.id, "listItemId");
@@clientName(AcsCallEndedByProperties.type, "kind");
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

@@clientName(ApiManagementUserCreatedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementUserUpdatedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementUserDeletedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementApiDeletedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementApiReleaseCreatedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementApiReleaseDeletedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementApiReleaseUpdatedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementSubscriptionCreatedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementSubscriptionUpdatedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementSubscriptionDeletedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementProductCreatedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementProductUpdatedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementProductDeletedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementApiCreatedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementApiUpdatedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementGatewayCreatedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementGatewayUpdatedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementGatewayDeletedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementGatewayHostnameConfigurationCreatedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementGatewayHostnameConfigurationUpdatedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementGatewayHostnameConfigurationDeletedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementGatewayCertificateAuthorityCreatedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementGatewayCertificateAuthorityUpdatedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementGatewayCertificateAuthorityDeletedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementGatewayApiAddedEventData.resourceUri,
  "resourceUrl",
  "!go"
);
@@clientName(ApiManagementGatewayApiRemovedEventData.resourceUri,
  "resourceUrl",
  "!go"
);

@@clientName(ContainerRegistryEventSource.instanceID, "instanceId");

// autorest specific renames
@@clientName(DeviceTwinMetadata.lastUpdated, "$lastUpdated", "autorest");
@@clientName(DeviceTwinProperties.metadata, "$metadata", "autorest");
@@clientName(DeviceTwinProperties.version, "$version", "autorest");
