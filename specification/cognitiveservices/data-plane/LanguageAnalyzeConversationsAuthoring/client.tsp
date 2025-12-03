import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using Language.Conversations.Authoring;
using Azure.ClientGenerator.Core;
using Versioning;

@useDependency(Language.Conversations.Authoring.Versions.v2025_11_15_preview)
namespace Language.ConversationsAuthoringClientCustomizations;

@@clientName(conversationAuthoringListSupportedLanguages,
  "listSupportedLanguages"
);
@@clientName(conversationAuthoringListAssignedResourceDeployments,
  "listAssignedResourceDeployments"
);
@@clientName(conversationAuthoringListProjectResources,
  "listProjectResources"
);
@@clientName(conversationAuthoringListSupportedPrebuiltEntities,
  "listSupportedPrebuiltEntities"
);
@@clientName(conversationAuthoringListTrainingConfigVersions,
  "listTrainingConfigVersions"
);
@@clientName(conversationAuthoringListTrainingJobs, "listTrainingJobs");
@@clientName(conversationAuthoringListTrainedModels, "listTrainedModels");
@@clientName(conversationAuthoringListExportedModels, "listExportedModels");

@@clientName(ConversationAuthoringProject.copyProjectAuthorization,
  "AuthorizeProjectCopy"
);
@@clientName(ProjectKind, "ConversationAuthoringProjectKind");
@@clientName(ProjectKind, "ProjectKind", "python");
@@clientName(ErrorCode, "ConversationAuthoringErrorCode");
@@clientName(ErrorCode, "ErrorCode", "python");
@@clientName(InnerErrorCode, "ConversationAuthoringInnerErrorCode");
@@clientName(InnerErrorCode, "InnerErrorCode", "python");
@@clientName(StringIndexType, "StringIndexType");
@@clientName(ExportedProjectFormat,
  "ConversationAuthoringExportedProjectFormat"
);
@@clientName(ExportedProjectFormat, "ExportedProjectFormat", "python");
@@clientName(TrainingMode, "ConversationAuthoringTrainingMode");
@@clientName(TrainingMode, "TrainingMode", "python");
@@clientName(EvaluationKind, "ConversationAuthoringEvaluationKind");
@@clientName(EvaluationKind, "EvaluationKind", "python");
@@clientName(JobStatus, "ConversationAuthoringOperationStatus");
@@clientName(JobStatus, "OperationStatus", "python");
@@clientName(CompositionSetting, "ConversationAuthoringCompositionMode");
@@clientName(CompositionSetting, "CompositionMode", "python");
@@clientName(OrchestrationTargetProjectKind, "OrchestrationTargetProjectKind");

