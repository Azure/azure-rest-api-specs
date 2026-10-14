import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

using Language.Conversations.Authoring;
using Azure.ClientGenerator.Core;
using Versioning;

@useDependency(Language.Conversations.Authoring.Versions.v2025_11_15_preview)
namespace Language.ConversationsAuthoringClientCustomizations;

// C#-specific client name customizations
@@clientName(
  Language.Conversations.Authoring,
  "ConversationAnalysisAuthoring",
  "csharp"
);
@@clientName(
  AnalyzeConversationAuthoringUtteranceEntityEvaluationResult,
  "UtteranceEntityEvaluationResult",
  "csharp"
);

@@clientName(
  conversationAuthoringListDeployments,
  "listDeployments",
  "!autorest"
);
@@clientName(conversationAuthoringListProjects, "listProjects", "!autorest");
@@clientName(
  conversationAuthoringListSupportedLanguages,
  "listSupportedLanguages",
  "!autorest"
);
@@clientName(
  conversationAuthoringListAssignedResourceDeployments,
  "listAssignedResourceDeployments",
  "!autorest"
);
@@clientName(
  conversationAuthoringListProjectResources,
  "listDeploymentResources",
  "!autorest"
);
@@clientName(
  conversationAuthoringListSupportedPrebuiltEntities,
  "listSupportedPrebuiltEntities",
  "!autorest"
);
@@clientName(
  conversationAuthoringListTrainingConfigVersions,
  "listTrainingConfigVersions",
  "!autorest"
);
@@clientName(
  conversationAuthoringListTrainingJobs,
  "listTrainingJobs",
  "!autorest"
);
@@clientName(
  conversationAuthoringListTrainedModels,
  "listTrainedModels",
  "!autorest"
);
@@clientName(
  conversationAuthoringListExportedModels,
  "listExportedModels",
  "!autorest"
);

@@clientName(
  ConversationAuthoringProject.copyProjectAuthorization,
  "AuthorizeProjectCopy",
  "!autorest"
);
@@clientName(ProjectKind, "ConversationAuthoringProjectKind", "!autorest");
@@clientName(ProjectKind, "ProjectKind", "python");
@@clientName(ErrorCode, "ConversationAuthoringErrorCode", "!autorest");
@@clientName(ErrorCode, "ErrorCode", "python");
@@clientName(
  InnerErrorCode,
  "ConversationAuthoringInnerErrorCode",
  "!autorest"
);
@@clientName(InnerErrorCode, "InnerErrorCode", "python");
@@clientName(StringIndexType, "StringIndexType", "!autorest");
@@clientName(
  ExportedProjectFormat,
  "ConversationAuthoringExportedProjectFormat",
  "!autorest"
);
@@clientName(ExportedProjectFormat, "ExportedProjectFormat", "python");
@@clientName(TrainingMode, "ConversationAuthoringTrainingMode", "!autorest");
@@clientName(TrainingMode, "TrainingMode", "python");
@@clientName(
  EvaluationKind,
  "ConversationAuthoringEvaluationKind",
  "!autorest"
);
@@clientName(EvaluationKind, "EvaluationKind", "python");
@@clientName(JobStatus, "ConversationAuthoringOperationStatus", "!autorest");
@@clientName(JobStatus, "OperationStatus", "python");
@@clientName(
  CompositionSetting,
  "ConversationAuthoringCompositionMode",
  "!autorest"
);
@@clientName(CompositionSetting, "CompositionMode", "python");
@@clientName(
  OrchestrationTargetProjectKind,
  "OrchestrationTargetProjectKind",
  "!autorest"
);

