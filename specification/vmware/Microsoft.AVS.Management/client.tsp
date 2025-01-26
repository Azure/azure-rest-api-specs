import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager.CommonTypes;
using Microsoft.AVS;

@@clientName(Microsoft.AVS, "AzureVMwareSolutionAPI", "javascript");
@@clientName(Microsoft.AVS, "AVS", "python");
