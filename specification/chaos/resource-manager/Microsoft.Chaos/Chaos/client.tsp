import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Chaos;

// csharp
@@clientName(Workspace, "ChaosWorkspace", "csharp");
@@clientName(Scenario, "ChaosScenario", "csharp");
@@clientName(ScenarioRun, "ChaosScenarioRun", "csharp");
@@clientName(ScenarioConfiguration, "ChaosScenarioConfiguration", "csharp");
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
@@clientName(CapabilityTypePropertiesRuntimeProperties,
  "ChaosCapabilityMetadataRuntimeProperties",
  "csharp"
);
@@clientName(TargetReference.type, "ReferenceType", "csharp");
@@clientName(ExperimentExecutions.getExecutionDetails,
  "ExecutionDetails",
  "csharp"
);
@@clientName(Microsoft.Chaos.Experiments.listAll, "getExperiments", "csharp");
@@clientName(Microsoft.Chaos.PrivateAccesses.listAll,
  "getPrivateAccesses",
  "csharp"
);
@@clientName(Microsoft.Chaos.Workspaces.listAll, "getWorkspaces", "csharp");
@@clientName(Microsoft.Chaos.WorkspaceOperationResults.get,
  "getWorkspaceOperationResult",
  "csharp"
);
@@clientName(FixResourcePermissionsRequest,
  "ChaosFixResourcePermissionsRequestContent",
  "csharp"
);
@@clientName(ScenarioParameter, "ChaosScenarioParameterInfo", "csharp");
@@clientName(Action, "ChaosAction", "csharp");
@@clientName(ActionVersion, "ChaosActionVersion", "csharp");
@@clientName(ActionKind, "ChaosActionKind", "csharp");
@@clientName(ActionSupportedTargetType,
  "ChaosActionSupportedTargetType",
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "update base model for SDK backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ExperimentExecutionDetails,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);

// typescript
@@clientName(Microsoft.Chaos, "ChaosManagementClient", "javascript");

// python
@@clientName(Microsoft.Chaos, "ChaosManagementClient", "python");

// java
@@clientName(Microsoft.Chaos, "ChaosManagementClient", "java");
@@clientName(Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "ResourceIdentity",
  "java"
);
@@clientName(Azure.ResourceManager.CommonTypes.OperationStatusResult,
  "OperationStatus",
  "java"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Experiment.properties,
  "!javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ExperimentExecution.properties,
  "!javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(TargetType.properties,
  "!javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Capability.properties,
  "!javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CapabilityType.properties,
  "!javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ExperimentExecutionDetails.properties,
  "!javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Action.properties,
  "!javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ActionVersion.properties,
  "!javascript"
);

@@clientName(Microsoft.Chaos.Operations.list, "listAll", "javascript,python");
