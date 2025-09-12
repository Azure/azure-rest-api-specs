import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using Language.Text.Authoring;
using Azure.ClientGenerator.Core;
using Versioning;

@useDependency(Language.Text.Authoring.Versions.v2025_05_15_preview)
namespace Language.TextAuthingClientCustomizations;

@@clientName(textAnalysisAuthoringListProjects, "listProjects");
@@clientName(textAnalysisAuthoringListDeployments, "listDeployments");
@@clientName(textAnalysisAuthoringListExportedModels, "listExportedModels");
@@clientName(textAnalysisAuthoringListTrainedModels, "listTrainedModels");
@@clientName(textAnalysisAuthoringListDeploymentResources, "listDeploymentResources");
@@clientName(textAnalysisAuthoringListTrainingJobs, "listTrainingJobs");
@@clientName(textAnalysisAuthoringListAssignedResourceDeployments, "listAssignedResourceDeployments");
@@clientName(textAnalysisAuthoringGetSupportedLanguages, "getSupportedLanguages");
@@clientName(textAnalysisAuthoringGetSupportedPrebuiltEntities, "getSupportedPrebuiltEntities");
@@clientName(textAnalysisAuthoringListTrainingConfigVersions, "listTrainingConfigVersions");
@@clientName(TextAuthoringProject.copyProjectAuthorization, "AuthorizeProjectCopy");

