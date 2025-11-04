import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Azure.ResourceManager;
using Microsoft.Edge;

@@clientName(Microsoft.Edge, "WorkloadOrchestrationMgmtClient", "python");
@@clientName(Microsoft.Edge,
  "WorkloadOrchestrationManagementClient",
  "javascript"
);

@@clientName(ConfigTemplate, "EdgeConfigTemplate", "csharp");
@@clientName(ConfigTemplateProperties,
  "EdgeConfigTemplateProperties",
  "csharp"
);
@@clientName(ConfigTemplateVersion, "EdgeConfigTemplateVersion", "csharp");
@@clientName(ConfigTemplateVersionProperties,
  "EdgeConfigTemplateVersionProperties",
  "csharp"
);
@@clientName(Context, "EdgeContext", "csharp");
@@clientName(ContextProperties, "EdgeContextProperties", "csharp");
@@clientName(Diagnostic, "EdgeDiagnostic", "csharp");
@@clientName(DiagnosticProperties, "EdgeDiagnosticProperties", "csharp");
@@clientName(DiagnosticUpdateProperties,
  "EdgeDiagnosticPatchProperties",
  "csharp"
);
@@clientName(DynamicSchema, "EdgeDynamicSchema", "csharp");
@@clientName(DynamicSchemaProperties, "EdgeDynamicSchemaProperties", "csharp");
@@clientName(DynamicSchemaVersion, "EdgeDynamicSchemaVersion", "csharp");
@@clientName(SchemaVersionProperties, "EdgeSchemaVersionProperties", "csharp");
@@clientName(Execution, "EdgeExecution", "csharp");
@@clientName(ExecutionProperties, "EdgeExecutionProperties", "csharp");
@@clientName(Instance, "EdgeDeploymentInstance", "csharp");
@@clientName(InstanceProperties, "EdgeDeploymentInstanceProperties", "csharp");
@@clientName(InstanceHistory, "EdgeDeploymentInstanceHistory", "csharp");
@@clientName(InstanceHistoryProperties,
  "EdgeDeploymentInstanceHistoryProperties",
  "csharp"
);
@@clientName(Job, "EdgeJob", "csharp");
@@clientName(JobProperties, "EdgeJobProperties", "csharp");
@@clientName(Schema, "EdgeSchema", "csharp");
@@clientName(SchemaProperties, "EdgeSchemaProperties", "csharp");
@@clientName(SchemaUpdateProperties, "EdgeSchemaPatchProperties", "csharp");
@@clientName(SchemaReference, "EdgeSchemaReference", "csharp");
@@clientName(SchemaReferenceProperties,
  "EdgeSchemaReferenceProperties",
  "csharp"
);
@@clientName(SchemaVersion, "EdgeSchemaVersion", "csharp");
@@clientName(SiteReference, "EdgeSiteReference", "csharp");
@@clientName(SiteReferenceProperties, "EdgeSiteReferenceProperties", "csharp");
@@clientName(Solution, "EdgeSolution", "csharp");
@@clientName(SolutionProperties, "EdgeSolutionProperties", "csharp");
@@clientName(SolutionTemplate, "EdgeSolutionTemplate", "csharp");
@@clientName(SolutionTemplateProperties,
  "EdgeSolutionTemplateProperties",
  "csharp"
);
@@clientName(SolutionTemplateProperties.enableExternalValidation,
  "IsExternalValidationEnabled",
  "csharp"
);
@@clientName(SolutionTemplateVersion, "EdgeSolutionTemplateVersion", "csharp");
@@clientName(SolutionTemplateVersionProperties,
  "EdgeSolutionTemplateVersionProperties",
  "csharp"
);
@@clientName(SolutionVersion, "EdgeSolutionVersion", "csharp");
@@clientName(SolutionVersionProperties,
  "EdgeSolutionVersionProperties",
  "csharp"
);
@@clientName(Target, "EdgeTarget", "csharp");
@@clientName(TargetProperties, "EdgeTargetProperties", "csharp");
@@clientName(Workflow, "EdgeWorkflow", "csharp");
@@clientName(WorkflowProperties, "EdgeWorkflowProperties", "csharp");
@@clientName(WorkflowVersion, "EdgeWorkflowVersion", "csharp");
@@clientName(WorkflowVersionProperties,
  "EdgeWorkflowVersionProperties",
  "csharp"
);
@@clientName(ActiveState, "InstanceActiveState", "csharp");
@@clientName(Capability, "ContextCapability", "csharp");
@@clientName(ComponentStatus, "TargetComponentStatus", "csharp");
@@clientName(ConfigurationModel, "EdgeSchemaConfigurationModelType", "csharp");
@@clientName(ConfigurationType, "EdgeSchemaConfigurationType", "csharp");
@@clientName(DeploymentStatus, "EdgeDeploymentStatus", "csharp");
@@clientName(ErrorAction, "TaskErrorAction", "csharp");
@@clientName(ErrorActionMode, "TaskErrorActionModeType", "csharp");
@@clientName(ExecutionStatus, "EdgeExecutionStatus", "csharp");
@@clientName(Hierarchy, "ContextHierarchy", "csharp");
@@clientName(JobParameterBase, "EdgeJobContent", "csharp");
@@clientName(JobStatus, "EdgeJobStatus", "csharp");
@@clientName(JobStep, "EdgeJobStep", "csharp");
@@clientName(JobStepStatisticsBase, "EdgeJobStepStatistics", "csharp");
@@clientName(JobType, "EdgeJobType", "csharp");
@@clientName(OrchestratorType, "SolutionVersionOrchestratorType", "csharp");
@@clientName(ProvisioningState,
  "WorkloadOrchestrationProvisioningState",
  "csharp"
);
@@clientName(ReconciliationPolicyProperties,
  "InstanceReconciliationPolicy",
  "csharp"
);
@@clientName(ReconciliationState, "InstanceReconciliationState", "csharp");
@@clientName(ResourceState, "EdgeResourceState", "csharp");
@@clientName(SolutionDependency, "EdgeSolutionDependency", "csharp");
@@clientName(SchemaVersionWithUpdateType,
  "EdgeSchemaVersionWithUpdateType",
  "csharp"
);
@@clientName(SolutionTemplateVersionWithUpdateType,
  "EdgeSolutionTemplateVersionWithUpdateType",
  "csharp"
);
@@clientName(SolutionUpdateProperties, "EdgeSolutionPatchProperties", "csharp");
@@clientName(StageSpec, "EdgeWorkflowStageSpec", "csharp");
@@clientName(TaskSpec, "EdgeWorkflowTaskSpec", "csharp");
@@clientName(StageStatus, "EdgeExecutionStageStatus", "csharp");
@@clientName(State, "SolutionInstanceState", "csharp");
@@clientName(TargetSnapshot, "EdgeTargetSnapshot", "csharp");
@@clientName(TargetStatus, "EdgeTargetStatus", "csharp");
@@clientName(UpdateType, "EdgeUpdateType", "csharp");
@@clientName(ValidationStatus, "SolutionInstanceValidationStatus", "csharp");

