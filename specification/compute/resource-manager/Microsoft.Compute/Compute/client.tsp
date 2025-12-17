import "@azure-tools/typespec-client-generator-core";
import "./Compute/client.tsp";
import "./ComputeDisk/client.tsp";
import "./ComputeGallery/main.tsp";
import "./ComputeSku/main.tsp";

using Azure.ClientGenerator.Core;
/**
 * Compute Client
 */
@client({
  name: "ComputeClient",
  service: [Compute, ComputeDisk, ComputeGallery, ComputeSku],
})
namespace ComputeCombine;
