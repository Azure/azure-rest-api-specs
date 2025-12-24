import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-client-generator-core";
import "./aoai.tsp";
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace ContentSafety;

@doc("Type of AnalyzeTaskAdherence result.")
model AnalyzeTaskAdherenceResult {
  @doc("Indicates whether a risk is detected in the thread.")
  taskRiskDetected: boolean;

  @doc("Reason for the risk detection.")
  details?: string;
}

@doc("The request to analyze a thread for task adherence.")
model AnalyzeTaskAdherenceRequest {
    @doc("All tool definitions relevant")
    tools?: Tool[];

    @doc("The thread to analyze for task adherence.")
    messages: Message[];
}