@@clientName(ProjectKind, "TextAuthoringProjectKind");
@@clientName(ProjectKind, "ProjectKind", "python");
@@clientName(ErrorCode, "TextAuthoringErrorCode");
@@clientName(ErrorCode, "ErrorCode", "python");
@@clientName(InnerErrorCode, "TextAuthoringInnerErrorCode");
@@clientName(InnerErrorCode, "InnerErrorCode", "python");
@@clientName(StringIndexType, "StringIndexType");
@@clientName(EvaluationKind, "TextAuthoringEvaluationKind");
@@clientName(EvaluationKind, "EvaluationKind", "python");
@@clientName(JobStatus, "TextAuthoringOperationStatus");
@@clientName(JobStatus, "OperationStatus", "python");
@@clientName(Sentiment, "TextAuthoringSentiment");
@@clientName(Sentiment, "Sentiment", "python");
@@clientName(CompositionSetting, "TextAuthoringCompositionMode");
@@clientName(CompositionSetting, "CompositionMode", "python");
@@clientName(TextAnalysisAuthoringProjectsMetadata, "TextAuthoringProjectsMetadata");
@@clientName(TextAnalysisAuthoringProjectsMetadata, "ProjectsMetadata", "python");
@@clientName(TextAnalysisAuthoringProjectMetadata, "TextAuthoringProjectMetadata");
@@clientName(TextAnalysisAuthoringProjectMetadata, "ProjectDetails", "python");
@@clientName(TextAnalysisAuthoringProjectMetadata.createdDateTime, "createdOn");
@@clientName(TextAnalysisAuthoringProjectMetadata.lastModifiedDateTime, "lastModifiedOn");
@@clientName(TextAnalysisAuthoringProjectMetadata.lastTrainedDateTime, "lastTrainedOn");
@@clientName(TextAnalysisAuthoringProjectMetadata.lastDeployedDateTime, "lastDeployedOn");
@@clientName(TextAnalysisAuthoringProjectSettings, "TextAuthoringProjectSettings");
@@clientName(TextAnalysisAuthoringProjectSettings, "ProjectSettings", "python");
@@clientName(Error, "TextAuthoringError");
@@clientName(Error, "Error", "python");
@@clientName(InnerErrorModel, "TextAuthoringInnerErrorModel");
@@clientName(InnerErrorModel, "InnerErrorModel", "python");
@@clientName(TextAnalysisAuthoringCreateProjectOptions, "TextAuthoringCreateProjectDetails");
@@clientName(TextAnalysisAuthoringCreateProjectOptions, "CreateProjectOptions", "python");
@@clientName(TextAnalysisAuthoringCopyAuthorizationOptions, "TextAuthoringCopyAuthorizationDetails");
@@clientName(TextAnalysisAuthoringCopyAuthorizationOptions, "CopyAuthorizationDetails", "python");
@@clientName(TextAnalysisAuthoringCopyProjectOptions, "TextAuthoringCopyProjectDetails");
@@clientName(TextAnalysisAuthoringCopyProjectOptions, "CopyProjectDetails", "python");
@@clientName(TextAnalysisAuthoringExportedProject, "TextAuthoringExportedProject");
@@clientName(TextAnalysisAuthoringExportedProject, "ExportedProject", "python");
@@clientName(TextAnalysisAuthoringExportedProjectAssets, "TextAuthoringExportedProjectAsset");
@@clientName(TextAnalysisAuthoringExportedProjectAssets, "ExportedProjectAsset", "python");
@@clientName(TextAnalysisAuthoringTrainingJobOptions, "TextAuthoringTrainingJobDetails");
@@clientName(TextAnalysisAuthoringTrainingJobOptions, "TrainingJobDetails", "python");
@@clientName(TextAnalysisAuthoringDataGenerationSettings, "DataGenerationSetting");
@@clientName(TextAnalysisAuthoringDataGenerationConnectionInfo, "DataGenerationConnectionInfo");
@@clientName(TextAnalysisAuthoringEvaluationOptions, "TextAuthoringEvaluationDetails");
@@clientName(TextAnalysisAuthoringEvaluationOptions, "EvaluationDetails", "python");
@@clientName(TextAnalysisAuthoringCopyProjectJobState, "TextAuthoringCopyProjectState");
@@clientName(TextAnalysisAuthoringCopyProjectJobState, "CopyProjectState", "python");
@@clientName(TextAnalysisAuthoringJobState, "TextAuthoringState");
@@clientName(TextAnalysisAuthoringJobState, "State", "python");
@@clientName(TextAnalysisAuthoringJobState.createdDateTime, "createdOn");
@@clientName(TextAnalysisAuthoringJobState.lastUpdatedDateTime, "lastUpdatedOn");
@@clientName(TextAnalysisAuthoringJobState.expirationDateTime, "expiresOn");
@@clientName(TextAnalysisAuthoringProjectDeployments, "TextAuthoringProjectDeployments");
@@clientName(TextAnalysisAuthoringProjectDeployments, "ProjectDeployments", "python");
@@clientName(TextAnalysisAuthoringProjectDeployment, "TextAuthoringProjectDeployment");
@@clientName(TextAnalysisAuthoringProjectDeployment, "ProjectDeployment", "python");
@@clientName(TextAnalysisAuthoringProjectDeployment.lastTrainedDateTime, "lastTrainedOn");
@@clientName(TextAnalysisAuthoringProjectDeployment.lastDeployedDateTime, "lastDeployedOn");
@@clientName(TextAnalysisAuthoringProjectDeployment.deploymentExpirationDate, "deploymentExpiredOn");
@@clientName(TextAnalysisAuthoringDeploymentResource, "TextAuthoringDeploymentResource");
@@clientName(TextAnalysisAuthoringDeploymentResource, "DeploymentResource", "python");
@@clientName(TextAnalysisAuthoringCreateDeploymentOptions, "TextAuthoringCreateDeploymentDetails");
@@clientName(TextAnalysisAuthoringCreateDeploymentOptions, "CreateDeploymentDetails", "python");
@@clientName(TextAnalysisAuthoringDeleteDeploymentOptions, "TextAuthoringDeleteDeploymentDetails");
@@clientName(TextAnalysisAuthoringDeleteDeploymentOptions, "DeleteDeploymentDetails", "python");
@@clientName(TextAnalysisAuthoringDeploymentJobState, "TextAuthoringDeploymentState");
@@clientName(TextAnalysisAuthoringDeploymentJobState, "DeploymentState", "python");
@@clientName(TextAnalysisAuthoringDeploymentDeleteFromResourcesJobState, "TextAuthoringDeploymentDeleteFromResourcesState");
@@clientName(TextAnalysisAuthoringDeploymentDeleteFromResourcesJobState, "DeploymentDeleteFromResourcesState", "python");
@@clientName(TextAnalysisAuthoringSwapDeploymentsJobState, "TextAuthoringSwapDeploymentsState");
@@clientName(TextAnalysisAuthoringSwapDeploymentsJobState, "SwapDeploymentsState", "python");
@@clientName(TextAnalysisAuthoringSwapDeploymentsOptions, "TextAuthoringSwapDeploymentsDetails");
@@clientName(TextAnalysisAuthoringSwapDeploymentsOptions, "SwapDeploymentsDetails", "python");
@@clientName(TextAnalysisAuthoringExportProjectJobState, "TextAuthoringExportProjectState");
@@clientName(TextAnalysisAuthoringExportProjectJobState, "ExportProjectState", "python");
@@clientName(TextAnalysisAuthoringExportedTrainedModels, "TextAuthoringExportedTrainedModels");
@@clientName(TextAnalysisAuthoringExportedTrainedModels, "ExportedTrainedModels", "python");
@@clientName(TextAnalysisAuthoringExportedTrainedModel, "TextAuthoringExportedTrainedModel");
@@clientName(TextAnalysisAuthoringExportedTrainedModel, "ExportedTrainedModel", "python");
@@clientName(TextAnalysisAuthoringExportedTrainedModel.lastTrainedDateTime, "lastTrainedOn");
@@clientName(TextAnalysisAuthoringExportedTrainedModel.lastExportedModelDateTime, "lastExportedModelOn");
@@clientName(TextAnalysisAuthoringExportedTrainedModel.modelExpirationDate, "modelExpiredOn");
@@clientName(TextAnalysisAuthoringExportedModelOptions, "TextAuthoringExportedModelDetails");
@@clientName(TextAnalysisAuthoringExportedModelOptions, "ExportedModelDetails", "python");
@@clientName(TextAnalysisAuthoringExportedModelJobState, "TextAuthoringExportedModelState");
@@clientName(TextAnalysisAuthoringExportedModelJobState, "ExportedModelState", "python");
@@clientName(TextAnalysisAuthoringExportedModelManifest, "ExportedModelManifest");
@@clientName(TextAnalysisAuthoringModelFile, "TextAuthoringModelFile");
@@clientName(TextAnalysisAuthoringModelFile, "ModelFile", "python");
@@clientName(TextAnalysisAuthoringImportProjectJobState, "TextAuthoringImportProjectState");
@@clientName(TextAnalysisAuthoringImportProjectJobState, "ImportProjectState", "python");
@@clientName(TextAnalysisAuthoringProjectTrainedModels, "TextAuthoringProjectTrainedModels");
@@clientName(TextAnalysisAuthoringProjectTrainedModels, "ProjectTrainedModels", "python");
@@clientName(TextAnalysisAuthoringProjectTrainedModel, "TextAuthoringProjectTrainedModel");
@@clientName(TextAnalysisAuthoringProjectTrainedModel, "ProjectTrainedModel", "python");
@@clientName(TextAnalysisAuthoringProjectTrainedModel.lastTrainedDateTime, "lastTrainedOn");
@@clientName(TextAnalysisAuthoringProjectTrainedModel.modelExpirationDate, "modelExpiredOn");
@@clientName(TextAnalysisAuthoringEvaluationJobState, "TextAuthoringEvaluationState");
@@clientName(TextAnalysisAuthoringEvaluationJobState, "EvaluationState", "python");
@@clientName(TextAnalysisAuthoringEvaluationJobResult, "TextAuthoringEvaluationJobResult");
@@clientName(TextAnalysisAuthoringEvaluationJobResult, "EvaluationJobResult", "python");
@@clientName(TextAnalysisAuthoringEvaluationResults, "TextAuthoringEvalResults");
@@clientName(TextAnalysisAuthoringEvaluationResults, "EvalResults", "python");
@@clientName(TextAnalysisAuthoringDocumentEvaluationResult, "TextAuthoringDocumentEvalResult");
@@clientName(TextAnalysisAuthoringDocumentEvaluationResult, "DocumentEvalResult", "python");
@@clientName(TextAnalysisAuthoringEvaluationSummary, "TextAuthoringEvalSummary");
@@clientName(TextAnalysisAuthoringEvaluationSummary, "EvalSummary", "python");
@@clientName(TextAnalysisAuthoringLoadSnapshotJobState, "TextAuthoringLoadSnapshotState");
@@clientName(TextAnalysisAuthoringLoadSnapshotJobState, "LoadSnapshotState", "python");
@@clientName(TextAnalysisAuthoringAssignedDeploymentResources, "TextAuthoringAssignedDeploymentResources");
@@clientName(TextAnalysisAuthoringAssignedDeploymentResources, "AssignedDeploymentResources", "python");
@@clientName(TextAnalysisAuthoringAssignedDeploymentResource, "TextAuthoringAssignedDeploymentResource");
@@clientName(TextAnalysisAuthoringAssignedDeploymentResource, "AssignedDeploymentResource", "python");
@@clientName(TextAnalysisAuthoringAssignDeploymentResourcesOptions, "TextAuthoringAssignDeploymentResourcesDetails");
@@clientName(TextAnalysisAuthoringAssignDeploymentResourcesOptions, "AssignDeploymentResourcesDetails", "python");
@@clientName(TextAnalysisAuthoringResourceMetadata, "TextAuthoringResourceMetadata");
@@clientName(TextAnalysisAuthoringResourceMetadata, "ResourceMetadata", "python");
@@clientName(TextAnalysisAuthoringUnassignDeploymentResourcesOptions, "TextAuthoringUnassignDeploymentResourcesDetails");
@@clientName(TextAnalysisAuthoringUnassignDeploymentResourcesOptions, "UnassignDeploymentResourcesDetails", "python");
@@clientName(TextAnalysisAuthoringDeploymentResourcesJobState, "TextAuthoringDeploymentResourcesState");
@@clientName(TextAnalysisAuthoringDeploymentResourcesJobState, "DeploymentResourcesState", "python");
@@clientName(TextAnalysisAuthoringTrainingJobs, "TextAuthoringTrainingJobs");
@@clientName(TextAnalysisAuthoringTrainingJobs, "TrainingJobs", "python");
@@clientName(TextAnalysisAuthoringTrainingJobState, "TextAuthoringTrainingState");
@@clientName(TextAnalysisAuthoringTrainingJobState, "TrainingState", "python");
@@clientName(TextAnalysisAuthoringTrainingJobResult, "TextAuthoringTrainingJobResult");
@@clientName(TextAnalysisAuthoringTrainingJobResult, "TrainingJobResult", "python");
@@clientName(TextAnalysisAuthoringTrainingJobResult.estimatedEndDateTime, "estimatedEndOn");
@@clientName(TextAnalysisAuthoringSubTrainingJobState, "TextAuthoringSubTrainingState");
@@clientName(TextAnalysisAuthoringSubTrainingJobState, "SubTrainingState", "python");
@@clientName(TextAnalysisAuthoringSubTrainingJobState.startDateTime, "startedOn");
@@clientName(TextAnalysisAuthoringSubTrainingJobState.endDateTime, "endedOn");
@@clientName(TextAnalysisAuthoringProjectDeletionJobState, "TextAuthoringProjectDeletionState");
@@clientName(TextAnalysisAuthoringProjectDeletionJobState, "ProjectDeletionState", "python");
@@clientName(TextAnalysisAuthoringAssignedResourceDeploymentsMetadata, "TextAuthoringAssignedResourceDeploymentsMetadata");
@@clientName(TextAnalysisAuthoringAssignedResourceDeploymentsMetadata, "AssignedResourceDeploymentsMetadata", "python");
@@clientName(TextAnalysisAuthoringAssignedProjectDeploymentsMetadata, "TextAuthoringAssignedProjectDeploymentsMetadata");
@@clientName(TextAnalysisAuthoringAssignedProjectDeploymentsMetadata, "AssignedProjectDeploymentsMetadata", "python");
@@clientName(TextAnalysisAuthoringAssignedProjectDeploymentMetadata, "TextAuthoringAssignedProjectDeploymentMetadata");
@@clientName(TextAnalysisAuthoringAssignedProjectDeploymentMetadata, "AssignedProjectDeploymentMetadata", "python");
@@clientName(TextAnalysisAuthoringAssignedProjectDeploymentMetadata.lastDeployedDateTime, "lastDeployedOn");
@@clientName(TextAnalysisAuthoringAssignedProjectDeploymentMetadata.deploymentExpirationDate, "DeploymentExpiresOn");
@@clientName(TextAnalysisAuthoringSupportedLanguages, "TextAuthoringSupportedLanguages");
@@clientName(TextAnalysisAuthoringSupportedLanguages, "SupportedLanguages", "python");
@@clientName(TextAnalysisAuthoringSupportedLanguage, "TextAuthoringSupportedLanguage");
@@clientName(TextAnalysisAuthoringSupportedLanguage, "SupportedLanguage", "python");
@@clientName(TextAnalysisAuthoringPrebuiltEntities, "TextAuthoringPrebuiltEntities");
@@clientName(TextAnalysisAuthoringPrebuiltEntities, "PrebuiltEntities", "python");
@@clientName(TextAnalysisAuthoringPrebuiltEntity, "TextAuthoringPrebuiltEntity");
@@clientName(TextAnalysisAuthoringPrebuiltEntity, "PrebuiltEntity", "python");
@@clientName(TextAnalysisAuthoringTrainingConfigVersions, "TextAuthoringTrainingConfigVersions");
@@clientName(TextAnalysisAuthoringTrainingConfigVersions, "TrainingConfigVersions", "python");
@@clientName(TextAnalysisAuthoringTrainingConfigVersion, "TextAuthoringTrainingConfigVersion");
@@clientName(TextAnalysisAuthoringTrainingConfigVersion, "TrainingConfigVersion", "python");
@@clientName(TextAnalysisAuthoringTrainingConfigVersion.modelExpirationDate, "modelExpiredOn");
@@clientName(TextAnalysisAuthoringConfusionMatrixCell, "TextAuthoringConfusionMatrixCell");
@@clientName(TextAnalysisAuthoringConfusionMatrixCell, "ConfusionMatrixCell", "python");
@@clientName(TextAnalysisAuthoringCustomEntityRecognitionDocumentEvaluationResult, "CustomEntityRecognitionDocumentEvalResult");
@@clientName(TextAnalysisAuthoringDocumentEntityRecognitionEvaluationResult, "DocumentEntityRecognitionEvalResult");
@@clientName(TextAnalysisAuthoringDocumentEntityRegionEvaluationResult, "DocumentEntityRegionEvalResult");
@@clientName(TextAnalysisAuthoringDocumentEntityLabelEvaluationResult, "DocumentEntityLabelEvalResult");
@@clientName(TextAnalysisAuthoringCustomEntityRecognitionEvaluationSummary, "CustomEntityRecognitionEvalSummary");
@@clientName(TextAnalysisAuthoringConfusionMatrixRow, "TextAuthoringConfusionMatrixRow");
@@clientName(TextAnalysisAuthoringConfusionMatrixRow, "ConfusionMatrixRow", "python");
@@clientName(TextAnalysisAuthoringEntityRecognitionEvaluationSummary, "EntityRecognitionEvalSummary");
@@clientName(TextAnalysisAuthoringEntityEvaluationSummary, "TextAuthoringEntityEvalSummary");
@@clientName(TextAnalysisAuthoringEntityEvaluationSummary, "EntityEvalSummary", "python");
@@clientName(TextAnalysisAuthoringCustomHealthcareDocumentEvaluationResult, "CustomHealthcareDocumentEvalResult");
@@clientName(TextAnalysisAuthoringDocumentHealthcareEvaluationResult, "DocumentHealthcareEvalResult");
@@clientName(TextAnalysisAuthoringCustomHealthcareEvaluationSummary, "CustomHealthcareEvalSummary");
@@clientName(TextAnalysisAuthoringCustomMultiLabelClassificationDocumentEvaluationResult, "CustomMultiLabelClassificationDocumentEvalResult");
@@clientName(TextAnalysisAuthoringDocumentMultiLabelClassificationEvaluationResult, "DocumentMultiLabelClassificationEvalResult");
@@clientName(TextAnalysisAuthoringCustomMultiLabelClassificationEvaluationSummary, "CustomMultiLabelClassificationEvalSummary");
@@clientName(TextAnalysisAuthoringMultiLabelClassificationEvaluationSummary, "MultiLabelClassificationEvalSummary");
@@clientName(TextAnalysisAuthoringMultiLabelClassEvaluationSummary, "MultiLabelClassEvalSummary");
@@clientName(TextAnalysisAuthoringCustomSingleLabelClassificationDocumentEvaluationResult, "CustomSingleLabelClassificationDocumentEvalResult");
@@clientName(TextAnalysisAuthoringDocumentSingleLabelClassificationEvaluationResult, "DocumentSingleLabelClassificationEvalResult");
@@clientName(TextAnalysisAuthoringCustomSingleLabelClassificationEvaluationSummary, "CustomSingleLabelClassificationEvalSummary");
@@clientName(TextAnalysisAuthoringSingleLabelClassificationEvaluationSummary, "SingleLabelClassificationEvalSummary");
@@clientName(TextAnalysisAuthoringSingleLabelClassEvaluationSummary, "SingleLabelClassEvalSummary");
@@clientName(TextAnalysisAuthoringCustomTextSentimentDocumentEvaluationResult, "CustomTextSentimentDocumentEvalResult");
@@clientName(TextAnalysisAuthoringDocumentTextSentimentEvaluationResult, "DocumentTextSentimentEvalResult");
@@clientName(TextAnalysisAuthoringDocumentSentimentLabelEvaluationResult, "DocumentSentimentLabelEvalResult");
@@clientName(TextAnalysisAuthoringCustomTextSentimentEvaluationSummary, "CustomTextSentimentEvalSummary");
@@clientName(TextAnalysisAuthoringTextSentimentEvaluationSummary, "TextSentimentEvalSummary");
@@clientName(TextAnalysisAuthoringSpanSentimentEvaluationSummary, "SpanSentimentEvalSummary");
@@clientName(TextAnalysisAuthoringSentimentEvaluationSummary, "SentimentEvalSummary");
@@clientName(TextAnalysisAuthoringExportedClass, "TextAuthoringExportedClass");
@@clientName(TextAnalysisAuthoringExportedClass, "ExportedClass", "python");
@@clientName(TextAnalysisAuthoringExportedCompositeEntity, "TextAuthoringExportedCompositeEntity");
@@clientName(TextAnalysisAuthoringExportedCompositeEntity, "ExportedCompositeEntity", "python");
@@clientName(TextAnalysisAuthoringExportedEntityList, "TextAuthoringExportedEntityList");
@@clientName(TextAnalysisAuthoringExportedEntityList, "ExportedEntityList", "python");
@@clientName(TextAnalysisAuthoringExportedEntitySublist, "TextAuthoringExportedEntitySublist");
@@clientName(TextAnalysisAuthoringExportedEntitySublist, "ExportedEntitySublist", "python");
@@clientName(TextAnalysisAuthoringExportedEntityListSynonym, "TextAuthoringExportedEntityListSynonym");
@@clientName(TextAnalysisAuthoringExportedEntityListSynonym, "ExportedEntityListSynonym", "python");
@@clientName(TextAnalysisAuthoringExportedEntityListSynonym.values, "synonyms", "python");
@@clientName(TextAnalysisAuthoringExportedPrebuiltEntity, "TextAuthoringExportedPrebuiltEntity");
@@clientName(TextAnalysisAuthoringExportedPrebuiltEntity, "ExportedPrebuiltEntity", "python");
@@clientName(TextAnalysisAuthoringExportedCustomAbstractiveSummarizationDocument, "ExportedCustomAbstractiveSummarizationDocument");
@@clientName(TextAnalysisAuthoringExportedCustomAbstractiveSummarizationProjectAssets, "ExportedCustomAbstractiveSummarizationProjectAsset");
@@clientName(TextAnalysisAuthoringExportedCustomEntityRecognitionDocument, "ExportedCustomEntityRecognitionDocument");
@@clientName(TextAnalysisAuthoringExportedDocumentEntityRegion, "ExportedDocumentEntityRegion");
@@clientName(TextAnalysisAuthoringExportedDocumentEntityLabel, "ExportedDocumentEntityLabel");
@@clientName(TextAnalysisAuthoringExportedCustomEntityRecognitionProjectAssets, "ExportedCustomEntityRecognitionProjectAsset");
@@clientName(TextAnalysisAuthoringExportedEntity, "TextAuthoringExportedEntity");
@@clientName(TextAnalysisAuthoringExportedEntity, "ExportedEntity", "python");
@@clientName(TextAnalysisAuthoringExportedCustomHealthcareDocument, "ExportedCustomHealthcareDocument");
@@clientName(TextAnalysisAuthoringExportedCustomHealthcareProjectAssets, "ExportedCustomHealthcareProjectAsset");
@@clientName(TextAnalysisAuthoringExportedCustomMultiLabelClassificationDocument, "ExportedCustomMultiLabelClassificationDocument");
@@clientName(TextAnalysisAuthoringExportedDocumentClass, "ExportedDocumentClass");
@@clientName(TextAnalysisAuthoringExportedCustomMultiLabelClassificationProjectAssets, "ExportedCustomMultiLabelClassificationProjectAsset");
@@clientName(TextAnalysisAuthoringExportedCustomSingleLabelClassificationDocument, "ExportedCustomSingleLabelClassificationDocument");
@@clientName(TextAnalysisAuthoringExportedCustomSingleLabelClassificationProjectAssets, "ExportedCustomSingleLabelClassificationProjectAsset");
@@clientName(TextAnalysisAuthoringExportedCustomTextSentimentDocument, "ExportedCustomTextSentimentDocument");
@@clientName(TextAnalysisAuthoringExportedDocumentSentimentLabel, "ExportedDocumentSentimentLabel");
@@clientName(TextAnalysisAuthoringExportedCustomTextSentimentProjectAssets, "CustomTextSentimentProjectAssets");

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model TextAuthoringProjectClientOptions {
  projectName: string;
}

