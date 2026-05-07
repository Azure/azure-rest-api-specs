// This file moves operations assigned to the beta SDK surface from the Azure.AI.Projects namespace
// to a new namespace Azure.AI.Projects.Beta, thus creating a sub-client ".beta" in the emitted SDKs.
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

namespace Mlflow {
  interface Experiments {}
  interface Runs {}
  interface Metrics {}
  interface Artifacts {}
  interface RegisteredModels {}
  interface ModelVersions {}
}

@@clientLocation(Azure.AI.Projects.Mlflow.Experiments.create,
  Mlflow.Experiments
);
@@clientLocation(Azure.AI.Projects.Mlflow.Experiments.get, Mlflow.Experiments);
@@clientLocation(Azure.AI.Projects.Mlflow.Experiments.getByName,
  Mlflow.Experiments
);
@@clientLocation(Azure.AI.Projects.Mlflow.Experiments.list, Mlflow.Experiments);
@@clientLocation(Azure.AI.Projects.Mlflow.Experiments.search,
  Mlflow.Experiments
);
@@clientLocation(Azure.AI.Projects.Mlflow.Experiments.update,
  Mlflow.Experiments
);
@@clientLocation(Azure.AI.Projects.Mlflow.Experiments.delete,
  Mlflow.Experiments
);
@@clientLocation(Azure.AI.Projects.Mlflow.Experiments.restore,
  Mlflow.Experiments
);
@@clientLocation(Azure.AI.Projects.Mlflow.Experiments.setTag,
  Mlflow.Experiments
);

@@clientLocation(Azure.AI.Projects.Mlflow.Runs.create, Mlflow.Runs);
@@clientLocation(Azure.AI.Projects.Mlflow.Runs.get, Mlflow.Runs);
@@clientLocation(Azure.AI.Projects.Mlflow.Runs.search, Mlflow.Runs);
@@clientLocation(Azure.AI.Projects.Mlflow.Runs.update, Mlflow.Runs);
@@clientLocation(Azure.AI.Projects.Mlflow.Runs.delete, Mlflow.Runs);
@@clientLocation(Azure.AI.Projects.Mlflow.Runs.restore, Mlflow.Runs);
@@clientLocation(Azure.AI.Projects.Mlflow.Runs.logBatch, Mlflow.Runs);
@@clientLocation(Azure.AI.Projects.Mlflow.Runs.logMetric, Mlflow.Runs);
@@clientLocation(Azure.AI.Projects.Mlflow.Runs.logParameter, Mlflow.Runs);
@@clientLocation(Azure.AI.Projects.Mlflow.Runs.setTag, Mlflow.Runs);
@@clientLocation(Azure.AI.Projects.Mlflow.Runs.deleteTag, Mlflow.Runs);
@@clientLocation(Azure.AI.Projects.Mlflow.Runs.logModel, Mlflow.Runs);
@@clientLocation(Azure.AI.Projects.Mlflow.Runs.logInputs, Mlflow.Runs);

@@clientLocation(Azure.AI.Projects.Mlflow.Metrics.getHistory, Mlflow.Metrics);

@@clientLocation(Azure.AI.Projects.Mlflow.Artifacts.list, Mlflow.Artifacts);

@@clientLocation(Azure.AI.Projects.Mlflow.RegisteredModels.create,
  Mlflow.RegisteredModels
);
@@clientLocation(Azure.AI.Projects.Mlflow.RegisteredModels.update,
  Mlflow.RegisteredModels
);
@@clientLocation(Azure.AI.Projects.Mlflow.RegisteredModels.delete,
  Mlflow.RegisteredModels
);
@@clientLocation(Azure.AI.Projects.Mlflow.RegisteredModels.get,
  Mlflow.RegisteredModels
);
@@clientLocation(Azure.AI.Projects.Mlflow.RegisteredModels.list,
  Mlflow.RegisteredModels
);
@@clientLocation(Azure.AI.Projects.Mlflow.RegisteredModels.search,
  Mlflow.RegisteredModels
);
@@clientLocation(Azure.AI.Projects.Mlflow.RegisteredModels.setTag,
  Mlflow.RegisteredModels
);
@@clientLocation(Azure.AI.Projects.Mlflow.RegisteredModels.deleteTag,
  Mlflow.RegisteredModels
);
@@clientLocation(Azure.AI.Projects.Mlflow.RegisteredModels.getLatestVersions,
  Mlflow.RegisteredModels
);
@@clientLocation(Azure.AI.Projects.Mlflow.RegisteredModels.getLatestVersionsNameInBody,
  Mlflow.RegisteredModels
);
@@clientLocation(Azure.AI.Projects.Mlflow.RegisteredModels.rename,
  Mlflow.RegisteredModels
);

