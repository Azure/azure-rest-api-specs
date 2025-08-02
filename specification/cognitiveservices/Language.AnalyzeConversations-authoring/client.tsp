import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using Language.Conversations.Authoring;
using Azure.ClientGenerator.Core;
using Versioning;

@useDependency(Language.Conversations.Authoring.Versions.v2025_05_15_preview)
namespace Language.ConversationsAuthoringClientCustomizations;

@@clientName(conversationAuthoringListDeployments, "listDeployments");
@@clientName(conversationAuthoringListProjects, "listProjects");
@@clientName(conversationAuthoringListSupportedLanguages, "listSupportedLanguages");
@@clientName(conversationAuthoringListAssignedResourceDeployments, "listAssignedResourceDeployments");
@@clientName(conversationAuthoringListDeploymentResources, "listDeploymentResources");
@@clientName(conversationAuthoringListSupportedPrebuiltEntities, "listSupportedPrebuiltEntities");
@@clientName(conversationAuthoringListTrainingConfigVersions, "listTrainingConfigVersions");
@@clientName(conversationAuthoringListTrainingJobs, "listTrainingJobs");
@@clientName(conversationAuthoringListTrainedModels, "listTrainedModels");
@@clientName(conversationAuthoringListExportedModels, "listExportedModels");

@@clientName(ConversationAuthoringProject.copyProjectAuthorization, "AuthorizeProjectCopy");
@@clientName(ProjectKind, "ConversationAuthoringProjectKind");
@@clientName(ErrorCode, "ConversationAuthoringErrorCode");
@@clientName(InnerErrorCode, "ConversationAuthoringInnerErrorCode");
@@clientName(StringIndexType, "StringIndexType");
@@clientName(ExportedProjectFormat, "ConversationAuthoringExportedProjectFormat");
@@clientName(TrainingMode, "ConversationAuthoringTrainingMode");
@@clientName(EvaluationKind, "ConversationAuthoringEvaluationKind");
@@clientName(JobStatus, "ConversationAuthoringOperationStatus");
@@clientName(CompositionSetting, "ConversationAuthoringCompositionMode");
@@clientName(OrchestrationTargetProjectKind, "OrchestrationTargetProjectKind");

