// This file moves all beta operations (preview routes) from the Azure.AI.Projects namespace to
// a new namespace Azure.AI.Projects.Beta, thus creating a sub-client ".beta" in the emitted SDKs.
// It is imported by the client.tsp file, which is used for emitting the Python and JS clients.
// See https://azure.github.io/typespec-azure/docs/howtos/generate-client-libraries/03client/#move-all-operations-to-root-client

import "./ops-relocation-evaluators.tsp";

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

interface Routines {}
@@clientLocation(Azure.AI.Projects.Routines.createOrUpdateRoutine, Routines);
@@clientLocation(Azure.AI.Projects.Routines.getRoutine, Routines);
@@clientLocation(Azure.AI.Projects.Routines.enableRoutine, Routines);
@@clientLocation(Azure.AI.Projects.Routines.disableRoutine, Routines);
@@clientLocation(Azure.AI.Projects.Routines.listRoutines, Routines);
@@clientLocation(Azure.AI.Projects.Routines.deleteRoutine, Routines);
@@clientLocation(Azure.AI.Projects.Routines.listRoutineRuns, Routines);
@@clientLocation(Azure.AI.Projects.Routines.dispatchRoutineAsync, Routines);
