import "./main.tsp";
import "@typespec/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Chaos;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ExperimentExecutionDetails.properties);