// Root client definition
@client({
  name: "TextAuthoringClient",
  service: Language.Text.Authoring,
}, "python")
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
namespace TextAuthoringClient {

  op listProjects is Language.Text.Authoring.textAnalysisAuthoringListProjects;

  op listSupportedLanguages is Language.Text.Authoring.textAnalysisAuthoringGetSupportedLanguages;

  op listAssignedResourceDeployments is Language.Text.Authoring.textAnalysisAuthoringListAssignedResourceDeployments;

  op listSupportedPrebuiltEntities is Language.Text.Authoring.textAnalysisAuthoringGetSupportedPrebuiltEntities;

  op listTrainingConfigVersions is Language.Text.Authoring.textAnalysisAuthoringListTrainingConfigVersions;

  op createProject is Language.Text.Authoring.TextAuthoringProject.createProject;

  op getProject is Language.Text.Authoring.TextAuthoringProject.getProject;

  op deleteProject is Language.Text.Authoring.TextAuthoringProject.deleteProject;

  @access(Access.internal, "python")
  op getExportStatus is Language.Text.Authoring.TextAuthoringProject.getExportStatus;

  @access(Access.internal, "python")
  op getImportStatus is Language.Text.Authoring.TextAuthoringProject.getImportStatus;
}

@client({
  name: "TextAuthoringProjectClient",
  service: Language.Text.Authoring,
}, "python")
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
namespace TextAuthoringProjectClient {
@operationGroup
  @clientName("Deployment", "python")
  interface DeploymentOperations {
    getDeployment is Language.Text.Authoring.TextAuthoringDeployment.getDeployment;