@@clientName(
  AnalyzeConversationAuthoringProjectsMetadata,
  "ConversationAuthoringProjectsMetadata",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectsMetadata,
  "ProjectsMetadata",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringProjectMetadata,
  "ConversationAuthoringProjectMetadata",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectMetadata,
  "ProjectDetails",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringProjectMetadata.createdDateTime,
  "createdOn",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectMetadata.lastModifiedDateTime,
  "lastModifiedOn",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectMetadata.lastTrainedDateTime,
  "lastTrainedOn",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectMetadata.lastDeployedDateTime,
  "lastDeployedOn",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectSettings,
  "ConversationAuthoringProjectSettings",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectSettings,
  "ProjectSettings",
  "python"
);
@@clientName(
  InnerErrorModel,
  "ConversationAuthoringInnerErrorModel",
  "!autorest"
);
@@clientName(InnerErrorModel, "InnerErrorModel", "python");
@@clientName(
  AnalyzeConversationAuthoringCreateProjectOptions,
  "ConversationAuthoringCreateProjectDetails",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringCreateProjectOptions,
  "CreateProjectOptions",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringCopyAuthorizationOptions,
  "ConversationAuthoringCopyAuthorizationDetails",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringCopyAuthorizationOptions,
  "CopyAuthorizationDetails",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringCopiedProjectOptions,
  "ConversationAuthoringCopyProjectDetails",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringCopiedProjectOptions,
  "CopyProjectDetails",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportedProject,
  "ConversationAuthoringExportedProject",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedProject,
  "ExportedProject",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportedProjectAssets,
  "ConversationAuthoringExportedProjectAsset",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedProjectAssets,
  "ExportedProjectAsset",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringTrainingJobOptions,
  "ConversationAuthoringTrainingJobDetails",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringTrainingJobOptions,
  "TrainingJobDetails",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringEvaluationOptions,
  "ConversationAuthoringEvaluationDetails",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringEvaluationOptions,
  "EvaluationDetails",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringCopiedProjectJobState,
  "ConversationAuthoringCopyProjectState",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringCopiedProjectJobState,
  "CopyProjectState",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringJobState,
  "ConversationAuthoringState",
  "!autorest"
);
@@clientName(AnalyzeConversationAuthoringJobState, "State", "python");
@@clientName(
  AnalyzeConversationAuthoringJobState.createdDateTime,
  "createdOn",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringJobState.lastUpdatedDateTime,
  "lastUpdatedOn",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringJobState.expirationDateTime,
  "expiresOn",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectDeployments,
  "ConversationAuthoringProjectDeployments",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectDeployments,
  "ProjectDeployments",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringProjectDeployment,
  "ConversationAuthoringProjectDeployment",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectDeployment,
  "ProjectDeployment",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringProjectDeployment.lastTrainedDateTime,
  "lastTrainedOn",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectDeployment.lastDeployedDateTime,
  "lastDeployedOn",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectDeployment.deploymentExpirationDate,
  "deploymentExpiredOn",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringDeploymentResource,
  "ConversationAuthoringDeploymentResource",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringDeploymentResource,
  "DeploymentResource",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringCreateDeploymentOptions,
  "ConversationAuthoringCreateDeploymentDetails",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringCreateDeploymentOptions,
  "CreateDeploymentDetails",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringProjectAzureResourceIds,
  "ConversationAuthoringDeleteDeploymentDetails",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectAzureResourceIds,
  "DeleteDeploymentDetails",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringDeploymentJobState,
  "ConversationAuthoringDeploymentState",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringDeploymentJobState,
  "DeploymentState",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringDeploymentDeleteFromResourcesJobState,
  "ConversationAuthoringDeploymentDeleteFromResourcesState",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringDeploymentDeleteFromResourcesJobState,
  "DeploymentDeleteFromResourcesState",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringSwapDeploymentsJobState,
  "ConversationAuthoringSwapDeploymentsState",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringSwapDeploymentsJobState,
  "SwapDeploymentsState",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringSwapDeploymentsOptions,
  "ConversationAuthoringSwapDeploymentsDetails",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringSwapDeploymentsOptions,
  "SwapDeploymentsDetails",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportProjectJobState,
  "ConversationAuthoringExportProjectState",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportProjectJobState,
  "ExportProjectState",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportProjectJobState.resultUrl,
  "resultUri",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringImportProjectJobState,
  "ConversationAuthoringImportProjectState",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringImportProjectJobState,
  "ImportProjectState",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringProjectTrainedModels,
  "ConversationAuthoringProjectTrainedModels",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectTrainedModels,
  "ProjectTrainedModels",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringProjectTrainedModel,
  "ConversationAuthoringProjectTrainedModel",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectTrainedModel,
  "ProjectTrainedModel",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringProjectTrainedModel.lastTrainedDateTime,
  "lastTrainedOn",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectTrainedModel.modelExpirationDate,
  "modelExpiredOn",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringEvaluationJobState,
  "ConversationAuthoringEvaluationState",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringEvaluationJobState,
  "EvaluationState",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringEvaluationJobResult,
  "ConversationAuthoringEvaluationJobResult",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringEvaluationJobResult,
  "EvaluationJobResult",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringEvaluationJobResult.evaluationOptions,
  "evaluationDetails",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringEvaluationResults,
  "ConversationAuthoringEvalResults",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringEvaluationResults,
  "EvalResults",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringEvaluationSummary,
  "ConversationAuthoringEvalSummary",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringEvaluationSummary,
  "EvalSummary",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringEntitiesEvaluationSummary,
  "EntitiesEvaluationSummary",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringIntentsEvaluationSummary,
  "IntentsEvaluationSummary",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringIntentEvaluationSummary,
  "IntentEvaluationSummary",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringLoadSnapshotJobState,
  "ConversationAuthoringLoadSnapshotState",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringLoadSnapshotJobState,
  "LoadSnapshotState",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringDeploymentResourcesInfoList,
  "ConversationAuthoringAssignedDeploymentResources",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringDeploymentResourcesInfoList,
  "AssignedDeploymentResources",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringProjectResourceInfo,
  "ConversationAuthoringAssignedDeploymentResource",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectResourceInfo,
  "AssignedDeploymentResource",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringProjectResourceInfo.azureResourceId,
  "resourceId",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectResourceAssignments,
  "ConversationAuthoringAssignDeploymentResourcesDetails",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectResourceAssignments,
  "AssignDeploymentResourcesDetails",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringProjectResourceAssignments.projectResources,
  "metadata",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectResourceAssignmentInfo,
  "ConversationAuthoringResourceMetadata",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectResourceAssignmentInfo,
  "ResourceMetadata",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringUnassignDeploymentResourcesOptions,
  "ConversationAuthoringUnassignDeploymentResourcesDetails",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringUnassignDeploymentResourcesOptions,
  "UnassignDeploymentResourcesDetails",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringProjectResourcesJobState,
  "ConversationAuthoringDeploymentResourcesState",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectResourcesJobState,
  "DeploymentResourcesState",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringTrainingJobs,
  "ConversationAuthoringTrainingJobs",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringTrainingJobs,
  "TrainingJobs",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringTrainingJobState,
  "ConversationAuthoringTrainingState",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringTrainingJobState,
  "TrainingState",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringTrainingJobResult,
  "ConversationAuthoringTrainingJobResult",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringTrainingJobResult,
  "TrainingJobResult",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringTrainingJobResult.estimatedEndDateTime,
  "estimatedEndOn",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringSubTrainingJobState,
  "ConversationAuthoringSubTrainingState",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringSubTrainingJobState,
  "SubTrainingState",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringSubTrainingJobState.startDateTime,
  "startedOn",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringSubTrainingJobState.endDateTime,
  "endedOn",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectDeletionJobState,
  "ConversationAuthoringProjectDeletionState",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringProjectDeletionJobState,
  "ProjectDeletionState",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringAssignedResourceDeploymentsMetadata,
  "ConversationAuthoringAssignedResourceDeploymentsMetadata",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringAssignedResourceDeploymentsMetadata,
  "AssignedResourceDeploymentsMetadata",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringAssignedProjectDeploymentsMetadata,
  "ConversationAuthoringAssignedProjectDeploymentsMetadata",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringAssignedProjectDeploymentsMetadata,
  "AssignedProjectDeploymentsMetadata",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringAssignedProjectDeploymentMetadata,
  "ConversationAuthoringAssignedProjectDeploymentMetadata",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringAssignedProjectDeploymentMetadata,
  "AssignedProjectDeploymentMetadata",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringAssignedProjectDeploymentMetadata.lastDeployedDateTime,
  "lastDeployedOn",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringAssignedProjectDeploymentMetadata.deploymentExpirationDate,
  "DeploymentExpiresOn",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringSupportedLanguages,
  "ConversationAuthoringSupportedLanguages",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringSupportedLanguages,
  "SupportedLanguages",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringSupportedLanguage,
  "ConversationAuthoringSupportedLanguage",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringSupportedLanguage,
  "SupportedLanguage",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringPrebuiltEntities,
  "ConversationAuthoringPrebuiltEntities",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringPrebuiltEntities,
  "PrebuiltEntities",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringPrebuiltEntity,
  "ConversationAuthoringPrebuiltEntity",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringPrebuiltEntity,
  "PrebuiltEntity",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringTrainingConfigVersions,
  "ConversationAuthoringTrainingConfigVersions",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringTrainingConfigVersions,
  "TrainingConfigVersions",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringTrainingConfigVersion,
  "ConversationAuthoringTrainingConfigVersion",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringTrainingConfigVersion,
  "TrainingConfigVersion",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringConversationExportedEntity,
  "ConversationExportedEntity",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringConversationExportedEntity,
  "ConversationExportedEntity",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringConversationExportedEntity.compositionSetting,
  "compositionMode",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedEntityList,
  "ConversationAuthoringExportedEntityList",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedEntityList,
  "ExportedEntityList",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportedEntitySublist,
  "ConversationAuthoringExportedEntitySublist",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedEntitySublist,
  "ExportedEntitySublist",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportedEntityListSynonym,
  "ConversationAuthoringExportedEntityListSynonym",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedEntityListSynonym,
  "ExportedEntityListSynonym",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportedPrebuiltEntity,
  "ConversationAuthoringExportedPrebuiltEntity",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedPrebuiltEntity,
  "ExportedPrebuiltEntity",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportedEntityRegex,
  "ExportedEntityRegex",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedEntityRegex,
  "ExportedEntityRegex",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportedEntityRegexExpression,
  "ExportedEntityRegexExpression",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedEntityRegexExpression,
  "ExportedEntityRegexExpression",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringConversationExportedIntent,
  "ConversationExportedIntent",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringConversationExportedIntent,
  "ConversationExportedIntent",
  "python"
);
@@clientName(
  AnalyzeConversationExportedAssociatedEntityLabel,
  "ConversationExportedAssociatedEntityLabel",
  "!autorest"
);
@@clientName(
  AnalyzeConversationExportedAssociatedEntityLabel,
  "ConversationExportedAssociatedEntityLabel",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringConversationExportedProjectAsset,
  "ConversationExportedProjectAsset",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringConversationExportedProjectAsset,
  "ConversationExportedProjectAsset",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringConversationExportedUtterance,
  "ConversationExportedUtterance",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringConversationExportedUtterance,
  "ConversationExportedUtterance",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportedUtteranceEntityLabel,
  "ExportedUtteranceEntityLabel",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedUtteranceEntityLabel,
  "ExportedUtteranceEntityLabel",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringConversationSummarizationExportedProjectAsset,
  "ConversationSummarizationExportedProjectAsset",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringConversationSummarizationExportedProjectAsset,
  "ConversationSummarizationExportedProjectAsset",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringCustomConversationSummarizationConversation,
  "CustomConversationSummarizationConversation",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringCustomConversationSummarizationConversation,
  "CustomConversationSummarizationConversation",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportedConversationOrchestration,
  "ExportedConversationOrchestration",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedConversationOrchestration,
  "ExportedConversationOrchestration",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportedConversationOrchestrationOptions,
  "ExportedConversationOrchestrationDetails",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedConversationOrchestrationOptions,
  "ExportedConversationOrchestrationDetails",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportedOrchestrationOptions,
  "ExportedOrchestrationDetails",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedOrchestrationOptions,
  "ExportedOrchestrationDetails",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportedLuisOrchestration,
  "ExportedLuisOrchestration",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedLuisOrchestration,
  "ExportedLuisOrchestration",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportedLuisOrchestrationOptions,
  "ExportedLuisOrchestrationDetails",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedLuisOrchestrationOptions,
  "ExportedLuisOrchestrationDetails",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportedQuestionAnsweringOrchestration,
  "ExportedQuestionAnsweringOrchestration",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedQuestionAnsweringOrchestration,
  "ExportedQuestionAnsweringOrchestration",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportedQuestionAnsweringOrchestrationOptions,
  "ExportedQuestionAnsweringOrchestrationDetails",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedQuestionAnsweringOrchestrationOptions,
  "ExportedQuestionAnsweringOrchestrationDetails",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringOrchestrationExportedIntent,
  "OrchestrationExportedIntent",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringOrchestrationExportedIntent,
  "OrchestrationExportedIntent",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringOrchestrationExportedProjectAsset,
  "OrchestrationExportedProjectAsset",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringOrchestrationExportedProjectAsset,
  "OrchestrationExportedProjectAsset",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringOrchestrationExportedUtterance,
  "OrchestrationExportedUtterance",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringOrchestrationExportedUtterance,
  "OrchestrationExportedUtterance",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportedTrainedModel,
  "ConversationAuthoringExportedTrainedModel",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedTrainedModel,
  "ExportedTrainedModel",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportedTrainedModel.lastTrainedDateTime,
  "lastTrainedOn",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedTrainedModel.lastExportedModelDateTime,
  "lastExportedModelOn",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedTrainedModel.modelExpirationDate,
  "modelExpiredOn",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedModelJobState,
  "ConversationAuthoringExportedModelState",
  "!autorest"
);
@@clientName(
  AnalyzeConversationAuthoringExportedModelJobState,
  "ExportedModelState",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringModelFile,
  "ConversationAuthoringModelFile",
  "!autorest"
);
@@clientName(AnalyzeConversationAuthoringModelFile, "ModelFile", "python");
@@clientName(
  ExportedModelOptions,
  "ConversationAuthoringExportedModelDetails",
  "!autorest"
);
@@clientName(ExportedModelOptions, "ExportedModelDetails", "python");
@@clientName(
  AnalyzeConversationAuthoringUtteranceEvaluationResult,
  "UtteranceEvaluationResult",
  "python"
);

