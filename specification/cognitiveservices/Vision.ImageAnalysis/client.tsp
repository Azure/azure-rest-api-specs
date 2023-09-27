import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

// We'll overload these in the C# to be language idiomatic.
@@projectedName(ImageAnalysis.analyzeFromUrl, "client", "Analyze")
@@internal(ImageAnalysis.analyzeFromStream, "csharp")
@@internal(ImageAnalysis.segmentFromStream, "csharp")
