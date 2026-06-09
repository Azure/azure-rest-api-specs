// This file moves all beta operations (preview routes) from the Azure.AI.Projects namespace to
// a new namespace Azure.AI.Projects.Beta, thus creating a sub-client ".beta" in the emitted SDKs.
// It is imported by the client.tsp file, which is used for emitting the Python and JS clients.
// See https://azure.github.io/typespec-azure/docs/howtos/generate-client-libraries/03client/#move-all-operations-to-root-client

using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects.Beta;

interface Models {}
@@clientLocation(Azure.AI.Projects.Models.listVersions, Models);
@@clientLocation(Azure.AI.Projects.Models.listLatest, Models);
@@clientLocation(Azure.AI.Projects.Models.getVersion, Models);
@@clientLocation(Azure.AI.Projects.Models.deleteVersion, Models);
@@clientLocation(Azure.AI.Projects.Models.createOrUpdateVersion, Models);
@@clientLocation(Azure.AI.Projects.Models.createAsync, Models);
@@clientLocation(Azure.AI.Projects.Models.startPendingUpload, Models);
@@clientLocation(Azure.AI.Projects.Models.getCredentials, Models);

interface Evaluators {}
@@clientLocation(Azure.AI.Projects.Evaluators.listVersions, Evaluators);
@@clientLocation(Azure.AI.Projects.Evaluators.listLatestVersions, Evaluators);
@@clientLocation(Azure.AI.Projects.Evaluators.getVersion, Evaluators);
@@clientLocation(Azure.AI.Projects.Evaluators.deleteVersion, Evaluators);
@@clientLocation(Azure.AI.Projects.Evaluators.createVersion, Evaluators);
@@clientLocation(Azure.AI.Projects.Evaluators.updateVersion, Evaluators);
@@clientLocation(Azure.AI.Projects.Evaluators.startPendingUpload, Evaluators);
@@clientLocation(Azure.AI.Projects.Evaluators.getCredentials, Evaluators);

@@clientLocation(Azure.AI.Projects.EvaluatorGenerationJobs.create, Evaluators);
@@clientLocation(Azure.AI.Projects.EvaluatorGenerationJobs.get, Evaluators);
@@clientLocation(Azure.AI.Projects.EvaluatorGenerationJobs.list, Evaluators);
@@clientLocation(Azure.AI.Projects.EvaluatorGenerationJobs.cancel, Evaluators);
@@clientLocation(Azure.AI.Projects.EvaluatorGenerationJobs.delete, Evaluators);

// These were removed from v1:
// @@clientLocation(Azure.AI.Projects.EvaluationSuites.listVersions, Evaluators);
// @@clientLocation(Azure.AI.Projects.EvaluationSuites.listLatest, Evaluators);
// @@clientLocation(Azure.AI.Projects.EvaluationSuites.getVersion, Evaluators);
// @@clientLocation(Azure.AI.Projects.EvaluationSuites.deleteVersion, Evaluators);
// @@clientLocation(Azure.AI.Projects.EvaluationSuites.createOrUpdateVersion, Evaluators);
// @@clientLocation(Azure.AI.Projects.EvaluationSuites.createEvaluationSuiteVersion, Evaluators);
// @@clientLocation(Azure.AI.Projects.EvaluationSuites.run, Evaluators);

// @@clientLocation(Azure.AI.Projects.EvaluationSuiteGenerationJobs.create, Evaluators);
// @@clientLocation(Azure.AI.Projects.EvaluationSuiteGenerationJobs.get, Evaluators);
// @@clientLocation(Azure.AI.Projects.EvaluationSuiteGenerationJobs.list, Evaluators);
// @@clientLocation(Azure.AI.Projects.EvaluationSuiteGenerationJobs.cancel, Evaluators);
// @@clientLocation(Azure.AI.Projects.EvaluationSuiteGenerationJobs.delete, Evaluators);

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
@@clientLocation(
  Azure.AI.Projects.EvaluationTaxonomies.get,
  EvaluationTaxonomies
);
@@clientLocation(
  Azure.AI.Projects.EvaluationTaxonomies.list,
  EvaluationTaxonomies
);
@@clientLocation(
  Azure.AI.Projects.EvaluationTaxonomies.delete,
  EvaluationTaxonomies
);
@@clientLocation(
  Azure.AI.Projects.EvaluationTaxonomies.create,
  EvaluationTaxonomies
);
@@clientLocation(
  Azure.AI.Projects.EvaluationTaxonomies.update,
  EvaluationTaxonomies
);

interface Skills {}
@@clientLocation(Azure.AI.Projects.Skills.createSkillVersion, Skills);
@@clientLocation(Azure.AI.Projects.Skills.createSkillVersionFromFiles, Skills);
@@clientLocation(Azure.AI.Projects.Skills.getSkill, Skills);
@@clientLocation(Azure.AI.Projects.Skills.getSkillContent, Skills);
@@clientLocation(Azure.AI.Projects.Skills.listSkills, Skills);
@@clientLocation(Azure.AI.Projects.Skills.updateSkill, Skills);
@@clientLocation(Azure.AI.Projects.Skills.deleteSkill, Skills);
@@clientLocation(Azure.AI.Projects.Skills.listSkillVersions, Skills);
@@clientLocation(Azure.AI.Projects.Skills.getSkillVersion, Skills);
@@clientLocation(Azure.AI.Projects.Skills.getSkillVersionContent, Skills);
@@clientLocation(Azure.AI.Projects.Skills.deleteSkillVersion, Skills);

interface Datasets {}
@@clientLocation(Azure.AI.Projects.DataGenerationJobs.get, Datasets);
@@clientLocation(Azure.AI.Projects.DataGenerationJobs.list, Datasets);
@@clientLocation(Azure.AI.Projects.DataGenerationJobs.create, Datasets);
@@clientLocation(Azure.AI.Projects.DataGenerationJobs.cancel, Datasets);
@@clientLocation(Azure.AI.Projects.DataGenerationJobs.delete, Datasets);

interface Routines {}
@@clientLocation(Azure.AI.Projects.Routines.createOrUpdateRoutine, Routines);
@@clientLocation(Azure.AI.Projects.Routines.getRoutine, Routines);
@@clientLocation(Azure.AI.Projects.Routines.enableRoutine, Routines);
@@clientLocation(Azure.AI.Projects.Routines.disableRoutine, Routines);
@@clientLocation(Azure.AI.Projects.Routines.listRoutines, Routines);
@@clientLocation(Azure.AI.Projects.Routines.deleteRoutine, Routines);
@@clientLocation(Azure.AI.Projects.Routines.listRoutineRuns, Routines);
@@clientLocation(Azure.AI.Projects.Routines.dispatchRoutineAsync, Routines);
