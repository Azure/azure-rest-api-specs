import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.DatabaseFleetManager;

@@clientName(Identity, "IdentityProperties", "csharp");