@@clientName(BulkPublishSolutionParameter,
  "BulkPublishSolutionContent",
  "csharp"
);
@@clientName(InstallSolutionParameter, "InstallSolutionContent", "csharp");
@@clientName(BulkDeploySolutionParameter,
  "BulkDeploySolutionContent",
  "csharp"
);
@@clientName(RemoveRevisionParameter, "RemoveRevisionContent", "csharp");
@@clientName(RemoveVersionResponse, "RemoveVersionResult", "csharp");
@@clientName(SolutionDependencyParameter,
  "EdgeSolutionDependencyContent",
  "csharp"
);
@@clientName(SolutionTemplateParameter,
  "EdgeSolutionTemplateContent",
  "csharp"
);
@@clientName(TaskOption, "EdgeWorkflowTaskConfig", "csharp");
@@clientName(UninstallSolutionParameter, "UninstallSolutionContent", "csharp");
@@clientName(UpdateExternalValidationStatusParameter,
  "UpdateExternalValidationStatusContent",
  "csharp"
);
@@clientName(SolutionVersionParameter, "EdgeSolutionVersionContent", "csharp");
@@clientName(VersionParameter, "EdgeVersionContent", "csharp");
@@clientName(DeployJobParameter, "DeployJobContent", "csharp");

@@alternateType(EntityTagProperty.eTag, eTag, "csharp");
@@alternateType(InstallSolutionParameter.solutionVersionId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(RemoveRevisionParameter.solutionTemplateId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(SolutionDependency.solutionVersionId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(SolutionDependency.solutionTemplateVersionId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(SolutionDependency.targetId, armResourceIdentifier, "csharp");
@@alternateType(SolutionDependencyParameter.solutionVersionId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(SolutionDependencyParameter.solutionTemplateId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(SolutionDependencyParameter.targetId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(SolutionTemplateParameter.solutionTemplateVersionId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(SolutionVersionParameter.solutionVersionId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(UpdateExternalValidationStatusParameter.solutionVersionId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(UninstallSolutionParameter.solutionTemplateId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(RemoveRevisionParameter.solutionTemplateId,
  armResourceIdentifier,
  "csharp"
);
