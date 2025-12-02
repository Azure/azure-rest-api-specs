import "../Compute.Management/main.tsp";
import "../Disk.Management/main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;

@client
@useDependency(
  Microsoft.ComputeDisk.Versions.v2025_01_02,
  Microsoft.Compute.Versions.v2025_04_01
)
namespace Compute {
  @client({
    service: Microsoft.ComputeDisk,
    parent: Compute,
  })
  interface Disks extends Microsoft.ComputeDisk.Disks {}

  @client({
    service: Microsoft.Compute,
    parent: Compute,
  })
  interface VitrualMachines extends Microsoft.Compute.VirtualMachines {}
}