@@clientName(AnalyzeConversationAuthoringProjectsMetadata, "ConversationAuthoringProjectsMetadata");
@@clientName(AnalyzeConversationAuthoringProjectMetadata, "ConversationAuthoringProjectMetadata");
@@clientName(AnalyzeConversationAuthoringProjectMetadata.createdDateTime, "createdOn");
@@clientName(AnalyzeConversationAuthoringProjectMetadata.lastModifiedDateTime, "lastModifiedOn");
@@clientName(AnalyzeConversationAuthoringProjectMetadata.lastTrainedDateTime, "lastTrainedOn");
@@clientName(AnalyzeConversationAuthoringProjectMetadata.lastDeployedDateTime, "lastDeployedOn");
@@clientName(AnalyzeConversationAuthoringProjectSettings, "ConversationAuthoringProjectSettings");
@@clientName(InnerErrorModel, "ConversationAuthoringInnerErrorModel");
@@clientName(AnalyzeConversationAuthoringCreateProjectOptions, "ConversationAuthoringCreateProjectDetails");
@@clientName(AnalyzeConversationAuthoringCopyAuthorizationOptions, "ConversationAuthoringCopyAuthorizationDetails");
@@clientName(AnalyzeConversationAuthoringCopiedProjectOptions, "ConversationAuthoringCopyProjectDetails");
@@clientName(AnalyzeConversationAuthoringExportedProject, "ConversationAuthoringExportedProject");
@@clientName(AnalyzeConversationAuthoringExportedProjectAssets, "ConversationAuthoringExportedProjectAsset");
@@clientName(AnalyzeConversationAuthoringTrainingJobOptions, "ConversationAuthoringTrainingJobDetails");
@@clientName(AnalyzeConversationAuthoringEvaluationOptions, "ConversationAuthoringEvaluationDetails");
@@clientName(AnalyzeConversationAuthoringCopiedProjectJobState, "ConversationAuthoringCopyProjectState");
@@clientName(AnalyzeConversationAuthoringJobState, "ConversationAuthoringState");
@@clientName(AnalyzeConversationAuthoringJobState.createdDateTime, "createdOn");
@@clientName(AnalyzeConversationAuthoringJobState.lastUpdatedDateTime, "lastUpdatedOn");
@@clientName(AnalyzeConversationAuthoringJobState.expirationDateTime, "expiresOn");
@@clientName(AnalyzeConversationAuthoringProjectDeployments, "ConversationAuthoringProjectDeployments");
@@clientName(AnalyzeConversationAuthoringProjectDeployment, "ConversationAuthoringProjectDeployment");
@@clientName(AnalyzeConversationAuthoringProjectDeployment.lastTrainedDateTime, "lastTrainedOn");
@@clientName(AnalyzeConversationAuthoringProjectDeployment.lastDeployedDateTime, "lastDeployedOn");
@@clientName(AnalyzeConversationAuthoringProjectDeployment.deploymentExpirationDate, "deploymentExpiredOn");
@@clientName(AnalyzeConversationAuthoringDeploymentResource, "ConversationAuthoringDeploymentResource");
@@clientName(AnalyzeConversationAuthoringCreateDeploymentOptions, "ConversationAuthoringCreateDeploymentDetails");
@@clientName(AnalyzeConversationAuthoringDeleteDeploymentOptions, "ConversationAuthoringDeleteDeploymentDetails");
@@clientName(AnalyzeConversationAuthoringDeploymentJobState, "ConversationAuthoringDeploymentState");
@@clientName(AnalyzeConversationAuthoringDeploymentDeleteFromResourcesJobState, "ConversationAuthoringDeploymentDeleteFromResourcesState");
@@clientName(AnalyzeConversationAuthoringSwapDeploymentsJobState, "ConversationAuthoringSwapDeploymentsState");
@@clientName(AnalyzeConversationAuthoringSwapDeploymentsOptions, "ConversationAuthoringSwapDeploymentsDetails");
@@clientName(AnalyzeConversationAuthoringExportProjectJobState, "ConversationAuthoringExportProjectState");
@@clientName(AnalyzeConversationAuthoringExportProjectJobState.resultUrl, "resultUri");
@@clientName(AnalyzeConversationAuthoringImportProjectJobState, "ConversationAuthoringImportProjectState");
@@clientName(AnalyzeConversationAuthoringProjectTrainedModels, "ConversationAuthoringProjectTrainedModels");
@@clientName(AnalyzeConversationAuthoringProjectTrainedModel, "ConversationAuthoringProjectTrainedModel");
@@clientName(AnalyzeConversationAuthoringProjectTrainedModel.lastTrainedDateTime, "lastTrainedOn");
@@clientName(AnalyzeConversationAuthoringProjectTrainedModel.modelExpirationDate, "modelExpiredOn");
@@clientName(AnalyzeConversationAuthoringEvaluationJobState, "ConversationAuthoringEvaluationState");
@@clientName(AnalyzeConversationAuthoringEvaluationJobResult, "ConversationAuthoringEvaluationJobResult");
@@clientName(AnalyzeConversationAuthoringEvaluationJobResult.evaluationOptions, "evaluationDetails");
@@clientName(AnalyzeConversationAuthoringEvaluationResults, "ConversationAuthoringEvalResults");
@@clientName(AnalyzeConversationAuthoringEvaluationSummary, "ConversationAuthoringEvalSummary");
@@clientName(AnalyzeConversationAuthoringEntitiesEvaluationSummary, "EntitiesEvaluationSummary");
@@clientName(AnalyzeConversationAuthoringIntentsEvaluationSummary, "IntentsEvaluationSummary");
@@clientName(AnalyzeConversationAuthoringIntentEvaluationSummary, "IntentEvaluationSummary");
@@clientName(AnalyzeConversationAuthoringLoadSnapshotJobState, "ConversationAuthoringLoadSnapshotState");
@@clientName(AnalyzeConversationAuthoringAssignedDeploymentResources, "ConversationAuthoringAssignedDeploymentResources");
@@clientName(AnalyzeConversationAuthoringAssignedDeploymentResource, "ConversationAuthoringAssignedDeploymentResource");
@@clientName(AnalyzeConversationAuthoringAssignedDeploymentResource.azureResourceId, "resourceId");
@@clientName(AnalyzeConversationAuthoringAssignDeploymentResourcesOptions, "ConversationAuthoringAssignDeploymentResourcesDetails");
@@clientName(AnalyzeConversationAuthoringAssignDeploymentResourcesOptions.resourcesMetadata, "metadata");
@@clientName(AnalyzeConversationAuthoringResourceMetadata, "ConversationAuthoringResourceMetadata");
@@clientName(AnalyzeConversationAuthoringUnassignDeploymentResourcesOptions, "ConversationAuthoringUnassignDeploymentResourcesDetails");
@@clientName(AnalyzeConversationAuthoringDeploymentResourcesJobState, "ConversationAuthoringDeploymentResourcesState");
@@clientName(AnalyzeConversationAuthoringTrainingJobs, "ConversationAuthoringTrainingJobs");
@@clientName(AnalyzeConversationAuthoringTrainingJobState, "ConversationAuthoringTrainingState");
@@clientName(AnalyzeConversationAuthoringTrainingJobResult, "ConversationAuthoringTrainingJobResult");
@@clientName(AnalyzeConversationAuthoringTrainingJobResult.estimatedEndDateTime, "estimatedEndOn");
@@clientName(AnalyzeConversationAuthoringSubTrainingJobState, "ConversationAuthoringSubTrainingState");
@@clientName(AnalyzeConversationAuthoringSubTrainingJobState.startDateTime, "startedOn");
@@clientName(AnalyzeConversationAuthoringSubTrainingJobState.endDateTime, "endedOn");
@@clientName(AnalyzeConversationAuthoringProjectDeletionJobState, "ConversationAuthoringProjectDeletionState");
@@clientName(AnalyzeConversationAuthoringAssignedResourceDeploymentsMetadata, "ConversationAuthoringAssignedResourceDeploymentsMetadata");
@@clientName(AnalyzeConversationAuthoringAssignedProjectDeploymentsMetadata, "ConversationAuthoringAssignedProjectDeploymentsMetadata");
@@clientName(AnalyzeConversationAuthoringAssignedProjectDeploymentMetadata, "ConversationAuthoringAssignedProjectDeploymentMetadata");
@@clientName(AnalyzeConversationAuthoringAssignedProjectDeploymentMetadata.lastDeployedDateTime, "lastDeployedOn");
@@clientName(AnalyzeConversationAuthoringAssignedProjectDeploymentMetadata.deploymentExpirationDate, "DeploymentExpiresOn");
@@clientName(AnalyzeConversationAuthoringSupportedLanguages, "ConversationAuthoringSupportedLanguages");
@@clientName(AnalyzeConversationAuthoringSupportedLanguage, "ConversationAuthoringSupportedLanguage");
@@clientName(AnalyzeConversationAuthoringPrebuiltEntities, "ConversationAuthoringPrebuiltEntities");
@@clientName(AnalyzeConversationAuthoringPrebuiltEntity, "ConversationAuthoringPrebuiltEntity");
@@clientName(AnalyzeConversationAuthoringTrainingConfigVersions, "ConversationAuthoringTrainingConfigVersions");
@@clientName(AnalyzeConversationAuthoringTrainingConfigVersion, "ConversationAuthoringTrainingConfigVersion");
@@clientName(AnalyzeConversationAuthoringConversationExportedEntity, "ConversationExportedEntity");
@@clientName(AnalyzeConversationAuthoringConversationExportedEntity.compositionSetting, "compositionMode");
@@clientName(AnalyzeConversationAuthoringExportedEntityList, "ConversationAuthoringExportedEntityList");
@@clientName(AnalyzeConversationAuthoringExportedEntitySublist, "ConversationAuthoringExportedEntitySublist");
@@clientName(AnalyzeConversationAuthoringExportedEntityListSynonym, "ConversationAuthoringExportedEntityListSynonym");
@@clientName(AnalyzeConversationAuthoringExportedPrebuiltEntity, "ConversationAuthoringExportedPrebuiltEntity");
@@clientName(AnalyzeConversationAuthoringExportedEntityRegex, "ExportedEntityRegex");
@@clientName(AnalyzeConversationAuthoringExportedEntityRegexExpression, "ExportedEntityRegexExpression");
@@clientName(AnalyzeConversationAuthoringConversationExportedIntent, "ConversationExportedIntent");
@@clientName(AnalyzeConversationExportedAssociatedEntityLabel, "ConversationExportedAssociatedEntityLabel");
@@clientName(AnalyzeConversationAuthoringConversationExportedProjectAsset, "ConversationExportedProjectAsset");
@@clientName(AnalyzeConversationAuthoringConversationExportedUtterance, "ConversationExportedUtterance");
@@clientName(AnalyzeConversationAuthoringExportedUtteranceEntityLabel, "ExportedUtteranceEntityLabel");
@@clientName(AnalyzeConversationAuthoringConversationSummarizationExportedProjectAsset, "ConversationSummarizationExportedProjectAsset");
@@clientName(AnalyzeConversationAuthoringCustomConversationSummarizationConversation, "CustomConversationSummarizationConversation");
@@clientName(AnalyzeConversationAuthoringExportedConversationOrchestration, "ExportedConversationOrchestration");
@@clientName(AnalyzeConversationAuthoringExportedConversationOrchestrationOptions, "ExportedConversationOrchestrationDetails");
@@clientName(AnalyzeConversationAuthoringExportedOrchestrationOptions, "ExportedOrchestrationDetails");
@@clientName(AnalyzeConversationAuthoringExportedLuisOrchestration, "ExportedLuisOrchestration");
@@clientName(AnalyzeConversationAuthoringExportedLuisOrchestrationOptions, "ExportedLuisOrchestrationDetails");
@@clientName(AnalyzeConversationAuthoringExportedQuestionAnsweringOrchestration, "ExportedQuestionAnsweringOrchestration");
@@clientName(AnalyzeConversationAuthoringExportedQuestionAnsweringOrchestrationOptions, "ExportedQuestionAnsweringOrchestrationDetails");
@@clientName(AnalyzeConversationAuthoringOrchestrationExportedIntent, "OrchestrationExportedIntent");
@@clientName(AnalyzeConversationAuthoringOrchestrationExportedProjectAsset, "OrchestrationExportedProjectAsset");
@@clientName(AnalyzeConversationAuthoringOrchestrationExportedUtterance, "OrchestrationExportedUtterance");
@@clientName(AnalyzeConversationAuthoringExportedTrainedModel, "ConversationAuthoringExportedTrainedModel");
@@clientName(AnalyzeConversationAuthoringExportedTrainedModel.lastTrainedDateTime, "lastTrainedOn");
@@clientName(AnalyzeConversationAuthoringExportedTrainedModel.lastExportedModelDateTime, "lastExportedModelOn");
@@clientName(AnalyzeConversationAuthoringExportedTrainedModel.modelExpirationDate, "modelExpiredOn");
@@clientName(AnalyzeConversationAuthoringExportedModelJobState, "ConversationAuthoringExportedModelState");
@@clientName(AnalyzeConversationAuthoringModelFile, "ConversationAuthoringModelFile");
@@clientName(ExportedModelOptions, "ConversationAuthoringExportedModelDetails");

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model ConversationAuthoringProjectClientOptions {
  projectName: string;
}

