import "./commons.tsp"; // Import common types

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using LiftrBase.Data;

namespace Neon.Postgres.Models;

@doc("Properties specific to Compute")
@added(Neon.Postgres.Versions.v2_preview)
model ComputeProperties {
  ...BaseEntity;

  @doc("Region where the compute instance is located")
  region: string;

  @doc("Number of allocated CPU cores")
  cpuCores: int32;

  @doc("Memory allocated in GB")
  memory: int32;

  @doc("Current status of the compute instance")
  status: string;
}
