import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.NotificationHubs;

@@clientName(Microsoft.NotificationHubs,
  "NotificationHubsManagementClient",
  "javascript"
);

@@clientName(CheckAvailabilityParameters, "CheckAvailabilityContent", "csharp");
@@clientName(DebugSendResponse, "DebugSendResponseResult", "csharp");
@@clientName(Operation, "Info", "csharp");