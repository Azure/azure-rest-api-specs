import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@access(ImageAnalysis.analyzeFromStream, Access.internal, "csharp");
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
@@access(ImageAnalysis.VisualFeatures, Access.public, "csharp");
@@access(ImageAnalysis.DenseCaption, Access.public, "csharp");
@@access(ImageAnalysis.DetectedObject, Access.public, "csharp");
@@access(ImageAnalysis.DetectedPerson, Access.public, "csharp");
@@access(ImageAnalysis.DetectedTag, Access.public, "csharp");
@@access(ImageAnalysis.CropRegion, Access.public, "csharp");
@@access(ImageAnalysis.DocumentPage, Access.public, "csharp");
@@access(ImageAnalysis.DocumentLine, Access.public, "csharp");
@@access(ImageAnalysis.DocumentSpan, Access.public, "csharp");
@@access(ImageAnalysis.DocumentStyle, Access.public, "csharp");
@@access(ImageAnalysis.DocumentWord, Access.public, "csharp");
@@access(ImageAnalysis.ImageBoundingBox, Access.public, "csharp");
