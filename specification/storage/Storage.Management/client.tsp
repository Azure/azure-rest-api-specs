import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Storage;

@@clientName(ProvisioningState, "StorageProvisioningState", "csharp");
