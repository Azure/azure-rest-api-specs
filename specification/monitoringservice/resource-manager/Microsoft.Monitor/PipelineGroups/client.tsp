import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Monitor;

// Rename the PipelineGroups operation group to avoid conflict with the
// namespace segment "PipelineGroups" in Azure.ResourceManager.Monitor.PipelineGroups.
// Without this, the generator prefixes the namespace segment with "_".
@@clientName(PipelineGroups, "PipelineGroupOperations", "csharp");
