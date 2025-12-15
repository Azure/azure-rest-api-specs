import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ProviderHub;

@@clientName(Microsoft.ProviderHub, "ProviderHubMgmtClient", "python");
