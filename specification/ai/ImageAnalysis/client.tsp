import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@access(ImageAnalysis.analyzeFromBuffer, Access.internal, "csharp,java");
@@access(ImageAnalysis.analyzeFromUrl, Access.internal, "csharp,java");

@@access(ImageAnalysis.ImageAnalysisResult, Access.public, "csharp,java");
@@access(ImageAnalysis.CaptionResult, Access.public, "csharp,java");
@@access(ImageAnalysis.DenseCaptionsResult, Access.public, "csharp,java");
@@access(ImageAnalysis.ImageMetadata, Access.public, "csharp,java");
@@access(ImageAnalysis.ObjectsResult, Access.public, "csharp,java");
@@access(ImageAnalysis.PeopleResult, Access.public, "csharp,java");
@@access(ImageAnalysis.ReadResult, Access.public, "csharp,java");
@@access(ImageAnalysis.SmartCropsResult, Access.public, "csharp,java");
@@access(ImageAnalysis.TagsResult, Access.public, "csharp,java");
@@access(ImageAnalysis.DenseCaption, Access.public, "csharp,java");
@@access(ImageAnalysis.DetectedObject, Access.public, "csharp,java");
@@access(ImageAnalysis.DetectedPerson, Access.public, "csharp,java");
@@access(ImageAnalysis.DetectedTag, Access.public, "csharp,java");
@@access(ImageAnalysis.CropRegion, Access.public, "csharp,java");
@@access(ImageAnalysis.ImagePoint, Access.public, "csharp,java");
@@access(ImageAnalysis.DetectedTextWord, Access.public, "csharp,java");
@@access(ImageAnalysis.DetectedTextLine, Access.public, "csharp,java");
@@access(ImageAnalysis.DetectedTextBlock, Access.public, "csharp,java");
@@access(ImageAnalysis.ImageBoundingBox, Access.public, "csharp,java");

@@projectedName(ImageAnalysis.VisualFeatures, "csharp", "VisualFeaturesImpl");