@@clientName(AnalyzeConversationAuthoringProjectsMetadata,
  "ConversationAuthoringProjectsMetadata"
);
@@clientName(AnalyzeConversationAuthoringProjectsMetadata,
  "ProjectsMetadata",
  "python"
);
@@clientName(AnalyzeConversationAuthoringProjectMetadata,
  "ConversationAuthoringProjectMetadata"
);
@@clientName(AnalyzeConversationAuthoringProjectMetadata,
  "ProjectDetails",
  "python"
);
@@clientName(AnalyzeConversationAuthoringProjectMetadata.createdDateTime,
  "createdOn"
);
@@clientName(AnalyzeConversationAuthoringProjectMetadata.lastModifiedDateTime,
  "lastModifiedOn"
);
@@clientName(AnalyzeConversationAuthoringProjectMetadata.lastTrainedDateTime,
  "lastTrainedOn"
);
@@clientName(AnalyzeConversationAuthoringProjectMetadata.lastDeployedDateTime,
  "lastDeployedOn"
);
@@clientName(AnalyzeConversationAuthoringProjectSettings,
  "ConversationAuthoringProjectSettings"
);
@@clientName(AnalyzeConversationAuthoringProjectSettings,
  "ProjectSettings",
  "python"
);
@@clientName(InnerErrorModel, "ConversationAuthoringInnerErrorModel");
@@clientName(InnerErrorModel, "InnerErrorModel", "python");
@@clientName(AnalyzeConversationAuthoringCreateProjectOptions,
  "ConversationAuthoringCreateProjectDetails"
);
@@clientName(AnalyzeConversationAuthoringCreateProjectOptions,
  "CreateProjectOptions",
  "python"
);
@@clientName(AnalyzeConversationAuthoringCopyAuthorizationOptions,
  "ConversationAuthoringCopyAuthorizationDetails"
);
@@clientName(AnalyzeConversationAuthoringCopyAuthorizationOptions,
  "CopyAuthorizationDetails",
  "python"
);
@@clientName(AnalyzeConversationAuthoringCopiedProjectOptions,
  "ConversationAuthoringCopyProjectDetails"
);
@@clientName(AnalyzeConversationAuthoringCopiedProjectOptions,
  "CopyProjectDetails",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportedProject,
  "ConversationAuthoringExportedProject"
);
@@clientName(AnalyzeConversationAuthoringExportedProject,
  "ExportedProject",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportedProjectAssets,
  "ConversationAuthoringExportedProjectAsset"
);
@@clientName(AnalyzeConversationAuthoringExportedProjectAssets,
  "ExportedProjectAsset",
  "python"
);
@@clientName(AnalyzeConversationAuthoringTrainingJobOptions,
  "ConversationAuthoringTrainingJobDetails"
);
@@clientName(AnalyzeConversationAuthoringTrainingJobOptions,
  "TrainingJobDetails",
  "python"
);
@@clientName(AnalyzeConversationAuthoringEvaluationOptions,
  "ConversationAuthoringEvaluationDetails"
);
@@clientName(AnalyzeConversationAuthoringEvaluationOptions,
  "EvaluationDetails",
  "python"
);
@@clientName(AnalyzeConversationAuthoringCopiedProjectJobState,
  "ConversationAuthoringCopyProjectState"
);
@@clientName(AnalyzeConversationAuthoringCopiedProjectJobState,
  "CopyProjectState",
  "python"
);
@@clientName(AnalyzeConversationAuthoringJobState,
  "ConversationAuthoringState"
);
@@clientName(AnalyzeConversationAuthoringJobState, "State", "python");
@@clientName(AnalyzeConversationAuthoringJobState.createdDateTime, "createdOn");
@@clientName(AnalyzeConversationAuthoringJobState.lastUpdatedDateTime,
  "lastUpdatedOn"
);
@@clientName(AnalyzeConversationAuthoringJobState.expirationDateTime,
  "expiresOn"
);
@@clientName(AnalyzeConversationAuthoringProjectDeployments,
  "ConversationAuthoringProjectDeployments"
);
@@clientName(AnalyzeConversationAuthoringProjectDeployments,
  "ProjectDeployments",
  "python"
);
@@clientName(AnalyzeConversationAuthoringProjectDeployment,
  "ConversationAuthoringProjectDeployment"
);
@@clientName(AnalyzeConversationAuthoringProjectDeployment,
  "ProjectDeployment",
  "python"
);
@@clientName(AnalyzeConversationAuthoringProjectDeployment.lastTrainedDateTime,
  "lastTrainedOn"
);
@@clientName(AnalyzeConversationAuthoringProjectDeployment.lastDeployedDateTime,
  "lastDeployedOn"
);
@@clientName(AnalyzeConversationAuthoringProjectDeployment.deploymentExpirationDate,
  "deploymentExpiredOn"
);
@@clientName(AnalyzeConversationAuthoringDeploymentResource,
  "ConversationAuthoringDeploymentResource"
);
@@clientName(AnalyzeConversationAuthoringDeploymentResource,
  "DeploymentResource",
  "python"
);
@@clientName(AnalyzeConversationAuthoringCreateDeploymentOptions,
  "ConversationAuthoringCreateDeploymentDetails"
);
@@clientName(AnalyzeConversationAuthoringCreateDeploymentOptions,
  "CreateDeploymentDetails",
  "python"
);
@@clientName(AnalyzeConversationAuthoringProjectAzureResourceIds,
  "ConversationAuthoringProjectResourceIds"
);
@@clientName(AnalyzeConversationAuthoringProjectAzureResourceIds,
  "ProjectResourceIds",
  "python"
);
@@clientName(AnalyzeConversationAuthoringDeploymentJobState,
  "ConversationAuthoringDeploymentState"
);
@@clientName(AnalyzeConversationAuthoringDeploymentJobState,
  "DeploymentState",
  "python"
);
@@clientName(AnalyzeConversationAuthoringDeploymentDeleteFromResourcesJobState,
  "ConversationAuthoringDeploymentDeleteFromResourcesState"
);
@@clientName(AnalyzeConversationAuthoringDeploymentDeleteFromResourcesJobState,
  "DeploymentDeleteFromResourcesState",
  "python"
);
@@clientName(AnalyzeConversationAuthoringSwapDeploymentsJobState,
  "ConversationAuthoringSwapDeploymentsState"
);
@@clientName(AnalyzeConversationAuthoringSwapDeploymentsJobState,
  "SwapDeploymentsState",
  "python"
);
@@clientName(AnalyzeConversationAuthoringSwapDeploymentsOptions,
  "ConversationAuthoringSwapDeploymentsDetails"
);
@@clientName(AnalyzeConversationAuthoringSwapDeploymentsOptions,
  "SwapDeploymentsDetails",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportProjectJobState,
  "ConversationAuthoringExportProjectState"
);
@@clientName(AnalyzeConversationAuthoringExportProjectJobState,
  "ExportProjectState",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportProjectJobState.resultUrl,
  "resultUri"
);
@@clientName(AnalyzeConversationAuthoringImportProjectJobState,
  "ConversationAuthoringImportProjectState"
);
@@clientName(AnalyzeConversationAuthoringImportProjectJobState,
  "ImportProjectState",
  "python"
);
@@clientName(AnalyzeConversationAuthoringProjectTrainedModels,
  "ConversationAuthoringProjectTrainedModels"
);
@@clientName(AnalyzeConversationAuthoringProjectTrainedModels,
  "ProjectTrainedModels",
  "python"
);
@@clientName(AnalyzeConversationAuthoringProjectTrainedModel,
  "ConversationAuthoringProjectTrainedModel"
);
@@clientName(AnalyzeConversationAuthoringProjectTrainedModel,
  "ProjectTrainedModel",
  "python"
);
@@clientName(AnalyzeConversationAuthoringProjectTrainedModel.lastTrainedDateTime,
  "lastTrainedOn"
);
@@clientName(AnalyzeConversationAuthoringProjectTrainedModel.modelExpirationDate,
  "modelExpiredOn"
);
@@clientName(AnalyzeConversationAuthoringEvaluationJobState,
  "ConversationAuthoringEvaluationState"
);
@@clientName(AnalyzeConversationAuthoringEvaluationJobState,
  "EvaluationState",
  "python"
);
@@clientName(AnalyzeConversationAuthoringEvaluationJobResult,
  "ConversationAuthoringEvaluationJobResult"
);
@@clientName(AnalyzeConversationAuthoringEvaluationJobResult,
  "EvaluationJobResult",
  "python"
);
@@clientName(AnalyzeConversationAuthoringEvaluationJobResult.evaluationOptions,
  "evaluationDetails"
);
@@clientName(AnalyzeConversationAuthoringEvaluationResults,
  "ConversationAuthoringEvalResults"
);
@@clientName(AnalyzeConversationAuthoringEvaluationResults,
  "EvalResults",
  "python"
);
@@clientName(AnalyzeConversationAuthoringEvaluationSummary,
  "ConversationAuthoringEvalSummary"
);
@@clientName(AnalyzeConversationAuthoringEvaluationSummary,
  "EvalSummary",
  "python"
);
@@clientName(AnalyzeConversationAuthoringEntitiesEvaluationSummary,
  "EntitiesEvaluationSummary"
);
@@clientName(AnalyzeConversationAuthoringIntentsEvaluationSummary,
  "IntentsEvaluationSummary"
);
@@clientName(AnalyzeConversationAuthoringIntentEvaluationSummary,
  "IntentEvaluationSummary"
);
@@clientName(AnalyzeConversationAuthoringLoadSnapshotJobState,
  "ConversationAuthoringLoadSnapshotState"
);
@@clientName(AnalyzeConversationAuthoringLoadSnapshotJobState,
  "LoadSnapshotState",
  "python"
);
@@clientName(AnalyzeConversationAuthoringDeploymentResourcesInfoList,
  "ConversationAuthoringAssignedDeploymentResources"
);
@@clientName(AnalyzeConversationAuthoringDeploymentResourcesInfoList,
  "AssignedDeploymentResources",
  "python"
);
@@clientName(AnalyzeConversationAuthoringProjectResourceInfo,
  "ConversationAuthoringAssignedProjectResource"
);
@@clientName(AnalyzeConversationAuthoringProjectResourceInfo,
  "AssignedProjectResource",
  "python"
);
@@clientName(AnalyzeConversationAuthoringProjectResourceInfo.azureResourceId,
  "resourceId"
);
@@clientName(AnalyzeConversationAuthoringProjectResourceAssignments,
  "ConversationAuthoringAssignProjectResourcesDetails"
);
@@clientName(AnalyzeConversationAuthoringProjectResourceAssignments,
  "AssignProjectResourcesDetails",
  "python"
);
@@clientName(AnalyzeConversationAuthoringProjectResourceAssignments.projectResources,
  "metadata"
);
@@clientName(AnalyzeConversationAuthoringProjectResourceAssignmentInfo,
  "ConversationAuthoringResourceMetadata"
);
@@clientName(AnalyzeConversationAuthoringProjectResourceAssignmentInfo,
  "ResourceMetadata",
  "python"
);
@@clientName(AnalyzeConversationAuthoringUnassignDeploymentResourcesOptions,
  "ConversationAuthoringUnassignDeploymentResourcesDetails"
);
@@clientName(AnalyzeConversationAuthoringUnassignDeploymentResourcesOptions,
  "UnassignDeploymentResourcesDetails",
  "python"
);
@@clientName(AnalyzeConversationAuthoringProjectResourcesJobState,
  "ConversationAuthoringProjectResourcesState"
);
@@clientName(AnalyzeConversationAuthoringProjectResourcesJobState,
  "ProjectResourcesState",
  "python"
);
@@clientName(AnalyzeConversationAuthoringTrainingJobs,
  "ConversationAuthoringTrainingJobs"
);
@@clientName(AnalyzeConversationAuthoringTrainingJobs,
  "TrainingJobs",
  "python"
);
@@clientName(AnalyzeConversationAuthoringTrainingJobState,
  "ConversationAuthoringTrainingState"
);
@@clientName(AnalyzeConversationAuthoringTrainingJobState,
  "TrainingState",
  "python"
);
@@clientName(AnalyzeConversationAuthoringTrainingJobResult,
  "ConversationAuthoringTrainingJobResult"
);
@@clientName(AnalyzeConversationAuthoringTrainingJobResult,
  "TrainingJobResult",
  "python"
);
@@clientName(AnalyzeConversationAuthoringTrainingJobResult.estimatedEndDateTime,
  "estimatedEndOn"
);
@@clientName(AnalyzeConversationAuthoringSubTrainingJobState,
  "ConversationAuthoringSubTrainingState"
);
@@clientName(AnalyzeConversationAuthoringSubTrainingJobState,
  "SubTrainingState",
  "python"
);
@@clientName(AnalyzeConversationAuthoringSubTrainingJobState.startDateTime,
  "startedOn"
);
@@clientName(AnalyzeConversationAuthoringSubTrainingJobState.endDateTime,
  "endedOn"
);
@@clientName(AnalyzeConversationAuthoringProjectDeletionJobState,
  "ConversationAuthoringProjectDeletionState"
);
@@clientName(AnalyzeConversationAuthoringProjectDeletionJobState,
  "ProjectDeletionState",
  "python"
);
@@clientName(AnalyzeConversationAuthoringAssignedResourceDeploymentsMetadata,
  "ConversationAuthoringAssignedResourceDeploymentsMetadata"
);
@@clientName(AnalyzeConversationAuthoringAssignedResourceDeploymentsMetadata,
  "AssignedResourceDeploymentsMetadata",
  "python"
);
@@clientName(AnalyzeConversationAuthoringAssignedProjectDeploymentsMetadata,
  "ConversationAuthoringAssignedProjectDeploymentsMetadata"
);
@@clientName(AnalyzeConversationAuthoringAssignedProjectDeploymentsMetadata,
  "AssignedProjectDeploymentsMetadata",
  "python"
);
@@clientName(AnalyzeConversationAuthoringAssignedProjectDeploymentMetadata,
  "ConversationAuthoringAssignedProjectDeploymentMetadata"
);
@@clientName(AnalyzeConversationAuthoringAssignedProjectDeploymentMetadata,
  "AssignedProjectDeploymentMetadata",
  "python"
);
@@clientName(AnalyzeConversationAuthoringAssignedProjectDeploymentMetadata.lastDeployedDateTime,
  "lastDeployedOn"
);
@@clientName(AnalyzeConversationAuthoringAssignedProjectDeploymentMetadata.deploymentExpirationDate,
  "DeploymentExpiresOn"
);
@@clientName(AnalyzeConversationAuthoringSupportedLanguages,
  "ConversationAuthoringSupportedLanguages"
);
@@clientName(AnalyzeConversationAuthoringSupportedLanguages,
  "SupportedLanguages",
  "python"
);
@@clientName(AnalyzeConversationAuthoringSupportedLanguage,
  "ConversationAuthoringSupportedLanguage"
);
@@clientName(AnalyzeConversationAuthoringSupportedLanguage,
  "SupportedLanguage",
  "python"
);
@@clientName(AnalyzeConversationAuthoringPrebuiltEntities,
  "ConversationAuthoringPrebuiltEntities"
);
@@clientName(AnalyzeConversationAuthoringPrebuiltEntities,
  "PrebuiltEntities",
  "python"
);
@@clientName(AnalyzeConversationAuthoringPrebuiltEntity,
  "ConversationAuthoringPrebuiltEntity"
);
@@clientName(AnalyzeConversationAuthoringPrebuiltEntity,
  "PrebuiltEntity",
  "python"
);
@@clientName(AnalyzeConversationAuthoringTrainingConfigVersions,
  "ConversationAuthoringTrainingConfigVersions"
);
@@clientName(AnalyzeConversationAuthoringTrainingConfigVersions,
  "TrainingConfigVersions",
  "python"
);
@@clientName(AnalyzeConversationAuthoringTrainingConfigVersion,
  "ConversationAuthoringTrainingConfigVersion"
);
@@clientName(AnalyzeConversationAuthoringTrainingConfigVersion,
  "TrainingConfigVersion",
  "python"
);
@@clientName(AnalyzeConversationAuthoringConversationExportedEntity,
  "ConversationExportedEntity"
);
@@clientName(AnalyzeConversationAuthoringConversationExportedEntity,
  "ConversationExportedEntity",
  "python"
);
@@clientName(AnalyzeConversationAuthoringConversationExportedEntity.compositionSetting,
  "compositionMode"
);
@@clientName(AnalyzeConversationAuthoringExportedEntityList,
  "ConversationAuthoringExportedEntityList"
);
@@clientName(AnalyzeConversationAuthoringExportedEntityList,
  "ExportedEntityList",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportedEntitySublist,
  "ConversationAuthoringExportedEntitySublist"
);
@@clientName(AnalyzeConversationAuthoringExportedEntitySublist,
  "ExportedEntitySublist",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportedEntityListSynonym,
  "ConversationAuthoringExportedEntityListSynonym"
);
@@clientName(AnalyzeConversationAuthoringExportedEntityListSynonym,
  "ExportedEntityListSynonym",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportedPrebuiltEntity,
  "ConversationAuthoringExportedPrebuiltEntity"
);
@@clientName(AnalyzeConversationAuthoringExportedPrebuiltEntity,
  "ExportedPrebuiltEntity",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportedEntityRegex,
  "ExportedEntityRegex"
);
@@clientName(AnalyzeConversationAuthoringExportedEntityRegex,
  "ExportedEntityRegex",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportedEntityRegexExpression,
  "ExportedEntityRegexExpression"
);
@@clientName(AnalyzeConversationAuthoringExportedEntityRegexExpression,
  "ExportedEntityRegexExpression",
  "python"
);
@@clientName(AnalyzeConversationAuthoringConversationExportedIntent,
  "ConversationExportedIntent"
);
@@clientName(AnalyzeConversationAuthoringConversationExportedIntent,
  "ConversationExportedIntent",
  "python"
);
@@clientName(AnalyzeConversationExportedAssociatedEntityLabel,
  "ConversationExportedAssociatedEntityLabel"
);
@@clientName(AnalyzeConversationExportedAssociatedEntityLabel,
  "ConversationExportedAssociatedEntityLabel",
  "python"
);
@@clientName(AnalyzeConversationAuthoringConversationExportedProjectAsset,
  "ConversationExportedProjectAsset"
);
@@clientName(AnalyzeConversationAuthoringConversationExportedProjectAsset,
  "ConversationExportedProjectAsset",
  "python"
);
@@clientName(AnalyzeConversationAuthoringConversationExportedUtterance,
  "ConversationExportedUtterance"
);
@@clientName(AnalyzeConversationAuthoringConversationExportedUtterance,
  "ConversationExportedUtterance",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportedUtteranceEntityLabel,
  "ExportedUtteranceEntityLabel"
);
@@clientName(AnalyzeConversationAuthoringExportedUtteranceEntityLabel,
  "ExportedUtteranceEntityLabel",
  "python"
);
@@clientName(AnalyzeConversationAuthoringConversationSummarizationExportedProjectAsset,
  "ConversationSummarizationExportedProjectAsset"
);
@@clientName(AnalyzeConversationAuthoringConversationSummarizationExportedProjectAsset,
  "ConversationSummarizationExportedProjectAsset",
  "python"
);
@@clientName(AnalyzeConversationAuthoringCustomConversationSummarizationConversation,
  "CustomConversationSummarizationConversation"
);
@@clientName(AnalyzeConversationAuthoringCustomConversationSummarizationConversation,
  "CustomConversationSummarizationConversation",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportedConversationOrchestration,
  "ExportedConversationOrchestration"
);
@@clientName(AnalyzeConversationAuthoringExportedConversationOrchestration,
  "ExportedConversationOrchestration",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportedConversationOrchestrationOptions,
  "ExportedConversationOrchestrationDetails"
);
@@clientName(AnalyzeConversationAuthoringExportedConversationOrchestrationOptions,
  "ExportedConversationOrchestrationDetails",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportedOrchestrationOptions,
  "ExportedOrchestrationDetails"
);
@@clientName(AnalyzeConversationAuthoringExportedOrchestrationOptions,
  "ExportedOrchestrationDetails",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportedLuisOrchestration,
  "ExportedLuisOrchestration"
);
@@clientName(AnalyzeConversationAuthoringExportedLuisOrchestration,
  "ExportedLuisOrchestration",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportedLuisOrchestrationOptions,
  "ExportedLuisOrchestrationDetails"
);
@@clientName(AnalyzeConversationAuthoringExportedLuisOrchestrationOptions,
  "ExportedLuisOrchestrationDetails",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportedQuestionAnsweringOrchestration,
  "ExportedQuestionAnsweringOrchestration"
);
@@clientName(AnalyzeConversationAuthoringExportedQuestionAnsweringOrchestration,
  "ExportedQuestionAnsweringOrchestration",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportedQuestionAnsweringOrchestrationOptions,
  "ExportedQuestionAnsweringOrchestrationDetails"
);
@@clientName(AnalyzeConversationAuthoringExportedQuestionAnsweringOrchestrationOptions,
  "ExportedQuestionAnsweringOrchestrationDetails",
  "python"
);
@@clientName(AnalyzeConversationAuthoringOrchestrationExportedIntent,
  "OrchestrationExportedIntent"
);
@@clientName(AnalyzeConversationAuthoringOrchestrationExportedIntent,
  "OrchestrationExportedIntent",
  "python"
);
@@clientName(AnalyzeConversationAuthoringOrchestrationExportedProjectAsset,
  "OrchestrationExportedProjectAsset"
);
@@clientName(AnalyzeConversationAuthoringOrchestrationExportedProjectAsset,
  "OrchestrationExportedProjectAsset",
  "python"
);
@@clientName(AnalyzeConversationAuthoringOrchestrationExportedUtterance,
  "OrchestrationExportedUtterance"
);
@@clientName(AnalyzeConversationAuthoringOrchestrationExportedUtterance,
  "OrchestrationExportedUtterance",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportedTrainedModel,
  "ConversationAuthoringExportedTrainedModel"
);
@@clientName(AnalyzeConversationAuthoringExportedTrainedModel,
  "ExportedTrainedModel",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportedTrainedModel.lastTrainedDateTime,
  "lastTrainedOn"
);
@@clientName(AnalyzeConversationAuthoringExportedTrainedModel.lastExportedModelDateTime,
  "lastExportedModelOn"
);
@@clientName(AnalyzeConversationAuthoringExportedTrainedModel.modelExpirationDate,
  "modelExpiredOn"
);
@@clientName(AnalyzeConversationAuthoringExportedModelJobState,
  "ConversationAuthoringExportedModelState"
);
@@clientName(AnalyzeConversationAuthoringExportedModelJobState,
  "ExportedModelState",
  "python"
);
@@clientName(AnalyzeConversationAuthoringModelFile,
  "ConversationAuthoringModelFile"
);
@@clientName(AnalyzeConversationAuthoringModelFile, "ModelFile", "python");
@@clientName(ExportedModelOptions, "ConversationAuthoringExportedModelDetails");
@@clientName(ExportedModelOptions, "ExportedModelDetails", "python");
@@clientName(AnalyzeConversationAuthoringUtteranceEvaluationResult,
  "UtteranceEvaluationResult"
);
@@clientName(AnalyzeConversationAuthoringUtteranceEvaluationResult,
  "UtteranceEvaluationResult",
  "python"
);

