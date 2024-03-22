import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/http";

import "./models.tsp";

using Azure.Core.Traits;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace ImageAnalysis;

alias SharedAnalyzeQuery = {
  @query({
    name: "features",
    format: "csv",
  })
  @doc("""
  A list of visual features to analyze.
  Seven visual features are supported: Caption, DenseCaptions, Read (OCR), Tags, Objects, SmartCrops, and People.
  At least one visual feature must be specified.
  """)
  @minItems(1)
  visualFeatures: Array<VisualFeatures>;

  @query("language")
  @doc("""
  The desired language for result generation (a two-letter language code).
  If this option is not specified, the default value 'en' is used (English).
  See https://aka.ms/cv-languages for a list of supported languages.
  """)
  @minLength(2)
  language?: string = "en";

  @query("gender-neutral-caption")
  @doc("""
  Boolean flag for enabling gender-neutral captioning for Caption and Dense Captions features.
  By default captions may contain gender terms (for example: 'man', 'woman', or 'boy', 'girl'). 
  If you set this to \"true\", those will be replaced with gender-neutral terms (for example: 'person' or 'child').
  """)
  genderNeutralCaption?: boolean = false;

  @query({
    name: "smartcrops-aspect-ratios",
    format: "csv",
  })
  @doc("""
  A list of aspect ratios to use for smart cropping.
  Aspect ratios are calculated by dividing the target crop width in pixels by the height in pixels.
  Supported values are between 0.75 and 1.8 (inclusive).
  If this parameter is not specified, the service will return one crop region with an aspect
  ratio it sees fit between 0.5 and 2.0 (inclusive).
  """)
  smartCropsAspectRatios?: Array<float32>;

  @query("model-version")
  @doc("""
  The version of cloud AI-model used for analysis.
  The format is the following: 'latest' (default value) or 'YYYY-MM-DD' or 'YYYY-MM-DD-preview', where 'YYYY', 'MM', 'DD' are the year, month and day associated with the model.
  This is not commonly set, as the default always gives the latest AI model with recent improvements.
  If however you would like to make sure analysis results do not change over time, set this value to a specific model version.
  """)
  @pattern("^(latest|\\d{4}-\\d{2}-\\d{2})(-preview)?$")
  @minLength(6)
  @maxLength(18)
  modelVersion?: string = "latest";
};

#suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to analyze an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
@doc("Performs a single Image Analysis operation")
@route("imageanalysis:analyze")
@post
@sharedRoute
op analyzeFromImageData is Azure.Core.RpcOperation<
  {
    @doc("The format of the HTTP payload.")
    @header
    contentType: "application/octet-stream";

    @doc("The image to be analyzed")
    @body
    imageContent: bytes;

    ...SharedAnalyzeQuery;
  },
  ImageAnalysisResult
>;

@doc("Performs a single Image Analysis operation")
@route("imageanalysis:analyze")
@post
@sharedRoute
op analyzeFromUrl is Azure.Core.RpcOperation<
  {
    @doc("The format of the HTTP payload.")
    @header
    contentType: "application/json";

    @doc("The image to be analyzed")
    @body
    imageContent: ImageUrl;

    ...SharedAnalyzeQuery;
  },
  ImageAnalysisResult
>;
