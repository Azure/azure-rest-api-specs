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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "specified in routes.tsp"
  createProject is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.createProject;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "specified in routes.tsp"
  deleteProject is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.deleteProject;
  @access(Access.internal, "python")
  getDeleteStatus is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.getDeleteStatus;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "specified in routes.tsp"
  export is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.export;
  @access(Access.internal, "python")
  getExportStatus is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.getExportStatus;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "specified in routes.tsp"
  // Preserve previous Python method name to avoid breaking change: begin_import_assets
  @clientName("begin_import_assets", "python")
  `import` is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.`import`;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "specified in routes.tsp"
  #suppress "@azure-tools/typespec-azure-core/byos" "specified in routes.tsp"
  importFromFiles is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.importFromFiles;
  @access(Access.internal, "python")
  getImportStatus is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.getImportStatus;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "specified in routes.tsp"
  deployProject is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.deployProject;
  @access(Access.internal, "python")
  getDeployStatus is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.getDeployStatus;
  listDeployments is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.listDeployments;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "specified in routes.tsp"
  @clientName("list_synonyms", "python")
  getSynonyms is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.getSynonyms;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "specified in routes.tsp"
  updateSynonyms is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.updateSynonyms;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "specified in routes.tsp"
  @clientName("list_sources", "python")
  getSources is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.getSources;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "specified in routes.tsp"
  updateSources is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.updateSources;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "specified in routes.tsp"
  #suppress "@azure-tools/typespec-azure-core/byos" "specified in routes.tsp"
  updateSourcesFromFiles is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.updateSourcesFromFiles;
  @access(Access.internal, "python")
  getUpdateSourcesStatus is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.getUpdateSourcesStatus;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "specified in routes.tsp"
  @clientName("list_qnas", "python")
  getQnas is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.getQnas;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "specified in routes.tsp"
  updateQnas is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.updateQnas;
  @access(Access.internal, "python")
  getUpdateQnasStatus is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.getUpdateQnasStatus;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "specified in routes.tsp"
  addFeedback is Language.QuestionAnswering.Authoring.QuestionAnsweringProjects.addFeedback;
}

@@clientName(QuestionAnsweringProjectMetadata, "QuestionAnsweringProject");
@@clientName(ExportQueryParameters.format, "fileFormat", "python");
@@clientName(ImportQueryParameters.format, "fileFormat", "python");
@@clientName(AssestKind, "AssetKind");
