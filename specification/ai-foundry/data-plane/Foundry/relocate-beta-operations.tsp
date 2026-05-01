// This file moves all beta operations (preview routes) from the Azure.AI.Projects namespace to
// a new namespace Azure.AI.Projects.Beta, thus creating a sub-client ".beta" in the emitted SDKs.
// It is imported by the client.tsp file, which is used for emitting the Python and JS clients.
// See https://azure.github.io/typespec-azure/docs/howtos/generate-client-libraries/03client/#move-all-operations-to-root-client

using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects.Beta;

interface MemoryStores {}
@@clientLocation(Azure.AI.Projects.MemoryStores.createMemoryStore,
  MemoryStores
);
@@clientLocation(Azure.AI.Projects.MemoryStores.updateMemoryStore,
  MemoryStores
);
@@clientLocation(Azure.AI.Projects.MemoryStores.getMemoryStore, MemoryStores);
@@clientLocation(Azure.AI.Projects.MemoryStores.listMemoryStores, MemoryStores);
@@clientLocation(Azure.AI.Projects.MemoryStores.deleteMemoryStore,
  MemoryStores
);
@@clientLocation(Azure.AI.Projects.MemoryStores.searchMemories, MemoryStores);
@@clientLocation(Azure.AI.Projects.MemoryStores.updateMemories, MemoryStores);
@@clientLocation(Azure.AI.Projects.MemoryStores.getUpdateResult, MemoryStores);
@@clientLocation(Azure.AI.Projects.MemoryStores.deleteScope, MemoryStores);

interface Evaluators {}
@@clientLocation(Azure.AI.Projects.Evaluators.listVersions, Evaluators);
@@clientLocation(Azure.AI.Projects.Evaluators.listLatestVersions, Evaluators);
@@clientLocation(Azure.AI.Projects.Evaluators.getVersion, Evaluators);
@@clientLocation(Azure.AI.Projects.Evaluators.deleteVersion, Evaluators);
@@clientLocation(Azure.AI.Projects.Evaluators.createVersion, Evaluators);
@@clientLocation(Azure.AI.Projects.Evaluators.updateVersion, Evaluators);

interface EvaluationSuites {}
@@clientLocation(Azure.AI.Projects.EvaluationSuites.listVersions, EvaluationSuites);
@@clientLocation(Azure.AI.Projects.EvaluationSuites.listLatest, EvaluationSuites);
@@clientLocation(Azure.AI.Projects.EvaluationSuites.getVersion, EvaluationSuites);
@@clientLocation(Azure.AI.Projects.EvaluationSuites.deleteVersion, EvaluationSuites);
@@clientLocation(Azure.AI.Projects.EvaluationSuites.createOrUpdateVersion, EvaluationSuites);
@@clientLocation(Azure.AI.Projects.EvaluationSuites.createEvaluationSuiteVersion, EvaluationSuites);
@@clientLocation(Azure.AI.Projects.EvaluationSuites.run, EvaluationSuites);

// Evaluation suite generation jobs — nested under EvaluationSuites sub-client
@@clientLocation(Azure.AI.Projects.EvaluationSuiteGenerationJobs.create, EvaluationSuites);
@@clientLocation(Azure.AI.Projects.EvaluationSuiteGenerationJobs.get, EvaluationSuites);
@@clientLocation(Azure.AI.Projects.EvaluationSuiteGenerationJobs.list, EvaluationSuites);
@@clientLocation(Azure.AI.Projects.EvaluationSuiteGenerationJobs.cancel, EvaluationSuites);
@@clientLocation(Azure.AI.Projects.EvaluationSuiteGenerationJobs.delete, EvaluationSuites);

interface Schedules {}
@@clientLocation(Azure.AI.Projects.Schedules.delete, Schedules);
@@clientLocation(Azure.AI.Projects.Schedules.get, Schedules);
@@clientLocation(Azure.AI.Projects.Schedules.list, Schedules);
@@clientLocation(Azure.AI.Projects.Schedules.createOrUpdate, Schedules);
@@clientLocation(Azure.AI.Projects.Schedules.getRun, Schedules);
@@clientLocation(Azure.AI.Projects.Schedules.listRuns, Schedules);