@@clientLocation(Azure.AI.Projects.Mlflow.ModelVersions.create,
  Mlflow.ModelVersions
);
@@clientLocation(Azure.AI.Projects.Mlflow.ModelVersions.update,
  Mlflow.ModelVersions
);
@@clientLocation(Azure.AI.Projects.Mlflow.ModelVersions.transitionStage,
  Mlflow.ModelVersions
);
@@clientLocation(Azure.AI.Projects.Mlflow.ModelVersions.delete,
  Mlflow.ModelVersions
);
@@clientLocation(Azure.AI.Projects.Mlflow.ModelVersions.get,
  Mlflow.ModelVersions
);
@@clientLocation(Azure.AI.Projects.Mlflow.ModelVersions.search,
  Mlflow.ModelVersions
);
@@clientLocation(Azure.AI.Projects.Mlflow.ModelVersions.searchWithFilter,
  Mlflow.ModelVersions
);
@@clientLocation(Azure.AI.Projects.Mlflow.ModelVersions.getDownloadUri,
  Mlflow.ModelVersions
);
@@clientLocation(Azure.AI.Projects.Mlflow.ModelVersions.setTag,
  Mlflow.ModelVersions
);
@@clientLocation(Azure.AI.Projects.Mlflow.ModelVersions.deleteTag,
  Mlflow.ModelVersions
);
@@clientLocation(Azure.AI.Projects.Mlflow.ModelVersions.getStorageLocationUri,
  Mlflow.ModelVersions
);

interface TrainingJobs {}

@@clientLocation(Azure.AI.Projects.TrainingJobs.create, TrainingJobs);
@@clientLocation(Azure.AI.Projects.TrainingJobs.list, TrainingJobs);
@@clientLocation(Azure.AI.Projects.TrainingJobs.get, TrainingJobs);
@@clientLocation(Azure.AI.Projects.TrainingJobs.beginDelete, TrainingJobs);
@@clientLocation(Azure.AI.Projects.TrainingJobs.beginCancel, TrainingJobs);
@@clientLocation(Azure.AI.Projects.TrainingJobs.showServices, TrainingJobs);

@@clientLocation(Azure.AI.Projects.TrainingJobOperations.getOperationResult,
  TrainingJobs
);
@@clientLocation(Azure.AI.Projects.TrainingJobOperations.getOperationStatus,
  TrainingJobs
);

@@clientLocation(Azure.AI.Projects.TrainingJobAttempts.listAttempts,
  TrainingJobs
);
@@clientLocation(Azure.AI.Projects.TrainingJobAttempts.getAttempt,
  TrainingJobs
);

@@clientLocation(Azure.AI.Projects.TrainingJobAttemptArtifacts.listAttemptArtifacts,
  TrainingJobs
);
@@clientLocation(Azure.AI.Projects.TrainingJobAttemptArtifacts.getAttemptArtifactMetadata,
  TrainingJobs
);
@@clientLocation(Azure.AI.Projects.TrainingJobAttemptArtifacts.getAttemptArtifactContentInfo,
  TrainingJobs
);
@@clientLocation(Azure.AI.Projects.TrainingJobAttemptArtifacts.getAttemptArtifactContentInfoByPrefix,
  TrainingJobs
);
@@clientLocation(Azure.AI.Projects.TrainingJobAttemptArtifacts.downloadAttemptArtifact,
  TrainingJobs
);

@@clientLocation(Azure.AI.Projects.TrainingJobAttemptMetrics.listAttemptMetrics,
  TrainingJobs
);
@@clientLocation(Azure.AI.Projects.TrainingJobAttemptMetrics.getAttemptMetricLastValues,
  TrainingJobs
);
@@clientLocation(Azure.AI.Projects.TrainingJobAttemptMetrics.getAttemptMetric,
  TrainingJobs
);
@@clientLocation(Azure.AI.Projects.TrainingJobAttemptMetrics.getAttemptMetricAggregates,
  TrainingJobs
);
@@clientLocation(Azure.AI.Projects.TrainingJobAttemptMetrics.getAttemptMetricSamples,
  TrainingJobs
);
@@clientLocation(Azure.AI.Projects.TrainingJobAttemptMetrics.getAttemptMetricSample,
  TrainingJobs
);

@@clientLocation(Azure.AI.Projects.TrainingJobOutputs.listOutputs,
  TrainingJobs
);
@@clientLocation(Azure.AI.Projects.TrainingJobOutputs.getOutput, TrainingJobs);

@@clientLocation(Azure.AI.Projects.TrainingJobAttemptOutputs.listAttemptOutputs,
  TrainingJobs
);
@@clientLocation(Azure.AI.Projects.TrainingJobAttemptOutputs.getAttemptOutput,
  TrainingJobs
);
