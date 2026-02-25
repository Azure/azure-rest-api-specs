import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ManagedOps;

@@clientName(Microsoft.ManagedOps, "ManagedOpsMgmtClient", "python");
@@clientName(ManagedOps, "ManagedOperations", "csharp");
