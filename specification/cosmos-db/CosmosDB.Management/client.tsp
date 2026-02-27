import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.DocumentDB;

@@clientName(ErrorResponse, "CosmosDBErrorResult", "csharp,java");
@@clientName(Microsoft.DocumentDB, "CosmosDBManagementClient", "javascript");
