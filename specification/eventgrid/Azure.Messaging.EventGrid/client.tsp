import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@access(Microsoft.EventGrid.publishCloudEvent, Access.internal, "python");
@@access(Microsoft.EventGrid.publishCloudEvents, Access.internal, "python");
@@access(Microsoft.EventGrid.receiveCloudEvents, Access.internal, "python");