@@clientName(
  AnalyzeConversationAuthoringConfusionMatrixCell,
  "ConfusionMatrixCell",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringConfusionMatrixRow,
  "ConfusionMatrixRow",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringDataGenerationConnectionInfo,
  "DataGenerationConnectionInfo",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringDataGenerationConnectionKind,
  "DataGenerationConnectionKind",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringDataGenerationSettings,
  "DataGenerationSettings",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringEntityEvaluationSummary,
  "EntityEvaluationSummary",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringUtteranceEntitiesEvaluationResult,
  "UtteranceEntitiesEvaluationResult",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringUtteranceEntityEvaluationResult,
  "UtteranceEntityEvaluationResult",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringUtteranceIntentsEvaluationResult,
  "UtteranceIntentsEvaluationResult",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportedEntityListSynonym.values,
  "synonyms",
  "python"
);
@@clientName(
  AnalyzeConversationAuthoringExportedEntityListSynonym.values,
  "synonyms",
  "python"
);
@@clientName(ConversationAuthoringProject.`import`, "importProject", "python");

#suppress "@azure-tools/typespec-azure-core/documentation-required"
model ConversationAuthoringProjectClientOptions {
  projectName: string;
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
namespace ConversationAuthoringClient {
  op listProjects is Language.Conversations.Authoring.conversationAuthoringListProjects;

  op listSupportedLanguages is Language.Conversations.Authoring.conversationAuthoringListSupportedLanguages;

  op listAssignedResourceDeployments is Language.Conversations.Authoring.conversationAuthoringListAssignedResourceDeployments;

  op listSupportedPrebuiltEntities is Language.Conversations.Authoring.conversationAuthoringListSupportedPrebuiltEntities;

  op listTrainingConfigVersions is Language.Conversations.Authoring.conversationAuthoringListTrainingConfigVersions;

  op createProject is Language.Conversations.Authoring.ConversationAuthoringProject.createProject;

  op getProject is Language.Conversations.Authoring.ConversationAuthoringProject.getProject;

  @access(Access.internal, "python")
  op deleteProject is Language.Conversations.Authoring.ConversationAuthoringProject.deleteProject;

  @access(Access.internal, "python")
  op getExportStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getExportStatus;

  @access(Access.internal, "python")
  op getImportStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getImportStatus;
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
  @operationGroup("python")
  @clientName("Deployment", "python")
  interface DeploymentOperations {
    getDeployment is Language.Conversations.Authoring.ConversationAuthoringDeployment.getDeployment;

    deployProject is Language.Conversations.Authoring.ConversationAuthoringDeployment.deployProject;

    deleteDeployment is Language.Conversations.Authoring.ConversationAuthoringDeployment.deleteDeployment;

    deleteDeploymentFromResources is Language.Conversations.Authoring.ConversationAuthoringDeployment.deleteDeploymentFromResources;

    @access(Access.internal, "python")
    getDeploymentDeleteFromResourcesStatus is Language.Conversations.Authoring.ConversationAuthoringDeployment.getDeploymentDeleteFromResourcesStatus;

    @access(Access.internal, "python")
    getDeploymentStatus is Language.Conversations.Authoring.ConversationAuthoringDeployment.getDeploymentStatus;
  }

  @operationGroup("python")
  @clientName("Project", "python")
  interface ProjectOperations {
    listTrainedModels is Language.Conversations.Authoring.conversationAuthoringListTrainedModels;

    listTrainingJobs is Language.Conversations.Authoring.conversationAuthoringListTrainingJobs;

    listDeploymentResources is Language.Conversations.Authoring.conversationAuthoringListProjectResources;

    listDeployments is Language.Conversations.Authoring.conversationAuthoringListDeployments;

    listExportedModels is Language.Conversations.Authoring.conversationAuthoringListExportedModels;

    assignDeploymentResources is Language.Conversations.Authoring.ConversationAuthoringProject.assignProjectResources;

    unassignDeploymentResources is Language.Conversations.Authoring.ConversationAuthoringProject.unassignProjectResources;

    @access(Access.internal, "python")
    getAssignDeploymentResourcesStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getAssignProjectResourcesStatus;

    @access(Access.internal, "python")
    getUnassignDeploymentResourcesStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getUnassignProjectResourcesStatus;

    swapDeployments is Language.Conversations.Authoring.ConversationAuthoringProject.swapDeployments;

    @access(Access.internal, "python")
    getSwapDeploymentsStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getSwapDeploymentsStatus;

    @access(Access.internal, "python")
    getProject is Language.Conversations.Authoring.ConversationAuthoringProject.getProject;

    @access(Access.internal, "python")
    getProjectDeletionStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getProjectDeletionStatus;

    @access(Access.internal, "python")
    `import` is Language.Conversations.Authoring.ConversationAuthoringProject.`import`;

    export is Language.Conversations.Authoring.ConversationAuthoringProject.export;

    @access(Access.internal, "python")
    getExportStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getExportStatus;

    @access(Access.internal, "python")
    copyProjectAuthorization is Language.Conversations.Authoring.ConversationAuthoringProject.copyProjectAuthorization;

    copyProject is Language.Conversations.Authoring.ConversationAuthoringProject.copyProject;

    @access(Access.internal, "python")
    getCopyProjectStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getCopyProjectStatus;

    @access(Access.internal, "python")
    train is Language.Conversations.Authoring.ConversationAuthoringProject.train;

    @access(Access.internal, "python")
    getTrainingStatus is Language.Conversations.Authoring.ConversationAuthoringProject.getTrainingStatus;

    cancelTrainingJob is Language.Conversations.Authoring.ConversationAuthoringProject.cancelTrainingJob;
  }

  @operationGroup("python")
  @clientName("ExportedModel", "python")
  interface ExportedModelOperations {
    getExportedModel is Language.Conversations.Authoring.ConversationAuthoringExportedModel.getExportedModel;

    deleteExportedModel is Language.Conversations.Authoring.ConversationAuthoringExportedModel.deleteExportedModel;

    createOrUpdateExportedModel is Language.Conversations.Authoring.ConversationAuthoringExportedModel.createOrUpdateExportedModel;

    @access(Access.internal, "python")
    getExportedModelJobStatus is Language.Conversations.Authoring.ConversationAuthoringExportedModel.getExportedModelJobStatus;
  }

  @operationGroup("python")
  @clientName("TrainedModel", "python")
  interface TrainedModelOperations {
    getTrainedModel is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.getTrainedModel;

    deleteTrainedModel is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.deleteTrainedModel;

    @access(Access.internal, "python")
    evaluateModel is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.evaluateModel;

    loadSnapshot is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.loadSnapshot;

    @access(Access.internal, "python")
    getEvaluationStatus is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.getEvaluationStatus;

    getModelEvaluationResults is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.getModelEvaluationResults;

    getModelEvaluationSummary is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.getModelEvaluationSummary;

    @access(Access.internal, "python")
    getLoadSnapshotStatus is Language.Conversations.Authoring.ConversationAuthoringTrainedModel.getLoadSnapshotStatus;
  }
}

@@clientInitialization(
  ConversationAuthoringProjectClient,
  {
    parameters: ConversationAuthoringProjectClientOptions,
  },
  "python"
);
