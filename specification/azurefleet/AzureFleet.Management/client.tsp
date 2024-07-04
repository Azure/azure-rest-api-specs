import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
namespace Microsoft.AzureFleet;
@@clientName(Microsoft.AzureFleet, "ComputeFleetMgmt", "python");
@@access(Operations.list, Access.internal, "csharp");
