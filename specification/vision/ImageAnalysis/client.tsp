import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@internal(ImageAnalysis.analyzeFromStream, "csharp");
@@internal(ImageAnalysis.analyzeFromUrl, "csharp");
@@internal(ImageAnalysis.segmentFromStream, "csharp");
@@internal(ImageAnalysis.segmentFromUrl, "csharp");
