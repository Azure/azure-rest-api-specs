import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@internal(Azure.Messaging.EventGrid.publishCloudEvents);
@@internal(Azure.Messaging.EventGrid.publishCloudEvent);
@@internal(Azure.Messaging.EventGrid.receiveCloudEvents);