    @access(Access.internal, "python")
    deployProject is Language.Text.Authoring.TextAuthoringDeployment.deployProject;

    @access(Access.internal, "python")
    deleteDeployment is Language.Text.Authoring.TextAuthoringDeployment.deleteDeployment;

    @access(Access.internal, "python")
    deleteDeploymentFromResources is Language.Text.Authoring.TextAuthoringDeployment.deleteDeploymentFromResources;

    @access(Access.internal, "python")
    getDeploymentDeleteFromResourcesStatus is Language.Text.Authoring.TextAuthoringDeployment.getDeploymentDeleteFromResourcesStatus;

    @access(Access.internal, "python")
    getDeploymentStatus is Language.Text.Authoring.TextAuthoringDeployment.getDeploymentStatus;
  }

  @operationGroup
  @clientName("Project", "python")
  interface ProjectOperations {
    listTrainedModels is Language.Text.Authoring.textAnalysisAuthoringListTrainedModels;

    listTrainingJobs is Language.Text.Authoring.textAnalysisAuthoringListTrainingJobs;

    listDeploymentResources is Language.Text.Authoring.textAnalysisAuthoringListDeploymentResources;

    listDeployments is Language.Text.Authoring.textAnalysisAuthoringListDeployments;

    listExportedModels is Language.Text.Authoring.textAnalysisAuthoringListExportedModels;

