import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Chaos;

// csharp
@@clientName(Workspace, "ChaosWorkspace", "csharp");
@@clientName(Scenario, "ChaosScenario", "csharp");
@@clientName(ScenarioRun, "ChaosScenarioRun", "csharp");
@@clientName(ScenarioConfiguration, "ChaosScenarioConfiguration", "csharp");
@@clientName(DiscoveredResource, "ChaosDiscovered", "csharp");
@@clientName(PrivateAccess, "ChaosPrivateAccess", "csharp");
@@clientName(PrivateAccessPatch, "ChaosPrivateAccessPatch", "csharp");
@@clientName(PrivateAccessProperties, "ChaosPrivateAccessProperties", "csharp");
@@clientName(ExperimentExecution, "ChaosExperimentExecution", "csharp");
@@clientName(Experiment, "ChaosExperiment", "csharp");
@@clientName(ExperimentExecution, "ChaosExperimentExecution", "csharp");
@@clientName(Target, "ChaosTarget", "csharp");
@@clientName(TargetType, "ChaosTargetMetadata", "csharp");
@@clientName(Capability, "ChaosCapability", "csharp");
@@clientName(CapabilityType, "ChaosCapabilityMetadata", "csharp");
@@clientName(TargetReference, "ChaosTargetReference", "csharp");
@@clientName(TargetReferenceType, "ChaosTargetReferenceType", "csharp");
@@clientName(ProvisioningState, "ChaosProvisioningState", "csharp");
@@clientName(KeyValuePair, "ChaosKeyValuePair", "csharp");
@@clientName(StepStatus, "ChaosExperimentRunStepStatus", "csharp");
@@clientName(BranchStatus, "ChaosExperimentRunBranchStatus", "csharp");
@@clientName(ActionStatus, "ChaosExperimentRunActionStatus", "csharp");
@@clientName(ContinuousAction, "ChaosContinuousAction", "csharp");
@@clientName(DiscreteAction, "ChaosDiscreteAction", "csharp");
@@clientName(DelayAction, "ChaosDelayAction", "csharp");
@@clientName(
  CapabilityTypePropertiesRuntimeProperties,
  "ChaosCapabilityMetadataRuntimeProperties",
  "csharp"
);
@@clientName(TargetReference.type, "ReferenceType", "csharp");
@@clientName(
  ExperimentExecutions.getExecutionDetails,
  "ExecutionDetails",
  "csharp"
);
@@clientName(
  Microsoft.Chaos.PrivateAccesses.listAll,
  "getPrivateAccesses",
  "csharp"
);
@@clientName(Microsoft.Chaos.Workspaces.listAll, "getWorkspaces", "csharp");
@@clientName(
  FixResourcePermissionsRequest,
  "ChaosFixResourcePermissionsRequestContent",
  "csharp"
);
@@clientName(ScenarioParameter, "ChaosScenarioParameterInfo", "csharp");
@@clientName(Action, "ChaosAction", "csharp");
@@clientName(ActionVersion, "ChaosActionVersion", "csharp");
@@clientName(ActionKind, "ChaosActionKind", "csharp");
@@clientName(
  ConfigurationExclusions,
  "ChaosScenarioConfigurationExclusions",
  "csharp"
);
@@clientName(
  ConfigurationFilters,
  "ChaosScenarioConfigurationFilters",
  "csharp"
);
@@clientName(OperationError, "ChaosOperationError", "csharp");
@@clientName(ScenarioParameter.required, "IsRequired", "csharp");
@@clientName(ParameterType, "ChaosScenarioParameterType", "csharp");
@@clientName(FixResourcePermissionsRequest.whatIf, "IsWhatIf", "csharp");
@@clientName(PermissionsFix, "ChaosPermissionsFixData", "csharp");
@@clientName(PermissionsFixProperties.whatIfMode, "IsWhatIfMode", "csharp");
@@clientName(Recommendation, "ChaosScenarioRecommendation", "csharp");
@@clientName(Validation, "ChaosScenarioValidationData", "csharp");
@@clientName(WorkspaceEvaluation, "ChaosWorkspaceEvaluationData", "csharp");
@@clientName(
  PrivateEndpointConnection,
  "ChaosPrivateEndpointConnection",
  "csharp"
);
@@clientName(
  PrivateEndpointConnectionProperties,
  "ChaosPrivateEndpointConnectionProperties",
  "csharp"
);
@@clientName(ActionDependency, "ChaosScenarioActionDependency", "csharp");
@@clientName(
  ActionDependencyType,
  "ChaosScenarioActionDependencyType",
  "csharp"
);
@@clientName(ActionLifecycle, "ChaosActionLifecycle", "csharp");
@@clientName(ActionParametersSchema, "ChaosActionParametersSchema", "csharp");
@@clientName(EntraIdentity, "ChaosEntraIdentity", "csharp");
@@clientName(PermissionError, "ChaosPermissionError", "csharp");
@@clientName(
  PermissionsFixProperties,
  "ChaosPermissionsFixProperties",
  "csharp"
);
@@clientName(PermissionsFixState, "ChaosPermissionsFixState", "csharp");
@@clientName(PermissionsFixSummary, "ChaosPermissionsFixSummary", "csharp");
@@clientName(
  CustomerDataStorageProperties,
  "ChaosCustomerDataStorageProperties",
  "csharp"
);
@@clientName(
  DiscoveredResourceProperties,
  "ChaosDiscoveredResourceProperties",
  "csharp"
);
@@clientName(
  PhysicalToLogicalZoneMapping,
  "ChaosPhysicalToLogicalZoneMapping",
  "csharp"
);
@@clientName(
  PublicNetworkAccessOption,
  "ChaosPrivateAccessPublicNetworkAccessOption",
  "csharp"
);
@@clientName(RecommendationStatus, "ChaosRecommendationStatus", "csharp");
@@clientName(ResourceStateError, "ChaosResourceStateError", "csharp");
@@clientName(
  ValidationProperties,
  "ChaosScenarioValidationProperties",
  "csharp"
);
@@clientName(ZoneResolutionInfo, "ChaosZoneResolutionInfo", "csharp");
@@clientName(ZoneResolutionMapping, "ChaosZoneResolutionMapping", "csharp");
@@clientName(ZoneResolutionMode, "ChaosZoneResolutionMode", "csharp");
@@clientName(RoleAssignmentError, "ChaosRoleAssignmentError", "csharp");
@@clientName(RoleAssignmentResult, "ChaosRoleAssignmentResult", "csharp");
@@clientName(RoleAssignmentStatus, "ChaosRoleAssignmentStatus", "csharp");
@@clientName(RunAfter, "ChaosRunAfter", "csharp");
@@clientName(RunAfterBehavior, "ChaosRunAfterBehavior", "csharp");
@@clientName(ScenarioAction, "ChaosScenarioAction", "csharp");
@@clientName(
  ScenarioConfigurationProperties,
  "ChaosScenarioConfigurationProperties",
  "csharp"
);
@@clientName(ScenarioErrors, "ChaosScenarioErrors", "csharp");
@@clientName(
  ScenarioEvaluationResultItem,
  "ChaosScenarioEvaluationResultItem",
  "csharp"
);
@@clientName(ScenarioProperties, "ChaosScenarioProperties", "csharp");
@@clientName(ScenarioRunProperties, "ChaosScenarioRunProperties", "csharp");
@@clientName(ScenarioRunResource, "ChaosScenarioRunResource", "csharp");
@@clientName(ScenarioRunState, "ChaosScenarioRunState", "csharp");
@@clientName(
  ScenarioRunSummaryAction,
  "ChaosScenarioRunSummaryAction",
  "csharp"
);
@@clientName(ScenarioSummaryState, "ChaosScenarioSummaryState", "csharp");
@@clientName(ScenarioValidationState, "ChaosScenarioValidationState", "csharp");
@@clientName(
  WorkspaceEvaluationProperties,
  "ChaosWorkspaceEvaluationProperties",
  "csharp"
);
@@clientName(
  WorkspaceEvaluationStatus,
  "ChaosWorkspaceEvaluationStatus",
  "csharp"
);
@@clientName(WorkspaceProperties, "ChaosWorkspaceProperties", "csharp");
@@clientName(
  ActionSupportedTargetType,
  "ChaosActionSupportedTargetType",
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "update base model for SDK backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  ExperimentExecutionDetails,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);

// typescript
@@clientName(Microsoft.Chaos, "ChaosManagementClient", "javascript");

// python
@@clientName(Microsoft.Chaos, "ChaosManagementClient", "python");

// java
@@clientName(Microsoft.Chaos, "ChaosManagementClient", "java");
@@clientName(
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "ResourceIdentity",
  "java"
);
@@clientName(
  Azure.ResourceManager.CommonTypes.OperationStatusResult,
  "OperationStatus",
  "java"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Experiment.properties,
  "!javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  ExperimentExecution.properties,
  "!javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  TargetType.properties,
  "!javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Capability.properties,
  "!javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  CapabilityType.properties,
  "!javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  ExperimentExecutionDetails.properties,
  "!javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Action.properties,
  "!javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  ActionVersion.properties,
  "!javascript"
);

@@clientName(Microsoft.Chaos.Operations.list, "listAll", "javascript,python");
