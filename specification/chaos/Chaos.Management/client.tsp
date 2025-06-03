import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Microsoft.Chaos;

@client(
  {
    name: "ChaosManagementClient",
    service: Microsoft.Chaos,
  },
  "java,go,javascript"
)
@useDependency(Microsoft.Chaos.Versions.v2025_01_01)
namespace Customization;

@operationGroup("java,go,javascript")
@armResourceOperations
interface Experiments {
  get is Microsoft.Chaos.Experiments.get;
  createOrUpdate is Microsoft.Chaos.Experiments.createOrUpdate;
  update is Microsoft.Chaos.Experiments.update;
  delete is Microsoft.Chaos.Experiments.delete;
  list is Microsoft.Chaos.Experiments.list;
  listAll is Microsoft.Chaos.Experiments.listAll;
  cancel is Microsoft.Chaos.Experiments.cancel;
  start is Microsoft.Chaos.Experiments.start;

  getExecution is Microsoft.Chaos.ExperimentExecutions.getExecution;
  listAllExecutions is Microsoft.Chaos.ExperimentExecutions.listAllExecutions;
  executionDetails is Microsoft.Chaos.ExperimentExecutions.getExecutionDetails;
}

@operationGroup("java,go,javascript")
@armResourceOperations
interface Capabilities extends Microsoft.Chaos.Capabilities {}

@operationGroup("java,go,javascript")
@armResourceOperations
interface CapabilityTypes extends Microsoft.Chaos.CapabilityTypes {}

@operationGroup("java,go,javascript")
@armResourceOperations
interface Operations extends Microsoft.Chaos.Operations {}

@operationGroup("java,go,javascript")
@armResourceOperations
interface OperationStatuses extends Microsoft.Chaos.OperationStatuses {}

@operationGroup("java,go,javascript")
@armResourceOperations
interface Targets extends Microsoft.Chaos.Targets {}

@operationGroup("java,go,javascript")
@armResourceOperations
interface TargetTypes extends Microsoft.Chaos.TargetTypes {}

// csharp
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
@@scope(Microsoft.Chaos.OperationStatuses.get, "!csharp");

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

@@clientName(Microsoft.Chaos.Operations.list, "listAll", "javascript");
