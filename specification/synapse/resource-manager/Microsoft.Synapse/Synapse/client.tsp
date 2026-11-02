import "@azure-tools/typespec-client-generator-core";

import "./Workspaces/main.tsp";
import "./SqlPools/main.tsp";
import "./BigDataPools/main.tsp";
import "./IntegrationRuntimes/main.tsp";
import "./KustoPools/main.tsp";

using Azure.ClientGenerator.Core;

/**
 * Azure Synapse Analytics management client. Combines the Synapse resource-manager
 * TypeSpec projects (each with its own API version) into the single SDK client
 * released from the `package-composite-v2` tag.
 */
@client({
  name: "SynapseManagementClient",
  service: [
    Workspaces,
    SqlPools,
    BigDataPools,
    IntegrationRuntimes,
    KustoPools
  ],
  autoMergeService: true,
})
namespace Microsoft.Synapse;
