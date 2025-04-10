import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Devices;

@@clientName(IotHubDescriptions.createOrUpdate::parameters.resource,
  "iotHubDescription"
);
@@clientName(IotHubDescriptions.update::parameters.properties, "IotHubTags");
@@clientName(IotHubDescriptions.testAllRoutes::parameters.body, "input");
@@clientName(IotHubDescriptions.testRoute::parameters.body, "input");
@@clientName(IotHubDescriptions.exportDevices::parameters.body,
  "exportDevicesParameters"
);
@@clientName(IotHubDescriptions.importDevices::parameters.body,
  "importDevicesParameters"
);
@@clientName(IotHubDescriptions.manualFailover::parameters.body,
  "failoverInput"
);

@@clientName(PrivateEndpointConnections.update::parameters.resource,
  "privateEndpointConnection"
);

@@clientName(EventHubConsumerGroupInfos.createEventHubConsumerGroup::parameters.resource,
  "consumerGroupBody"
);

@@clientName(CertificateDescriptions.createOrUpdate::parameters.resource,
  "certificateDescription"
);
@@clientName(CertificateDescriptions.verify::parameters.body,
  "certificateVerificationBody"
);
