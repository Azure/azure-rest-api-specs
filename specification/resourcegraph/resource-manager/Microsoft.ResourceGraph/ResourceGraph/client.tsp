import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./GraphQuery/main.tsp";
import "./ResourceChanges/main.tsp";
import "./ResourceCopilot/main.tsp";
import "./ResourceGraph/main.tsp";
import "./ResourceHistory/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;

@client({
  name: "ResourceGraphClient",
  service: [GraphQuery, ResourceChanges, ResourceCopilot, ResourceGraph, ResourceHistory],
})
namespace Microsoft.ResourceGraph;
