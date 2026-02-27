import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.DocumentDB;

@@clientName(ErrorResponse, "CosmosDBErrorResult", "csharp");
@@clientName(Microsoft.DocumentDB, "CosmosDBManagementClient", "javascript");