@@clientName(AnalyzeConversationAuthoringConfusionMatrixCell,
  "ConfusionMatrixCell",
  "python"
);
@@clientName(AnalyzeConversationAuthoringConfusionMatrixRow,
  "ConfusionMatrixRow",
  "python"
);
@@clientName(AnalyzeConversationAuthoringDataGenerationConnectionInfo,
  "DataGenerationConnectionInfo",
  "python"
);
@@clientName(AnalyzeConversationAuthoringDataGenerationConnectionKind,
  "DataGenerationConnectionKind",
  "python"
);
@@clientName(AnalyzeConversationAuthoringDataGenerationSettings,
  "DataGenerationSettings",
  "python"
);
@@clientName(AnalyzeConversationAuthoringEntityEvaluationSummary,
  "ConversationAuthoringEntityEvalSummary"
);
@@clientName(AnalyzeConversationAuthoringEntityEvaluationSummary,
  "EntityEvaluationSummary",
  "python"
);
@@clientName(AnalyzeConversationAuthoringUtteranceEntitiesEvaluationResult,
  "UtteranceEntitiesEvaluationResult",
  "python"
);
@@clientName(AnalyzeConversationAuthoringUtteranceEntityEvaluationResult,
  "UtteranceEntityEvaluationResult",
);
@@clientName(AnalyzeConversationAuthoringUtteranceEntityEvaluationResult,
  "UtteranceEntityEvaluationResult",
  "python"
);
@@clientName(AnalyzeConversationAuthoringUtteranceIntentsEvaluationResult,
  "UtteranceIntentsEvaluationResult",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportedEntityListSynonym.values,
  "synonyms",
  "python"
);
@@clientName(AnalyzeConversationAuthoringExportedEntityListSynonym.values,
  "synonyms",
  "python"
);
@@clientName(ConversationAuthoringProject.`import`, "importProject", "python");

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model ConversationAuthoringProjectClientOptions {
  projectName: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model ConversationAuthoringDeploymentClientOptions {
  projectName: string;
  deploymentName: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model ConversationAuthoringExportedModelClientOptions {
  projectName: string;
  exportedModelName: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model ConversationAuthoringTrainedModelClientOptions {
  projectName: string;
  trainedModelLabel: string;
}

// Root client definition
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@client(
  {
    name: "ConversationAuthoringClient",
    service: Language.Conversations.Authoring,
  },
  "python"
)
@client(
  {
    name: "ConversationAnalysisAuthoringClient",
    service: Language.Conversations.Authoring,
  },
  "csharp"
)
namespace ConversationAuthoringClient {
  
  op listProjects is Language.Conversations.Authoring.conversationAuthoringListProjects;

  op listSupportedLanguages is Language.Conversations.Authoring.conversationAuthoringListSupportedLanguages;

  op listAssignedResourceDeployments is Language.Conversations.Authoring.conversationAuthoringListAssignedResourceDeployments;

  op listSupportedPrebuiltEntities is Language.Conversations.Authoring.conversationAuthoringListSupportedPrebuiltEntities;

  op listTrainingConfigVersions is Language.Conversations.Authoring.conversationAuthoringListTrainingConfigVersions;

  op createProject is Language.Conversations.Authoring.ConversationAuthoringProject.createProject;

  op getProject is Language.Conversations.Authoring.ConversationAuthoringProject.getProject;

  op deleteProject is Language.Conversations.Authoring.ConversationAuthoringProject.deleteProject;

  op getExportStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getExportStatus;

  op getImportStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getImportStatus;
  
  @operationGroup
  @clientInitialization(ConversationAuthoringDeploymentClientOptions, "csharp")
  @clientName("ConversationAuthoringDeployment", "csharp")
  interface DeploymentOperations {
    getDeployment is Language.Conversations.Authoring.ConversationAuthoringDeployment.getDeployment;

    deployProject is Language.Conversations.Authoring.ConversationAuthoringDeployment.deployProject;

    deleteDeployment is Language.Conversations.Authoring.ConversationAuthoringDeployment.deleteDeployment;

    deleteDeploymentFromResources is Language.Conversations.Authoring.ConversationAuthoringDeployment.deleteDeploymentFromResources;

    getDeploymentDeleteFromResourcesStatus is Language.Conversations.Authoring.ConversationAuthoringDeployment.getDeploymentDeleteFromResourcesStatus;

    getDeploymentStatus is Language.Conversations.Authoring.ConversationAuthoringDeployment.getDeploymentStatus;
  }

  @operationGroup
  @clientInitialization(ConversationAuthoringProjectClientOptions, "csharp")
  @clientName("ConversationAuthoringProject", "csharp")
  interface ProjectOperations {
    listTrainedModels is Language.Conversations.Authoring.conversationAuthoringListTrainedModels;

    listTrainingJobs is Language.Conversations.Authoring.conversationAuthoringListTrainingJobs;

    listProjectResources is Language.Conversations.Authoring.conversationAuthoringListProjectResources;

    listDeployments is Language.Conversations.Authoring.conversationAuthoringListDeployments;

    listExportedModels is Language.Conversations.Authoring.conversationAuthoringListExportedModels;

    assignProjectResources is Language.Conversations.Authoring.ConversationAuthoringProject.assignProjectResources;

    unassignProjectResources is Language.Conversations.Authoring.ConversationAuthoringProject.unassignProjectResources;

    getAssignProjectResourcesStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getAssignProjectResourcesStatus;

    getUnassignProjectResourcesStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getUnassignProjectResourcesStatus;

    swapDeployments is Language.Conversations.Authoring.ConversationAuthoringProject.swapDeployments;

    getSwapDeploymentsStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getSwapDeploymentsStatus;

    getProject is Language.Conversations.Authoring.ConversationAuthoringProject.getProject;

    getProjectDeletionStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getProjectDeletionStatus;

    `import` is Language.Conversations.Authoring.ConversationAuthoringProject.`import`;

    export is Language.Conversations.Authoring.ConversationAuthoringProject.export;

    getExportStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getExportStatus;

    copyProjectAuthorization is Language.Conversations.Authoring.ConversationAuthoringProject.copyProjectAuthorization;

    copyProject is Language.Conversations.Authoring.ConversationAuthoringProject.copyProject;

    getCopyProjectStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getCopyProjectStatus;

    train is Language.Conversations.Authoring.ConversationAuthoringProject.train;

    getTrainingStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getTrainingStatus;

    cancelTrainingJob is Language.Conversations.Authoring.ConversationAuthoringProject.cancelTrainingJob;
  }

  @operationGroup
  @clientInitialization(ConversationAuthoringExportedModelClientOptions, "csharp")
  @clientName("ConversationAuthoringExportedModel", "csharp")
  interface ExportedModelOperations {
    getExportedModel is Language.Conversations.Authoring.ConversationAuthoringExportedModel.getExportedModel;

    deleteExportedModel is Language.Conversations.Authoring.ConversationAuthoringExportedModel.deleteExportedModel;

    createOrUpdateExportedModel is Language.Conversations.Authoring.ConversationAuthoringExportedModel.createOrUpdateExportedModel;

    getExportedModelJobStatus is Language.Conversations.Authoring.ConversationAuthoringExportedModel.getExportedModelJobStatus;
  }

  @operationGroup
  @clientInitialization(ConversationAuthoringTrainedModelClientOptions, "csharp")
  @clientName("ConversationAuthoringTrainedModel", "csharp")
  interface TrainedModelOperations {
    getTrainedModel is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.getTrainedModel;

    deleteTrainedModel is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.deleteTrainedModel;

    evaluateModel is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.evaluateModel;

    loadSnapshot is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.loadSnapshot;

    getEvaluationStatus is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.getEvaluationStatus;

    getModelEvaluationResults is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.getModelEvaluationResults;

    getModelEvaluationSummary is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.getModelEvaluationSummary;

    getLoadSnapshotStatus is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.getLoadSnapshotStatus;
  }
}

#suppress "@azure-tools/typespec-azure-core/use-standard-names"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@client(
  {
    name: "ConversationAuthoringProjectClient",
    service: Language.Conversations.Authoring,
  },
  "python"
)
namespace ConversationAuthoringProjectClient {
  @operationGroup
  @clientName("Deployment", "python")
  interface DeploymentOperations {
    getDeployment is Language.Conversations.Authoring.ConversationAuthoringDeployment.getDeployment;

    deployProject is Language.Conversations.Authoring.ConversationAuthoringDeployment.deployProject;

    deleteDeployment is Language.Conversations.Authoring.ConversationAuthoringDeployment.deleteDeployment;

    deleteDeploymentFromResources is Language.Conversations.Authoring.ConversationAuthoringDeployment.deleteDeploymentFromResources;

    getDeploymentDeleteFromResourcesStatus is Language.Conversations.Authoring.ConversationAuthoringDeployment.getDeploymentDeleteFromResourcesStatus;

    getDeploymentStatus is Language.Conversations.Authoring.ConversationAuthoringDeployment.getDeploymentStatus;
  }

  @operationGroup
  @clientName("Project", "python")
  interface ProjectOperations {
    listTrainedModels is Language.Conversations.Authoring.conversationAuthoringListTrainedModels;

    listTrainingJobs is Language.Conversations.Authoring.conversationAuthoringListTrainingJobs;

    listProjectResources is Language.Conversations.Authoring.conversationAuthoringListProjectResources;

    listDeployments is Language.Conversations.Authoring.conversationAuthoringListDeployments;

    listExportedModels is Language.Conversations.Authoring.conversationAuthoringListExportedModels;

    assignProjectResources is Language.Conversations.Authoring.ConversationAuthoringProject.assignProjectResources;

    unassignProjectResources is Language.Conversations.Authoring.ConversationAuthoringProject.unassignProjectResources;

    getAssignProjectResourcesStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getAssignProjectResourcesStatus;

    getUnassignProjectResourcesStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getUnassignProjectResourcesStatus;

    swapDeployments is Language.Conversations.Authoring.ConversationAuthoringProject.swapDeployments;

    getSwapDeploymentsStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getSwapDeploymentsStatus;

    getProject is Language.Conversations.Authoring.ConversationAuthoringProject.getProject;

    getProjectDeletionStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getProjectDeletionStatus;

    `import` is Language.Conversations.Authoring.ConversationAuthoringProject.`import`;

    export is Language.Conversations.Authoring.ConversationAuthoringProject.export;

    getExportStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getExportStatus;

    copyProjectAuthorization is Language.Conversations.Authoring.ConversationAuthoringProject.copyProjectAuthorization;

    copyProject is Language.Conversations.Authoring.ConversationAuthoringProject.copyProject;

    getCopyProjectStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getCopyProjectStatus;

    train is Language.Conversations.Authoring.ConversationAuthoringProject.train;

    getTrainingStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getTrainingStatus;

    cancelTrainingJob is Language.Conversations.Authoring.ConversationAuthoringProject.cancelTrainingJob;
  }

  @operationGroup
  @clientName("ExportedModel", "python")
  interface ExportedModelOperations {
    getExportedModel is Language.Conversations.Authoring.ConversationAuthoringExportedModel.getExportedModel;

    deleteExportedModel is Language.Conversations.Authoring.ConversationAuthoringExportedModel.deleteExportedModel;

    createOrUpdateExportedModel is Language.Conversations.Authoring.ConversationAuthoringExportedModel.createOrUpdateExportedModel;

    getExportedModelJobStatus is Language.Conversations.Authoring.ConversationAuthoringExportedModel.getExportedModelJobStatus;
  }

  @operationGroup
  @clientName("TrainedModel", "python")
  interface TrainedModelOperations {
    getTrainedModel is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.getTrainedModel;

    deleteTrainedModel is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.deleteTrainedModel;

    evaluateModel is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.evaluateModel;

    loadSnapshot is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.loadSnapshot;

    getEvaluationStatus is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.getEvaluationStatus;

    getModelEvaluationResults is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.getModelEvaluationResults;

    getModelEvaluationSummary is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.getModelEvaluationSummary;

    getLoadSnapshotStatus is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.getLoadSnapshotStatus;
  }
}

@@clientInitialization(ConversationAuthoringProjectClient,
  {
    parameters: ConversationAuthoringProjectClientOptions,
  },
  "python"
);
