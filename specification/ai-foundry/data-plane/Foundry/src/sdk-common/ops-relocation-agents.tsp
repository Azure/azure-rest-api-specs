// TODO: Rename this file to "relocate-operations.tsp" (or similar), as it now contains both
// GA and beta (preview) operations .

// This file moves all beta operations (preview routes) from the Azure.AI.Projects namespace to
// a new namespace Azure.AI.Projects.Beta, thus creating a sub-client ".beta" in the emitted SDKs.
// It is imported by the client.tsp file, which is used for emitting the Python and JS clients.
// See https://azure.github.io/typespec-azure/docs/howtos/generate-client-libraries/03client/#move-all-operations-to-root-client

using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects {
  // Relocate these operations from the AgentSessionFiles interface to the Agents interface
  @@clientLocation(
    Azure.AI.Projects.AgentSessionFiles.uploadSessionFile,
    Agents
  );
  @@clientLocation(
    Azure.AI.Projects.AgentSessionFiles.downloadSessionFile,
    Agents
  );
  @@clientLocation(
    Azure.AI.Projects.AgentSessionFiles.listSessionFiles,
    Agents
  );
  @@clientLocation(
    Azure.AI.Projects.AgentSessionFiles.deleteSessionFile,
    Agents
  );
}

namespace Azure.AI.Projects.Beta {
  interface MemoryStores {}
  @@clientLocation(
    Azure.AI.Projects.MemoryStores.createMemoryStore,
    MemoryStores
  );
  @@clientLocation(
    Azure.AI.Projects.MemoryStores.updateMemoryStore,
    MemoryStores
  );
  @@clientLocation(Azure.AI.Projects.MemoryStores.getMemoryStore, MemoryStores);
  @@clientLocation(
    Azure.AI.Projects.MemoryStores.listMemoryStores,
    MemoryStores
  );
  @@clientLocation(
    Azure.AI.Projects.MemoryStores.deleteMemoryStore,
    MemoryStores
  );
  @@clientLocation(Azure.AI.Projects.MemoryStores.searchMemories, MemoryStores);
  @@clientLocation(Azure.AI.Projects.MemoryStores.updateMemories, MemoryStores);
  @@clientLocation(
    Azure.AI.Projects.MemoryStores.getUpdateResult,
    MemoryStores
  );
  @@clientLocation(Azure.AI.Projects.MemoryStores.deleteScope, MemoryStores);
  @@clientLocation(Azure.AI.Projects.MemoryStores.createMemory, MemoryStores);
  @@clientLocation(Azure.AI.Projects.MemoryStores.updateMemory, MemoryStores);
  @@clientLocation(Azure.AI.Projects.MemoryStores.getMemory, MemoryStores);
  @@clientLocation(Azure.AI.Projects.MemoryStores.listMemories, MemoryStores);
  @@clientLocation(Azure.AI.Projects.MemoryStores.deleteMemory, MemoryStores);

  interface Agents {}
  @@clientLocation(Azure.AI.Projects.AgentOptimizationJobs.create, Agents);
  @@clientLocation(Azure.AI.Projects.AgentOptimizationJobs.get, Agents);
  @@clientLocation(Azure.AI.Projects.AgentOptimizationJobs.list, Agents);
  @@clientLocation(Azure.AI.Projects.AgentOptimizationJobs.cancel, Agents);
  @@clientLocation(Azure.AI.Projects.AgentOptimizationJobs.delete, Agents);
}
