import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(
  PolicyAuthoringApi.PolicyLintIssue.documentationUrl,
  "DocumentationUri",
  "csharp"
);
