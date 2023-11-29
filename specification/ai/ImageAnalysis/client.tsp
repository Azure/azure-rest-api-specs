import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@access(ImageAnalysis.analyzeFromBuffer, Access.internal, "csharp");
@@access(ImageAnalysis.analyzeFromUrl, Access.internal, "csharp");

@@access(ImageAnalysis.ImageAnalysisResult, Access.public, "csharp");
@@access(ImageAnalysis.CaptionResult, Access.public, "csharp");
@@access(ImageAnalysis.DenseCaptionsResult, Access.public, "csharp");
@@access(ImageAnalysis.ImageMetadata, Access.public, "csharp");
@@access(ImageAnalysis.ObjectsResult, Access.public, "csharp");
@@access(ImageAnalysis.PeopleResult, Access.public, "csharp");
@@access(ImageAnalysis.ReadResult, Access.public, "csharp");
@@access(ImageAnalysis.SmartCropsResult, Access.public, "csharp");
@@access(ImageAnalysis.TagsResult, Access.public, "csharp");
@@access(ImageAnalysis.DenseCaption, Access.public, "csharp");
@@access(ImageAnalysis.DetectedObject, Access.public, "csharp");
@@access(ImageAnalysis.DetectedPerson, Access.public, "csharp");
@@access(ImageAnalysis.DetectedTag, Access.public, "csharp");
@@access(ImageAnalysis.CropRegion, Access.public, "csharp");
@@access(ImageAnalysis.ImagePoint, Access.public, "csharp");
@@access(ImageAnalysis.DetectedTextWord, Access.public, "csharp");
@@access(ImageAnalysis.DetectedTextLine, Access.public, "csharp");
@@access(ImageAnalysis.DetectedTextBlock, Access.public, "csharp");
@@access(ImageAnalysis.ImageBoundingBox, Access.public, "csharp");

@@projectedName(ImageAnalysis.VisualFeatures, "csharp", "VisualFeaturesImpl");

@@access(ImageAnalysis.analyzeFromBuffer, Access.internal, "java");
@@access(ImageAnalysis.analyzeFromUrl, Access.internal, "java");
@@access(ImageAnalysis.ImageUrl, Access.internal, "java");