interface RedTeams {}
@@clientLocation(Azure.AI.Projects.RedTeams.get, RedTeams);
@@clientLocation(Azure.AI.Projects.RedTeams.list, RedTeams);
@@clientLocation(Azure.AI.Projects.RedTeams.create, RedTeams);

interface Insights {}
@@clientLocation(Azure.AI.Projects.Insights.generate, Insights);
@@clientLocation(Azure.AI.Projects.Insights.get, Insights);
@@clientLocation(Azure.AI.Projects.Insights.list, Insights);

interface EvaluationTaxonomies {}
@@clientLocation(Azure.AI.Projects.EvaluationTaxonomies.get,
  EvaluationTaxonomies
);
@@clientLocation(Azure.AI.Projects.EvaluationTaxonomies.list,
  EvaluationTaxonomies
);
@@clientLocation(Azure.AI.Projects.EvaluationTaxonomies.delete,
  EvaluationTaxonomies
);
@@clientLocation(Azure.AI.Projects.EvaluationTaxonomies.create,
  EvaluationTaxonomies
);
@@clientLocation(Azure.AI.Projects.EvaluationTaxonomies.update,
  EvaluationTaxonomies
);

interface Toolboxes {}
@@clientLocation(Azure.AI.Projects.Toolboxes.createToolboxVersion, Toolboxes);
@@clientLocation(Azure.AI.Projects.Toolboxes.updateToolbox, Toolboxes);
@@clientLocation(Azure.AI.Projects.Toolboxes.getToolbox, Toolboxes);
@@clientLocation(Azure.AI.Projects.Toolboxes.listToolboxes, Toolboxes);
@@clientLocation(Azure.AI.Projects.Toolboxes.listToolboxVersions, Toolboxes);
@@clientLocation(Azure.AI.Projects.Toolboxes.getToolboxVersion, Toolboxes);
@@clientLocation(Azure.AI.Projects.Toolboxes.deleteToolbox, Toolboxes);
@@clientLocation(Azure.AI.Projects.Toolboxes.deleteToolboxVersion, Toolboxes);

interface Skills {}
@@clientLocation(Azure.AI.Projects.Skills.createSkill, Skills);
@@clientLocation(Azure.AI.Projects.Skills.createSkillFromPackage, Skills);
@@clientLocation(Azure.AI.Projects.Skills.getSkill, Skills);
@@clientLocation(Azure.AI.Projects.Skills.downloadSkill, Skills);
@@clientLocation(Azure.AI.Projects.Skills.listSkills, Skills);
@@clientLocation(Azure.AI.Projects.Skills.updateSkill, Skills);
@@clientLocation(Azure.AI.Projects.Skills.deleteSkill, Skills);

interface Agents {}
// Move AgentSessionFiles
@@clientLocation(Azure.AI.Projects.AgentSessionFiles.uploadSessionFile, Agents);
@@clientLocation(Azure.AI.Projects.AgentSessionFiles.downloadSessionFile,
  Agents
);
@@clientLocation(Azure.AI.Projects.AgentSessionFiles.listSessionFiles, Agents);
@@clientLocation(Azure.AI.Projects.AgentSessionFiles.deleteSessionFile, Agents);
// Move preview operations out of root Agent into Beta Agents
@@clientLocation(Azure.AI.Projects.Agents.patchAgentObject, Agents);
@@clientLocation(Azure.AI.Projects.Agents.createSession, Agents);
@@clientLocation(Azure.AI.Projects.Agents.getSession, Agents);
@@clientLocation(Azure.AI.Projects.Agents.deleteSession, Agents);
@@clientLocation(Azure.AI.Projects.Agents.listSessions, Agents);
@@clientLocation(Azure.AI.Projects.Agents.getSessionLogStream, Agents);

interface Datasets {}

// Data generation jobs → nested under datasets sub-client
@@clientLocation(Azure.AI.Projects.DataGenerationJobs.get, Datasets);
@@clientLocation(Azure.AI.Projects.DataGenerationJobs.list, Datasets);
@@clientLocation(Azure.AI.Projects.DataGenerationJobs.create, Datasets);
@@clientLocation(Azure.AI.Projects.DataGenerationJobs.cancel, Datasets);
@@clientLocation(Azure.AI.Projects.DataGenerationJobs.delete, Datasets);
