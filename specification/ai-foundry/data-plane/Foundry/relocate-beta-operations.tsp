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
@@clientLocation(Azure.AI.Projects.Evaluators.startPendingUpload, Evaluators);
@@clientLocation(Azure.AI.Projects.Evaluators.getCredentials, Evaluators);

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

interface Toolsets {}
@@clientLocation(Azure.AI.Projects.Toolsets.createToolset, Toolsets);
@@clientLocation(Azure.AI.Projects.Toolsets.updateToolset, Toolsets);
@@clientLocation(Azure.AI.Projects.Toolsets.getToolset, Toolsets);
@@clientLocation(Azure.AI.Projects.Toolsets.listToolsets, Toolsets);
@@clientLocation(Azure.AI.Projects.Toolsets.deleteToolset, Toolsets);

interface Jobs {}
interface JobAttempts {}
interface JobArtifacts {}
interface JobAttemptArtifacts {}
interface JobMetrics {}
interface JobAttemptMetrics {}
interface JobOutputs {}
interface JobAttemptOutputs {}
interface Models {}

@@clientLocation(Azure.AI.Projects.Jobs.createTrainingJob, Models);
@@clientLocation(Azure.AI.Projects.Jobs.list, Jobs);
@@clientLocation(Azure.AI.Projects.Jobs.get, Jobs);
@@clientLocation(Azure.AI.Projects.Jobs.beginDelete, Jobs);
@@clientLocation(Azure.AI.Projects.Jobs.beginCancel, Jobs);

@@clientLocation(Azure.AI.Projects.JobAttempts.listJobAttempts, JobAttempts);
@@clientLocation(Azure.AI.Projects.JobAttempts.getJobAttempt, JobAttempts);

@@clientLocation(Azure.AI.Projects.JobArtifacts.listJobArtifacts, JobArtifacts);
@@clientLocation(Azure.AI.Projects.JobArtifacts.getJobArtifactMetadata,
  JobArtifacts
);
@@clientLocation(Azure.AI.Projects.JobArtifacts.getJobArtifactContentInfo,
  JobArtifacts
);
@@clientLocation(Azure.AI.Projects.JobArtifacts.downloadJobArtifact,
  JobArtifacts
);

@@clientLocation(Azure.AI.Projects.JobAttemptArtifacts.listJobAttemptArtifacts,
  JobAttemptArtifacts
);
@@clientLocation(Azure.AI.Projects.JobAttemptArtifacts.getJobAttemptArtifactMetadata,
  JobAttemptArtifacts
);
@@clientLocation(Azure.AI.Projects.JobAttemptArtifacts.getJobAttemptArtifactContentInfo,
  JobAttemptArtifacts
);
@@clientLocation(Azure.AI.Projects.JobAttemptArtifacts.downloadJobAttemptArtifact,
  JobAttemptArtifacts
);

@@clientLocation(Azure.AI.Projects.JobMetrics.listJobMetrics, JobMetrics);
@@clientLocation(Azure.AI.Projects.JobMetrics.getJobMetricLastValues,
  JobMetrics
);
@@clientLocation(Azure.AI.Projects.JobMetrics.getJobMetric, JobMetrics);
@@clientLocation(Azure.AI.Projects.JobMetrics.getJobMetricAggregates,
  JobMetrics
);
@@clientLocation(Azure.AI.Projects.JobMetrics.getJobMetricSamples,
  JobMetrics
);
@@clientLocation(Azure.AI.Projects.JobMetrics.getJobMetricSample,
  JobMetrics
);

@@clientLocation(Azure.AI.Projects.JobAttemptMetrics.listJobAttemptMetrics,
  JobAttemptMetrics
);
@@clientLocation(Azure.AI.Projects.JobAttemptMetrics.getJobAttemptMetricLastValues,
  JobAttemptMetrics
);
@@clientLocation(Azure.AI.Projects.JobAttemptMetrics.getJobAttemptMetric,
  JobAttemptMetrics
);
@@clientLocation(Azure.AI.Projects.JobAttemptMetrics.getJobAttemptMetricAggregates,
  JobAttemptMetrics
);
@@clientLocation(Azure.AI.Projects.JobAttemptMetrics.getJobAttemptMetricSamples,
  JobAttemptMetrics
);
@@clientLocation(Azure.AI.Projects.JobAttemptMetrics.getJobAttemptMetricSample,
  JobAttemptMetrics
);

@@clientLocation(Azure.AI.Projects.JobOutputs.listJobOutputs, JobOutputs);
@@clientLocation(Azure.AI.Projects.JobOutputs.getJobOutput, JobOutputs);

@@clientLocation(Azure.AI.Projects.JobAttemptOutputs.listJobAttemptOutputs,
  JobAttemptOutputs
);
@@clientLocation(Azure.AI.Projects.JobAttemptOutputs.getJobAttemptOutput,
  JobAttemptOutputs
);
