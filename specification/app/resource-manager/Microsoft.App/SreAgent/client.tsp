import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.App;

// Rename models whose names end with reserved suffixes that the .NET analyzer
// (AZC0030) disallows ('Collection', 'Parameter'). These renames only affect
// the generated C# type names.
@@clientName(AgentConnectorCollection, "AgentConnectorList", "csharp");
@@clientName(
  AgentSpaceConnectorCollection,
  "AgentSpaceConnectorList",
  "csharp"
);
@@clientName(GenevaActionParameter, "GenevaActionParameterInfo", "csharp");
