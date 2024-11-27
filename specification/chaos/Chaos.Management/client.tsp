import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Chaos;

// csharp
@@clientName(ExperimentExecution, "ChaosExperimentExecution", "csharp");
@@clientName(Experiment, "ChaosExperiment", "csharp");
@@clientName(ExperimentExecution, "ChaosExperimentExecution", "csharp");
@@clientName(Target, "ChaosTarget", "csharp");
@@clientName(Capability, "ChaosCapability", "csharp");
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
@@clientName(TargetReference.type, "ReferenceType", "csharp");
@@clientName(ExperimentExecutions.getExecutionDetails,
  "ExecutionDetails",
  "csharp"
);
@@clientName(Experiments.start, "StartExperiment", "csharp");
@@clientName(Experiments.cancel, "CancelExperiment", "csharp");

// typescript
@@clientName(Microsoft.Chaos, "ChaosManagementClient", "javascript");
@@clientName(Capabilities, "Capabilities", "javascript");

// python
@@clientName(Microsoft.Chaos, "ChaosManagementClient", "python");

// java
@@clientName(Microsoft.Chaos, "ChaosManagementClient", "java");

#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Experiment.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(ExperimentExecution.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(TargetType.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Capability.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(CapabilityType.properties);
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(ExperimentExecutionDetails.properties);
