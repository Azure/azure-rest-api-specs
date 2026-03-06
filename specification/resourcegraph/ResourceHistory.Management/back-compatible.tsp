import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ResourceGraph;

// @@clientName(ResourcesHistoryRequestOptions.$top, "top");
// @@clientName(ResourcesHistoryRequestOptions.$skip, "skip");
// @@clientName(ResourcesHistoryRequestOptions.$skipToken, "skipToken");

@@clientName(resourcesHistory::parameters.body, "request");
