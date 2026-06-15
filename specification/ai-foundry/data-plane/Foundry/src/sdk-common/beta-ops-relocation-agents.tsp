// This file moves all beta operations (preview routes) from the Azure.AI.Projects namespace to
// a new namespace Azure.AI.Projects.Beta, thus creating a sub-client ".beta" in the emitted SDKs.
// It is imported by the client.tsp file, which is used for emitting the Python and JS clients.
// See https://azure.github.io/typespec-azure/docs/howtos/generate-client-libraries/03client/#move-all-operations-to-root-client

using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects.Beta;

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
@@clientLocation(Azure.AI.Projects.MemoryStores.listMemoryStores, MemoryStores);
@@clientLocation(
  Azure.AI.Projects.MemoryStores.deleteMemoryStore,
  MemoryStores
);
@@clientLocation(Azure.AI.Projects.MemoryStores.searchMemories, MemoryStores);
@@clientLocation(Azure.AI.Projects.MemoryStores.updateMemories, MemoryStores);
@@clientLocation(Azure.AI.Projects.MemoryStores.getUpdateResult, MemoryStores);
@@clientLocation(Azure.AI.Projects.MemoryStores.deleteScope, MemoryStores);
@@clientLocation(Azure.AI.Projects.MemoryStores.createMemory, MemoryStores);
@@clientLocation(Azure.AI.Projects.MemoryStores.updateMemory, MemoryStores);
@@clientLocation(Azure.AI.Projects.MemoryStores.getMemory, MemoryStores);
@@clientLocation(Azure.AI.Projects.MemoryStores.listMemories, MemoryStores);
@@clientLocation(Azure.AI.Projects.MemoryStores.deleteMemory, MemoryStores);

interface Toolboxes {}
@@clientLocation(Azure.AI.Projects.Toolboxes.createToolboxVersion, Toolboxes);
@@clientLocation(Azure.AI.Projects.Toolboxes.updateToolbox, Toolboxes);
@@clientLocation(Azure.AI.Projects.Toolboxes.getToolbox, Toolboxes);
@@clientLocation(Azure.AI.Projects.Toolboxes.listToolboxes, Toolboxes);
@@clientLocation(Azure.AI.Projects.Toolboxes.listToolboxVersions, Toolboxes);
@@clientLocation(Azure.AI.Projects.Toolboxes.getToolboxVersion, Toolboxes);
@@clientLocation(Azure.AI.Projects.Toolboxes.deleteToolbox, Toolboxes);
@@clientLocation(Azure.AI.Projects.Toolboxes.deleteToolboxVersion, Toolboxes);

interface Agents {}
@@clientLocation(Azure.AI.Projects.AgentSessionFiles.uploadSessionFile, Agents);
@@clientLocation(
  Azure.AI.Projects.AgentSessionFiles.downloadSessionFile,
  Agents
);
@@clientLocation(Azure.AI.Projects.AgentSessionFiles.listSessionFiles, Agents);
@@clientLocation(Azure.AI.Projects.AgentSessionFiles.deleteSessionFile, Agents);

@@clientLocation(Azure.AI.Projects.Agents.patchAgentObject, Agents);
@@clientLocation(Azure.AI.Projects.Agents.createSession, Agents);
@@clientLocation(Azure.AI.Projects.Agents.getSession, Agents);
@@clientLocation(Azure.AI.Projects.Agents.deleteSession, Agents);
@@clientLocation(Azure.AI.Projects.Agents.stopSession, Agents);
@@clientLocation(Azure.AI.Projects.Agents.listSessions, Agents);
@@clientLocation(Azure.AI.Projects.Agents.getSessionLogStream, Agents);
@@clientLocation(Azure.AI.Projects.Agents.createAgentFromCode, Agents);
@@clientLocation(Azure.AI.Projects.Agents.updateAgentFromCode, Agents);
@@clientLocation(Azure.AI.Projects.Agents.createAgentVersionFromCode, Agents);
@@clientLocation(Azure.AI.Projects.Agents.downloadAgentCode, Agents);

@@clientLocation(Azure.AI.Projects.AgentOptimizationJobs.create, Agents);
@@clientLocation(Azure.AI.Projects.AgentOptimizationJobs.get, Agents);
@@clientLocation(Azure.AI.Projects.AgentOptimizationJobs.list, Agents);
@@clientLocation(Azure.AI.Projects.AgentOptimizationJobs.cancel, Agents);
@@clientLocation(Azure.AI.Projects.AgentOptimizationJobs.delete, Agents);