    @access(Access.internal, "python")
    assignDeploymentResources is Language.Text.Authoring.TextAuthoringProject.assignDeploymentResources;

    @access(Access.internal, "python")
    unassignDeploymentResources is Language.Text.Authoring.TextAuthoringProject.unassignDeploymentResources;

    @access(Access.internal, "python")
    getAssignDeploymentResourcesStatus is Language.Text.Authoring.TextAuthoringProject.getAssignDeploymentResourcesStatus;

    @access(Access.internal, "python")
    getUnassignDeploymentResourcesStatus is Language.Text.Authoring.TextAuthoringProject.getUnassignDeploymentResourcesStatus;

    @access(Access.internal, "python")
    swapDeployments is Language.Text.Authoring.TextAuthoringProject.swapDeployments;

    @access(Access.internal, "python")
    getSwapDeploymentsStatus is Language.Text.Authoring.TextAuthoringProject.getSwapDeploymentsStatus;

    @access(Access.internal, "python")
    getProject is Language.Text.Authoring.TextAuthoringProject.getProject;

    @access(Access.internal, "python")
    getProjectDeletionStatus is Language.Text.Authoring.TextAuthoringProject.getProjectDeletionStatus;

    @access(Access.internal, "python")
    `export` is Language.Text.Authoring.TextAuthoringProject.`export`;