// Root client definition
@client({
  name: "ConversationAuthoringClient",
  service: Language.Conversations.Authoring,
}, "python")
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
namespace ConversationAuthoringClient {

  op listProjects is Language.Conversations.Authoring.conversationAuthoringListProjects;

  op listSupportedLanguages is Language.Conversations.Authoring.conversationAuthoringListSupportedLanguages;

  op listAssignedResourceDeployments is Language.Conversations.Authoring.conversationAuthoringListAssignedResourceDeployments;

  op listSupportedPrebuiltEntities is Language.Conversations.Authoring.conversationAuthoringListSupportedPrebuiltEntities;

  op listTrainingConfigVersions is Language.Conversations.Authoring.conversationAuthoringListTrainingConfigVersions;

  op createProject is Language.Conversations.Authoring.ConversationAuthoringProject.createProject;

  op getProject is Language.Conversations.Authoring.ConversationAuthoringProject.getProject;

  op deleteProject is Language.Conversations.Authoring.ConversationAuthoringProject.deleteProject;
}


@client({
  name: "ConversationAuthoringProjectClient",
  service: Language.Conversations.Authoring,
}, "python")
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
namespace ConversationAuthoringProjectClient {
  @operationGroup
  interface DeploymentOperations {
    getDeployment is Language.Conversations.Authoring.ConversationAuthoringDeployment.getDeployment;

