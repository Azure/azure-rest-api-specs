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
@@clientName(ErrorCode, "TextAuthoringErrorCode");
@@clientName(InnerErrorCode, "TextAuthoringInnerErrorCode");
@@clientName(StringIndexType, "StringIndexType");
@@clientName(EvaluationKind, "TextAuthoringEvaluationKind");
@@clientName(JobStatus, "TextAuthoringOperationStatus");
@@clientName(Sentiment, "TextAuthoringSentiment");
@@clientName(CompositionSetting, "TextAuthoringCompositionMode");
@@clientName(TextAnalysisAuthoringProjectsMetadata, "TextAuthoringProjectsMetadata");
@@clientName(TextAnalysisAuthoringProjectMetadata, "TextAuthoringProjectMetadata");
@@clientName(TextAnalysisAuthoringProjectMetadata.createdDateTime, "createdOn");
@@clientName(TextAnalysisAuthoringProjectMetadata.lastModifiedDateTime, "lastModifiedOn");
@@clientName(TextAnalysisAuthoringProjectMetadata.lastTrainedDateTime, "lastTrainedOn");
@@clientName(TextAnalysisAuthoringProjectMetadata.lastDeployedDateTime, "lastDeployedOn");
@@clientName(TextAnalysisAuthoringProjectSettings, "TextAuthoringProjectSettings");
@@clientName(Error, "TextAuthoringError");
@@clientName(InnerErrorModel, "TextAuthoringInnerErrorModel");
@@clientName(TextAnalysisAuthoringCreateProjectOptions, "TextAuthoringCreateProjectDetails");
@@clientName(TextAnalysisAuthoringCopyAuthorizationOptions, "TextAuthoringCopyAuthorizationDetails");
@@clientName(TextAnalysisAuthoringCopyProjectOptions, "TextAuthoringCopyProjectDetails");
@@clientName(TextAnalysisAuthoringExportedProject, "TextAuthoringExportedProject");
@@clientName(TextAnalysisAuthoringExportedProjectAssets, "TextAuthoringExportedProjectAsset");
@@clientName(TextAnalysisAuthoringTrainingJobOptions, "TextAuthoringTrainingJobDetails");
@@clientName(TextAnalysisAuthoringDataGenerationSettings, "DataGenerationSetting");
@@clientName(TextAnalysisAuthoringDataGenerationConnectionInfo, "DataGenerationConnectionInfo");
@@clientName(TextAnalysisAuthoringEvaluationOptions, "TextAuthoringEvaluationDetails");
@@clientName(TextAnalysisAuthoringCopyProjectJobState, "TextAuthoringCopyProjectState");
@@clientName(TextAnalysisAuthoringJobState, "TextAuthoringState");
@@clientName(TextAnalysisAuthoringJobState.createdDateTime, "createdOn");
@@clientName(TextAnalysisAuthoringJobState.lastUpdatedDateTime, "lastUpdatedOn");
@@clientName(TextAnalysisAuthoringJobState.expirationDateTime, "expiresOn");
@@clientName(TextAnalysisAuthoringProjectDeployments, "TextAuthoringProjectDeployments");
@@clientName(TextAnalysisAuthoringProjectDeployment, "TextAuthoringProjectDeployment");
@@clientName(TextAnalysisAuthoringProjectDeployment.lastTrainedDateTime, "lastTrainedOn");
@@clientName(TextAnalysisAuthoringProjectDeployment.lastDeployedDateTime, "lastDeployedOn");
@@clientName(TextAnalysisAuthoringProjectDeployment.deploymentExpirationDate, "deploymentExpiredOn");
@@clientName(TextAnalysisAuthoringDeploymentResource, "TextAuthoringDeploymentResource");
@@clientName(TextAnalysisAuthoringCreateDeploymentOptions, "TextAuthoringCreateDeploymentDetails");
@@clientName(TextAnalysisAuthoringDeleteDeploymentOptions, "TextAuthoringDeleteDeploymentDetails");
@@clientName(TextAnalysisAuthoringDeploymentJobState, "TextAuthoringDeploymentState");
@@clientName(TextAnalysisAuthoringDeploymentDeleteFromResourcesJobState, "TextAuthoringDeploymentDeleteFromResourcesState");
@@clientName(TextAnalysisAuthoringSwapDeploymentsJobState, "TextAuthoringSwapDeploymentsState");
@@clientName(TextAnalysisAuthoringSwapDeploymentsOptions, "TextAuthoringSwapDeploymentsDetails");
@@clientName(TextAnalysisAuthoringExportProjectJobState, "TextAuthoringExportProjectState");
@@clientName(TextAnalysisAuthoringExportedTrainedModels, "TextAuthoringExportedTrainedModels");
@@clientName(TextAnalysisAuthoringExportedTrainedModel, "TextAuthoringExportedTrainedModel");
@@clientName(TextAnalysisAuthoringExportedTrainedModel.lastTrainedDateTime, "lastTrainedOn");
@@clientName(TextAnalysisAuthoringExportedTrainedModel.lastExportedModelDateTime, "lastExportedModelOn");
@@clientName(TextAnalysisAuthoringExportedTrainedModel.modelExpirationDate, "modelExpiredOn");
@@clientName(TextAnalysisAuthoringExportedModelOptions, "TextAuthoringExportedModelDetails");
@@clientName(TextAnalysisAuthoringExportedModelJobState, "TextAuthoringExportedModelState");
@@clientName(TextAnalysisAuthoringExportedModelManifest, "ExportedModelManifest");
@@clientName(TextAnalysisAuthoringModelFile, "TextAuthoringModelFile");
@@clientName(TextAnalysisAuthoringImportProjectJobState, "TextAuthoringImportProjectState");
@@clientName(TextAnalysisAuthoringProjectTrainedModels, "TextAuthoringProjectTrainedModels");
@@clientName(TextAnalysisAuthoringProjectTrainedModel, "TextAuthoringProjectTrainedModel");
@@clientName(TextAnalysisAuthoringProjectTrainedModel.lastTrainedDateTime, "lastTrainedOn");
@@clientName(TextAnalysisAuthoringProjectTrainedModel.modelExpirationDate, "modelExpiredOn");
@@clientName(TextAnalysisAuthoringEvaluationJobState, "TextAuthoringEvaluationState");
@@clientName(TextAnalysisAuthoringEvaluationJobResult, "TextAuthoringEvaluationJobResult");
@@clientName(TextAnalysisAuthoringEvaluationResults, "TextAuthoringEvalResults");
@@clientName(TextAnalysisAuthoringDocumentEvaluationResult, "TextAuthoringDocumentEvalResult");
@@clientName(TextAnalysisAuthoringEvaluationSummary, "TextAuthoringEvalSummary");
@@clientName(TextAnalysisAuthoringLoadSnapshotJobState, "TextAuthoringLoadSnapshotState");
@@clientName(TextAnalysisAuthoringAssignedDeploymentResources, "TextAuthoringAssignedDeploymentResources");
@@clientName(TextAnalysisAuthoringAssignedDeploymentResource, "TextAuthoringAssignedDeploymentResource");
@@clientName(TextAnalysisAuthoringAssignDeploymentResourcesOptions, "TextAuthoringAssignDeploymentResourcesDetails");
@@clientName(TextAnalysisAuthoringResourceMetadata, "TextAuthoringResourceMetadata");
@@clientName(TextAnalysisAuthoringUnassignDeploymentResourcesOptions, "TextAuthoringUnassignDeploymentResourcesDetails");
@@clientName(TextAnalysisAuthoringDeploymentResourcesJobState, "TextAuthoringDeploymentResourcesState");
@@clientName(TextAnalysisAuthoringTrainingJobs, "TextAuthoringTrainingJobs");
@@clientName(TextAnalysisAuthoringTrainingJobState, "TextAuthoringTrainingState");
@@clientName(TextAnalysisAuthoringTrainingJobResult, "TextAuthoringTrainingJobResult");
@@clientName(TextAnalysisAuthoringTrainingJobResult.estimatedEndDateTime, "estimatedEndOn");
@@clientName(TextAnalysisAuthoringSubTrainingJobState, "TextAuthoringSubTrainingState");
@@clientName(TextAnalysisAuthoringSubTrainingJobState.startDateTime, "startedOn");
@@clientName(TextAnalysisAuthoringSubTrainingJobState.endDateTime, "endedOn");
@@clientName(TextAnalysisAuthoringProjectDeletionJobState, "TextAuthoringProjectDeletionState");
@@clientName(TextAnalysisAuthoringAssignedResourceDeploymentsMetadata, "TextAuthoringAssignedResourceDeploymentsMetadata");
@@clientName(TextAnalysisAuthoringAssignedProjectDeploymentsMetadata, "TextAuthoringAssignedProjectDeploymentsMetadata");
@@clientName(TextAnalysisAuthoringAssignedProjectDeploymentMetadata, "TextAuthoringAssignedProjectDeploymentMetadata");
@@clientName(TextAnalysisAuthoringAssignedProjectDeploymentMetadata.lastDeployedDateTime, "lastDeployedOn");
@@clientName(TextAnalysisAuthoringAssignedProjectDeploymentMetadata.deploymentExpirationDate, "DeploymentExpiresOn");
@@clientName(TextAnalysisAuthoringSupportedLanguages, "TextAuthoringSupportedLanguages");
@@clientName(TextAnalysisAuthoringSupportedLanguage, "TextAuthoringSupportedLanguage");
@@clientName(TextAnalysisAuthoringPrebuiltEntities, "TextAuthoringPrebuiltEntities");
@@clientName(TextAnalysisAuthoringPrebuiltEntity, "TextAuthoringPrebuiltEntity");
@@clientName(TextAnalysisAuthoringTrainingConfigVersions, "TextAuthoringTrainingConfigVersions");
@@clientName(TextAnalysisAuthoringTrainingConfigVersion, "TextAuthoringTrainingConfigVersion");
@@clientName(TextAnalysisAuthoringTrainingConfigVersion.modelExpirationDate, "modelExpiredOn");
@@clientName(TextAnalysisAuthoringConfusionMatrixCell, "TextAuthoringConfusionMatrixCell");
@@clientName(TextAnalysisAuthoringCustomEntityRecognitionDocumentEvaluationResult, "CustomEntityRecognitionDocumentEvalResult");
@@clientName(TextAnalysisAuthoringDocumentEntityRecognitionEvaluationResult, "DocumentEntityRecognitionEvalResult");
@@clientName(TextAnalysisAuthoringDocumentEntityRegionEvaluationResult, "DocumentEntityRegionEvalResult");
@@clientName(TextAnalysisAuthoringDocumentEntityLabelEvaluationResult, "DocumentEntityLabelEvalResult");
@@clientName(TextAnalysisAuthoringCustomEntityRecognitionEvaluationSummary, "CustomEntityRecognitionEvalSummary");
@@clientName(TextAnalysisAuthoringConfusionMatrixRow, "TextAuthoringConfusionMatrixRow");
@@clientName(TextAnalysisAuthoringEntityRecognitionEvaluationSummary, "EntityRecognitionEvalSummary");
@@clientName(TextAnalysisAuthoringEntityEvaluationSummary, "TextAuthoringEntityEvalSummary");
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
@@clientName(TextAnalysisAuthoringExportedCompositeEntity, "TextAuthoringExportedCompositeEntity");
@@clientName(TextAnalysisAuthoringExportedEntityList, "TextAuthoringExportedEntityList");
@@clientName(TextAnalysisAuthoringExportedEntitySublist, "TextAuthoringExportedEntitySublist");
@@clientName(TextAnalysisAuthoringExportedEntityListSynonym, "TextAuthoringExportedEntityListSynonym");
@@clientName(TextAnalysisAuthoringExportedPrebuiltEntity, "TextAuthoringExportedPrebuiltEntity");
@@clientName(TextAnalysisAuthoringExportedCustomAbstractiveSummarizationDocument, "ExportedCustomAbstractiveSummarizationDocument");
@@clientName(TextAnalysisAuthoringExportedCustomAbstractiveSummarizationProjectAssets, "ExportedCustomAbstractiveSummarizationProjectAsset");
@@clientName(TextAnalysisAuthoringExportedCustomEntityRecognitionDocument, "ExportedCustomEntityRecognitionDocument");
@@clientName(TextAnalysisAuthoringExportedDocumentEntityRegion, "ExportedDocumentEntityRegion");
@@clientName(TextAnalysisAuthoringExportedDocumentEntityLabel, "ExportedDocumentEntityLabel");
@@clientName(TextAnalysisAuthoringExportedCustomEntityRecognitionProjectAssets, "ExportedCustomEntityRecognitionProjectAsset");
@@clientName(TextAnalysisAuthoringExportedEntity, "TextAuthoringExportedEntity");
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

  op `export` is Language.Text.Authoring.TextAuthoringProject.`export`;

  op `import` is Language.Text.Authoring.TextAuthoringProject.`import`;

  op getExportStatus is Language.Text.Authoring.TextAuthoringProject.getExportStatus;

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

    deployProject is Language.Text.Authoring.TextAuthoringDeployment.deployProject;

    deleteDeployment is Language.Text.Authoring.TextAuthoringDeployment.deleteDeployment;

    deleteDeploymentFromResources is Language.Text.Authoring.TextAuthoringDeployment.deleteDeploymentFromResources;

    getDeploymentDeleteFromResourcesStatus is Language.Text.Authoring.TextAuthoringDeployment.getDeploymentDeleteFromResourcesStatus;

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

    assignDeploymentResources is Language.Text.Authoring.TextAuthoringProject.assignDeploymentResources;

    unassignDeploymentResources is Language.Text.Authoring.TextAuthoringProject.unassignDeploymentResources;

    getAssignDeploymentResourcesStatus is Language.Text.Authoring.TextAuthoringProject.getAssignDeploymentResourcesStatus;

    getUnassignDeploymentResourcesStatus is Language.Text.Authoring.TextAuthoringProject.getUnassignDeploymentResourcesStatus;

    swapDeployments is Language.Text.Authoring.TextAuthoringProject.swapDeployments;

    getSwapDeploymentsStatus is Language.Text.Authoring.TextAuthoringProject.getSwapDeploymentsStatus;

    getProject is Language.Text.Authoring.TextAuthoringProject.getProject;

    getProjectDeletionStatus is Language.Text.Authoring.TextAuthoringProject.getProjectDeletionStatus;

    `export` is Language.Text.Authoring.TextAuthoringProject.`export`;

    getExportStatus is Language.Text.Authoring.TextAuthoringProject.getExportStatus;

    copyProjectAuthorization is Language.Text.Authoring.TextAuthoringProject.copyProjectAuthorization;

    copyProject is Language.Text.Authoring.TextAuthoringProject.copyProject;

    getCopyProjectStatus is Language.Text.Authoring.TextAuthoringProject.getCopyProjectStatus;

    train is Language.Text.Authoring.TextAuthoringProject.train;

    getTrainingStatus is Language.Text.Authoring.TextAuthoringProject.getTrainingStatus;

    cancelTrainingJob is Language.Text.Authoring.TextAuthoringProject.cancelTrainingJob;
  }

  @operationGroup
  @clientName("ExportedModel", "python")
  interface ExportedModelOperations {
    getExportedModel is  Language.Text.Authoring.TextAuthoringExportedModel.getExportedModel;

    deleteExportedModel is Language.Text.Authoring.TextAuthoringExportedModel.deleteExportedModel;

    createOrUpdateExportedModel is Language.Text.Authoring.TextAuthoringExportedModel.createOrUpdateExportedModel;

    getExportedModelJobStatus is Language.Text.Authoring.TextAuthoringExportedModel.getExportedModelJobStatus;

    getExportedModelManifest is Language.Text.Authoring.TextAuthoringExportedModel.getExportedModelManifest;
  }

  @operationGroup
  @clientName("TrainedModel", "python")
  interface TrainedModelOperations {
    getTrainedModel is  Language.Text.Authoring.TextAuthoringTrainedModel.getTrainedModel;

    deleteTrainedModel is Language.Text.Authoring.TextAuthoringTrainedModel.deleteTrainedModel;

    evaluateModel is Language.Text.Authoring.TextAuthoringTrainedModel.evaluateModel;

    loadSnapshot is Language.Text.Authoring.TextAuthoringTrainedModel.loadSnapshot;

    getEvaluationStatus is Language.Text.Authoring.TextAuthoringTrainedModel.getEvaluationStatus;

    getModelEvaluationResults is Language.Text.Authoring.TextAuthoringTrainedModel.getModelEvaluationResults;

    getModelEvaluationSummary is Language.Text.Authoring.TextAuthoringTrainedModel.getModelEvaluationSummary;

    getLoadSnapshotStatus is Language.Text.Authoring.TextAuthoringTrainedModel.getLoadSnapshotStatus;
  }
}

@@clientInitialization(TextAuthoringProjectClient, {
  parameters: TextAuthoringProjectClientOptions,
}, "python");