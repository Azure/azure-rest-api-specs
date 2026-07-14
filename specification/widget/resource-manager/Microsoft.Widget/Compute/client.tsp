import "@azure-tools/typespec-client-generator-core";
import "./Disk/client.tsp";
import "./Gallery/client.tsp";

using Azure.ClientGenerator.Core;

@client({
  name: "ComputeClient",
  service: [Disk, Gallery],
})
namespace ComputeClient;
