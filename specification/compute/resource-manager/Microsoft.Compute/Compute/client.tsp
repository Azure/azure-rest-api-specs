import "@azure-tools/typespec-client-generator-core";
import "./Compute/client.tsp";
import "./Disk/client.tsp";
import "./Gallery/main.tsp";
import "./Sku/main.tsp";

using Azure.ClientGenerator.Core;
/**
 * Compute Client
 */
@client({
  service: [Compute, ComputeDisk, ComputeGallery, ComputeSku],
})
namespace Microsoft.Compute;