    deployProject is Language.Conversations.Authoring.ConversationAuthoringDeployment.deployProject;

    deleteDeployment is Language.Conversations.Authoring.ConversationAuthoringDeployment.deleteDeployment;

    deleteDeploymentFromResources is Language.Conversations.Authoring.ConversationAuthoringDeployment.deleteDeploymentFromResources;

    getDeploymentDeleteFromResourcesStatus is Language.Conversations.Authoring.ConversationAuthoringDeployment.getDeploymentDeleteFromResourcesStatus;

    getDeploymentStatus is Language.Conversations.Authoring.ConversationAuthoringDeployment.getDeploymentStatus;
  }

  @operationGroup
  interface ProjectOperations {
    listTrainedModels is Language.Conversations.Authoring.conversationAuthoringListTrainedModels;

    listTrainingJobs is Language.Conversations.Authoring.conversationAuthoringListTrainingJobs;

    listDeploymentResources is Language.Conversations.Authoring.conversationAuthoringListDeploymentResources;

    listDeployments is Language.Conversations.Authoring.conversationAuthoringListDeployments;

    listExportedModels is Language.Conversations.Authoring.conversationAuthoringListExportedModels;

    assignDeploymentResources is Language.Conversations.Authoring.ConversationAuthoringProject.assignDeploymentResources;

