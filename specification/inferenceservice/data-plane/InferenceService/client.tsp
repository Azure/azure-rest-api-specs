import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Data.AI;

@@clientName(Azure.Data.AI, "InferenceClient", "csharp");
@@clientName(Azure.Data.AI, "InferenceClient", "python");
@@clientName(MetaResult, "SemanticRerankingMetaResult");
@@clientName(DocumentType, "SemanticRerankingDocumentType");

@@clientLocation(InferenceOperationGroup.semanticRerank, Azure.Data.AI);

// These are Milliseconds-encoded elapsed times, so a "Time" suffix reads as a point
// in time rather than a duration (most visible in .NET, where they map to TimeSpan).
// This renames the generated client properties only; the wire names
// (dataPreprocessTime, inferenceTime, postProcessTime) are unchanged. Each emitter
// applies its own casing convention to these names.
@@clientName(LatencyResult.dataPreprocessTime, "dataPreprocessDuration");
@@clientName(LatencyResult.inferenceTime, "inferenceDuration");
@@clientName(LatencyResult.postProcessTime, "postProcessDuration");
