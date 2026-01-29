import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ProviderHub;

@@clientName(Microsoft.ProviderHub, "ProviderHubMgmtClient", "python");

@@clientLocation(ProviderRegistrations.checkinManifest, "Client", "go");
@@clientLocation(ProviderRegistrations.generateManifest, "Client", "go");

@@clientName(LocalizedOperationDefinitionDisplay.ptPT, "pt", "go,java");
@@clientName(LocalizedOperationDisplayDefinitionPtPT,
  "LocalizedOperationDisplayDefinitionPt",
  "go,java"
);

@@alternateType(AuthorizedApplication.name, Azure.Core.uuid, "java");
@@clientName(SubscriptionLifecycleNotificationSpecifications.softDeleteTTL,
  "softDeleteTtl",
  "java"
);