    unassignDeploymentResources is Language.Conversations.Authoring.ConversationAuthoringProject.unassignDeploymentResources;

    getAssignDeploymentResourcesStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getAssignDeploymentResourcesStatus;

    getUnassignDeploymentResourcesStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getUnassignDeploymentResourcesStatus;

    swapDeployments is Language.Conversations.Authoring.ConversationAuthoringProject.swapDeployments;

    getSwapDeploymentsStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getSwapDeploymentsStatus;

    getProject is Language.Conversations.Authoring.ConversationAuthoringProject.getProject;

    getProjectDeletionStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getProjectDeletionStatus;

    `export` is Language.Conversations.Authoring.ConversationAuthoringProject.`export`;

    `import` is Language.Conversations.Authoring.ConversationAuthoringProject.`import`;

    getExportStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getExportStatus;

    getImportStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getImportStatus;

    copyProjectAuthorization is Language.Conversations.Authoring.ConversationAuthoringProject.copyProjectAuthorization;

    copyProject is Language.Conversations.Authoring.ConversationAuthoringProject.copyProject;

    getCopyProjectStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getCopyProjectStatus;

    train is Language.Conversations.Authoring.ConversationAuthoringProject.train;

    getTrainingStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getTrainingStatus;

    cancelTrainingJob is Language.Conversations.Authoring.ConversationAuthoringProject.cancelTrainingJob;
  }

  @operationGroup
  interface ExportedModel {
    getExportedModel is  Language.Conversations.Authoring.ConversationAuthoringExportedModel.getExportedModel;

    deleteExportedModel is Language.Conversations.Authoring.ConversationAuthoringExportedModel.deleteExportedModel;

    createOrUpdateExportedModel is Language.Conversations.Authoring.ConversationAuthoringExportedModel.createOrUpdateExportedModel;

    getExportedModelJobStatus is Language.Conversations.Authoring.ConversationAuthoringExportedModel.getExportedModelJobStatus;
  }

  @operationGroup
  interface TrainedModel {
    getTrainedModel is  Language.Conversations.Authoring.ConversationAuthoringTrainedModel.getTrainedModel;

    deleteTrainedModel is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.deleteTrainedModel;

    evaluateModel is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.evaluateModel;

    loadSnapshot is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.loadSnapshot;

    getEvaluationStatus is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.getEvaluationStatus;

    getModelEvaluationResults is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.getModelEvaluationResults;

    getModelEvaluationSummary is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.getModelEvaluationSummary;

    getLoadSnapshotStatus is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.getLoadSnapshotStatus;
  }
}

@@clientInitialization(ConversationAuthoringProjectClient, {
  parameters: ConversationAuthoringProjectClientOptions,
}, "python");