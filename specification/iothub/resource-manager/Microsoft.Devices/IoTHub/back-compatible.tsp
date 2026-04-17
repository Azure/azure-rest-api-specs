import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Devices;

@@clientLocation(IotHubDescriptions.get, "IotHubResource");
@@clientLocation(IotHubDescriptions.createOrUpdate, "IotHubResource");
@@clientName(IotHubDescriptions.createOrUpdate::parameters.resource,
  "iotHubDescription"
);
@@clientLocation(IotHubDescriptions.update, "IotHubResource");
@@clientName(IotHubDescriptions.update::parameters.properties, "IotHubTags");
@@clientLocation(IotHubDescriptions.delete, "IotHubResource");
@@clientLocation(IotHubDescriptions.listByResourceGroup, "IotHubResource");
@@clientLocation(IotHubDescriptions.listBySubscription, "IotHubResource");
@@clientLocation(IotHubDescriptionOperationGroup.getStats, "IotHubResource");
@@clientLocation(IotHubDescriptions.getValidSkus, "IotHubResource");
@@clientLocation(IotHubDescriptions.listJobs, "IotHubResource");
@@clientLocation(IotHubDescriptions.getJob, "IotHubResource");
@@clientLocation(IotHubDescriptions.getQuotaMetrics, "IotHubResource");
@@clientLocation(IotHubDescriptions.getEndpointHealth, "IotHubResource");
@@clientLocation(IotHubDescriptions.testAllRoutes, "IotHubResource");
@@clientName(IotHubDescriptions.testAllRoutes::parameters.body, "input");
@@clientLocation(IotHubDescriptions.testRoute, "IotHubResource");
@@clientName(IotHubDescriptions.testRoute::parameters.body, "input");
@@clientLocation(IotHubDescriptions.listKeys, "IotHubResource");
@@clientLocation(IotHubDescriptions.getKeysForKeyName, "IotHubResource");
@@clientLocation(IotHubDescriptions.exportDevices, "IotHubResource");
@@clientName(IotHubDescriptions.exportDevices::parameters.body,
  "exportDevicesParameters"
);
@@clientLocation(IotHubDescriptions.importDevices, "IotHubResource");
@@clientName(IotHubDescriptions.importDevices::parameters.body,
  "importDevicesParameters"
);
@@clientLocation(IotHubDescriptions.manualFailover, "IotHub");
@@clientName(IotHubDescriptions.manualFailover::parameters.body,
  "failoverInput"
);

@@clientName(PrivateEndpointConnections.update::parameters.resource,
  "privateEndpointConnection"
);

@@clientLocation(EventHubConsumerGroupInfos.getEventHubConsumerGroup,
  "IotHubResource"
);
@@clientLocation(EventHubConsumerGroupInfos.createEventHubConsumerGroup,
  "IotHubResource"
);
@@clientName(EventHubConsumerGroupInfos.createEventHubConsumerGroup::parameters.resource,
  "consumerGroupBody"
);
@@clientLocation(EventHubConsumerGroupInfos.deleteEventHubConsumerGroup,
  "IotHubResource"
);
@@clientLocation(EventHubConsumerGroupInfos.listEventHubConsumerGroups,
  "IotHubResource"
);

@@clientLocation(CertificateDescriptions.get, "Certificates");
@@clientLocation(CertificateDescriptions.createOrUpdate, "Certificates");
@@clientName(CertificateDescriptions.createOrUpdate::parameters.resource,
  "certificateDescription"
);
@@clientLocation(CertificateDescriptions.delete, "Certificates");
@@clientLocation(CertificateDescriptions.listByIotHub, "Certificates");
@@clientLocation(CertificateDescriptions.generateVerificationCode,
  "Certificates"
);
@@clientLocation(CertificateDescriptions.verify, "Certificates");
@@clientName(CertificateDescriptions.verify::parameters.body,
  "certificateVerificationBody"
);

@@clientLocation(GroupIdInformations.get, "PrivateLinkResources");
@@clientLocation(GroupIdInformations.list, "PrivateLinkResources");

@@clientLocation(IotHubResourceOperationGroup.checkNameAvailability,
  "IotHubResource"
);

@@clientLocation(ResourceProviderCommonOperationGroup.getSubscriptionQuota,
  "ResourceProviderCommon"
);
@@clientName(IotHubResourceOperationGroup.checkNameAvailability::parameters.body,
  "operationInputs"
);
