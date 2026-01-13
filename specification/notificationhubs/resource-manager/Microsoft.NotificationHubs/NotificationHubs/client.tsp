import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.NotificationHubs;

@@clientName(Microsoft.NotificationHubs,
  "NotificationHubsManagementClient",
  "javascript"
);

@@clientName(NamespaceResources.listAll, "listBySubscription", "csharp");
