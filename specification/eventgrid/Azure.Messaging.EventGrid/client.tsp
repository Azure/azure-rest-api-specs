import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@internal(Azure.Messaging.EventGrid.PublishCloudEvents);
@@internal(Azure.Messaging.EventGrid.PublishCloudEvent);
@@internal(Azure.Messaging.EventGrid.ReceiveCloudEvents);


@@clientFormat(Azure.Messaging.EventGrid.ReceiveCloudEvents::timeout, "seconds");