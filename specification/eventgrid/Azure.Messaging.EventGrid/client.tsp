import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@internal(Azure.Messaging.EventGrid.CloudEventEvent);
@@internal(Azure.Messaging.EventGrid.ReceiveDetails);
@@internal(Azure.Messaging.EventGrid.PublishBatchOfCloudEvents);
@@internal(Azure.Messaging.EventGrid.PublishCloudEvent);
@@internal(Azure.Messaging.EventGrid.ReceiveBatchOfCloudEvents);
