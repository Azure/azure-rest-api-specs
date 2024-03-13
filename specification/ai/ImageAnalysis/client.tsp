import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@access(ImageAnalysis.analyzeFromImageData, Access.internal, "csharp");
@@access(ImageAnalysis.analyzeFromUrl, Access.internal, "csharp");

@@access(ImageAnalysis.CaptionResult, Access.public, "csharp");
@@access(ImageAnalysis.CropRegion, Access.public, "csharp");
@@access(ImageAnalysis.DenseCaption, Access.public, "csharp");
@@access(ImageAnalysis.DenseCaptionsResult, Access.public, "csharp");
@@access(ImageAnalysis.DetectedObject, Access.public, "csharp");
@@access(ImageAnalysis.DetectedPerson, Access.public, "csharp");
@@access(ImageAnalysis.DetectedTag, Access.public, "csharp");
@@access(ImageAnalysis.DetectedTextBlock, Access.public, "csharp");
@@access(ImageAnalysis.DetectedTextLine, Access.public, "csharp");
@@access(ImageAnalysis.DetectedTextWord, Access.public, "csharp");
@@access(ImageAnalysis.ImageAnalysisResult, Access.public, "csharp");
@@access(ImageAnalysis.ImageBoundingBox, Access.public, "csharp");
@@access(ImageAnalysis.ImageMetadata, Access.public, "csharp");
@@access(ImageAnalysis.ImagePoint, Access.public, "csharp");
@@access(ImageAnalysis.ObjectsResult, Access.public, "csharp");
@@access(ImageAnalysis.PeopleResult, Access.public, "csharp");
@@access(ImageAnalysis.ReadResult, Access.public, "csharp");
@@access(ImageAnalysis.SmartCropsResult, Access.public, "csharp");
@@access(ImageAnalysis.TagsResult, Access.public, "csharp");

@@projectedName(ImageAnalysis.VisualFeatures, "csharp", "VisualFeaturesImpl");

@@access(ImageAnalysis.analyzeFromImageData, Access.internal, "java");
@@access(ImageAnalysis.analyzeFromUrl, Access.internal, "java");

@@access(ImageAnalysis.CaptionResult, Access.public, "java");
@@access(ImageAnalysis.CropRegion, Access.public, "java");
@@access(ImageAnalysis.DenseCaption, Access.public, "java");
@@access(ImageAnalysis.DenseCaptionsResult, Access.public, "java");
@@access(ImageAnalysis.DetectedObject, Access.public, "java");
@@access(ImageAnalysis.DetectedPerson, Access.public, "java");
@@access(ImageAnalysis.DetectedTag, Access.public, "java");
@@access(ImageAnalysis.DetectedTextBlock, Access.public, "java");
@@access(ImageAnalysis.DetectedTextLine, Access.public, "java");
@@access(ImageAnalysis.DetectedTextWord, Access.public, "java");
@@access(ImageAnalysis.ImageAnalysisResult, Access.public, "java");
@@access(ImageAnalysis.ImageBoundingBox, Access.public, "java");
@@access(ImageAnalysis.ImageMetadata, Access.public, "java");
@@access(ImageAnalysis.ImagePoint, Access.public, "java");
@@access(ImageAnalysis.ObjectsResult, Access.public, "java");
@@access(ImageAnalysis.PeopleResult, Access.public, "java");
@@access(ImageAnalysis.ReadResult, Access.public, "java");
@@access(ImageAnalysis.SmartCropsResult, Access.public, "java");
@@access(ImageAnalysis.TagsResult, Access.public, "java");
@@access(ImageAnalysis.VisualFeatures, Access.public, "java");

@@access(ImageAnalysis.analyzeFromImageData, Access.internal, "python");
@@access(ImageAnalysis.analyzeFromUrl, Access.internal, "python");

@@access(ImageAnalysis.CaptionResult, Access.public, "python");
@@access(ImageAnalysis.CropRegion, Access.public, "python");
@@access(ImageAnalysis.DenseCaption, Access.public, "python");
@@access(ImageAnalysis.DenseCaptionsResult, Access.public, "python");
@@access(ImageAnalysis.DetectedObject, Access.public, "python");
@@access(ImageAnalysis.DetectedPerson, Access.public, "python");
@@access(ImageAnalysis.DetectedTag, Access.public, "python");
@@access(ImageAnalysis.DetectedTextBlock, Access.public, "python");
@@access(ImageAnalysis.DetectedTextLine, Access.public, "python");
@@access(ImageAnalysis.DetectedTextWord, Access.public, "python");
@@access(ImageAnalysis.ImageAnalysisResult, Access.public, "python");
@@access(ImageAnalysis.ImageBoundingBox, Access.public, "python");
@@access(ImageAnalysis.ImageMetadata, Access.public, "python");
@@access(ImageAnalysis.ImagePoint, Access.public, "python");
@@access(ImageAnalysis.ObjectsResult, Access.public, "python");
@@access(ImageAnalysis.PeopleResult, Access.public, "python");
@@access(ImageAnalysis.ReadResult, Access.public, "python");
@@access(ImageAnalysis.SmartCropsResult, Access.public, "python");
@@access(ImageAnalysis.TagsResult, Access.public, "python");
@@access(ImageAnalysis.VisualFeatures, Access.public, "python");
