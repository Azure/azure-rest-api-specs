import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AzureResilienceManagement;

@@usage(ChildJobProperties, Usage.input | Usage.output, "go");
@@usage(JobProperties, Usage.input | Usage.output, "go");
@@usage(JobResourceProperties, Usage.input | Usage.output, "go");
