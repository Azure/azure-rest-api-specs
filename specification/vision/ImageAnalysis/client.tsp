import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@access(ImageAnalysis.analyzeFromStream, Access.internal, "csharp");
@@access(ImageAnalysis.analyzeFromUrl, Access.internal, "csharp");
@@access(ImageAnalysis.segmentFromStream, Access.internal, "csharp");
@@access(ImageAnalysis.segmentFromUrl, Access.internal, "csharp");
