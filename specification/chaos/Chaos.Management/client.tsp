import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Chaos;

@@clientName(Experiment, "ChaosExperiment");
@@clientName(ExperimentExecution, "ChaosExperimentExecution");
@@clientName(Target, "ChaosTarget");
@@clientName(TargetType, "ChaosTargetType");
@@clientName(Capability, "ChaosCapability");
@@clientName(CapabilityType, "ChaosCapabilityType");
@@clientName(TargetReference, "ChaosTargetReference");
@@clientName(TargetReferenceType, "ChaosTargetReferenceType");
@@clientName(ProvisioningState, "ChaosProvisioningState");
@@clientName(KeyValuePair, "ChaosKeyValuePair");
@@clientName(StepStatus, "ChaosExperimentRunStepStatus");
@@clientName(BranchStatus, "ChaosExperimentRunBranchStatus");
@@clientName(ActionStatus, "ChaosExperimentRunActionStatus");
@@clientName(ContinuousAction, "ChaosContinuousAction");
@@clientName(DiscreteAction, "ChaosDiscreteAction");
@@clientName(DelayAction, "ChaosDelayAction");
@@clientName(TargetReference.type, "ReferenceType");
@@clientName(ExperimentExecutions.getExecutionDetails, "ExecutionDetails");
@@clientName(Experiments.start, "StartExperiment");
@@clientName(Experiments.cancel, "CancelExperiment");
@@clientName(Targets.createOrUpdate::parameters.resource, "target");

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
