import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";


using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using Language.QuestionAnswering.Authoring;

@useDependency(Versions.v2025_05_15_preview)
namespace Language.QuestionAnsweringAuthoringClientCustomizations;

@client({
  name: "QuestionAnsweringAuthoringClient",
  service: Language.QuestionAnswering.Authoring,
})
interface QuestionAnsweringAuthoringClientOperations {
  listProjects is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.listProjects;
  getProjectDetails is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.getProjectDetails;
  createProject is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.createProject;
  deleteProject is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.deleteProject;
  getDeleteStatus is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.getDeleteStatus;
  export is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.export;
  getExportStatus is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.getExportStatus;
  `import` is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.`import`;
  importFromFiles is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.importFromFiles;
  getImportStatus is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.getImportStatus;
  deployProject is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.deployProject;
  getDeployStatus is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.getDeployStatus;
  listDeployments is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.listDeployments;
  getSynonyms is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.getSynonyms;
  updateSynonyms is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.updateSynonyms;
  getSources is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.getSources;
  updateSources is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.updateSources;
  updateSourcesFromFiles is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.updateSourcesFromFiles;
  getUpdateSourcesStatus is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.getUpdateSourcesStatus;
  getQnas is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.getQnas;
  updateQnas is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.updateQnas;
  getUpdateQnasStatus is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.getUpdateQnasStatus;
  addFeedback is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.addFeedback;
}