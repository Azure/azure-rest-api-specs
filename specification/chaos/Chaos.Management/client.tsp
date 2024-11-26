import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Chaos;

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