    @access(Access.internal, "python")
    `import` is Language.Text.Authoring.TextAuthoringProject.`import`;

    @access(Access.internal, "python")
    getExportStatus is Language.Text.Authoring.TextAuthoringProject.getExportStatus;

    @access(Access.internal, "python")
    copyProjectAuthorization is Language.Text.Authoring.TextAuthoringProject.copyProjectAuthorization;

    @access(Access.internal, "python")
    copyProject is Language.Text.Authoring.TextAuthoringProject.copyProject;

    @access(Access.internal, "python")
    getCopyProjectStatus is Language.Text.Authoring.TextAuthoringProject.getCopyProjectStatus;

    @access(Access.internal, "python")
    train is Language.Text.Authoring.TextAuthoringProject.train;

    @access(Access.internal, "python")
    getTrainingStatus is Language.Text.Authoring.TextAuthoringProject.getTrainingStatus;

    cancelTrainingJob is Language.Text.Authoring.TextAuthoringProject.cancelTrainingJob;
  }

  @operationGroup
  @clientName("ExportedModel", "python")
  interface ExportedModelOperations {
    getExportedModel is  Language.Text.Authoring.TextAuthoringExportedModel.getExportedModel;

    @access(Access.internal, "python")
    deleteExportedModel is Language.Text.Authoring.TextAuthoringExportedModel.deleteExportedModel;

