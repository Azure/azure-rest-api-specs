import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Storage;

@@clientName(ProvisioningState, "StorageProvisioningState", "csharp");
@@clientName(Microsoft.Storage, "StorageManagementClient", "javascript");
