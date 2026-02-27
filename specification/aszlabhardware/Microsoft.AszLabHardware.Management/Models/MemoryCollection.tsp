import "./MemoryModule.tsp";

using Azure.ResourceManager;

@doc("Information regarding the RAM of the server")
model MemoryCollection {
  @doc("Number of memory modules")
  memoryModuleCount: int32;

  @doc("Total memory of server in GiB")
  totalSystemMemoryGiB: int64;

  @doc("Information of individual memory modules")
  @identifiers(#["moduleName"])
  memoryModules: MemoryModule[];
}