    @access(Access.internal, "python")
    createOrUpdateExportedModel is Language.Text.Authoring.TextAuthoringExportedModel.createOrUpdateExportedModel;

    @access(Access.internal, "python")
    getExportedModelJobStatus is Language.Text.Authoring.TextAuthoringExportedModel.getExportedModelJobStatus;

    getExportedModelManifest is Language.Text.Authoring.TextAuthoringExportedModel.getExportedModelManifest;
  }

  @operationGroup
  @clientName("TrainedModel", "python")
  interface TrainedModelOperations {
    getTrainedModel is  Language.Text.Authoring.TextAuthoringTrainedModel.getTrainedModel;

    deleteTrainedModel is Language.Text.Authoring.TextAuthoringTrainedModel.deleteTrainedModel;

    @access(Access.internal, "python")
    evaluateModel is Language.Text.Authoring.TextAuthoringTrainedModel.evaluateModel;

    @access(Access.internal, "python")
    loadSnapshot is Language.Text.Authoring.TextAuthoringTrainedModel.loadSnapshot;

    @access(Access.internal, "python")
    getEvaluationStatus is Language.Text.Authoring.TextAuthoringTrainedModel.getEvaluationStatus;

    getModelEvaluationResults is Language.Text.Authoring.TextAuthoringTrainedModel.getModelEvaluationResults;

    getModelEvaluationSummary is Language.Text.Authoring.TextAuthoringTrainedModel.getModelEvaluationSummary;

    @access(Access.internal, "python")
    getLoadSnapshotStatus is Language.Text.Authoring.TextAuthoringTrainedModel.getLoadSnapshotStatus;
  }
}

@@clientInitialization(TextAuthoringProjectClient, {
  parameters: TextAuthoringProjectClientOptions,
}, "python");