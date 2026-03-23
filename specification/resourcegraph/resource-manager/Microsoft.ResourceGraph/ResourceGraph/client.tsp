import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./ResourceChanges/main.tsp";
import "./ResourceGraph/main.tsp";
import "./ResourceHistory/main.tsp";
import "./GraphQuery/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;

@client({
  name: "ResourceGraphClient",
  service: [ResourceChanges, ResourceGraphApi, ResourceHistory, GraphQueryApi],
  autoMergeServices: true,
})
namespace Microsoft.ResourceGraph;
