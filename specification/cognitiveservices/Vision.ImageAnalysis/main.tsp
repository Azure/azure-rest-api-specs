import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using Azure.Core.Traits;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service({
    title: "ImageAnalysis Service",
  })

@versioned(ImageAnalysis.Versions)
@useAuth(ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">)
@server(
    "{endpoint}/imageanalysis",
    "Analyze an image to generate a description of its content.",
    {
      @doc("""
  Supported Cognitive Services endpoints (protocol and hostname, for example:
  https://<resource-name>.cognitiveservices.azure.com).
  """)
      endpoint: string,
    }
  )

namespace ImageAnalysis;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_04_30_Preview: "2023-04-30-preview",
}


@doc("Represents a person detected in an image")
model DetectedPerson {
    @doc("Gets a rectangular boundary within which the person was detected.")
    @visibility("read")
    boundingBox: BoundingBox;

    @doc ("Gets the confidence value of the detected person.")
    @visibility("read")
    confidence: int64;
}

@doc("A basic rectangle")
model BoundingBox{
  @doc("X coordinate")
  x: int64;

  @doc("Y coordinate")
  y: int64;

  @doc("Width of the box")
  width: int64;

  @doc("Height of the box")
  height: int64;
}

@doc("Represents a generated phrase that describes the content of the image.")
model ContentCaption {
    @doc("Gets a generated phrase that describes the content of the image.")
    @visibility("read")
    content: string;

    @doc("Gets the confidence score of the caption.")
    @visibility("read")
    confidence: int64;

    @doc("A rectangular boundary to which the caption applies.")
    @visibility("read")
    boundingBox: BoundingBox;
}

@doc("Represent an image tag. A tag can be a recognizable object, living being, scenery, or actions that appear in the image.")
model ContentTag {
    @doc("Gets the name of the tag")
    @visibility("read")
    name: string;

    @doc("Gets the confidence score of the tag.")
    @visibility("read")
    confidence: int64;
}

@doc("Represents the outcome of an Image Analysis operation.")
model ImageAnalysisResult {
  @doc("Height of the image")
  imageHeight:int64;

  @doc("Width of the image")
  imageWidth: int64;

  @doc("A Cpation")
  caption:ContentCaption;

  @doc("Tag")
  tag: ContentTag;

  @doc("Any detected person")
  detectedPerson:DetectedPerson;
}

@doc("Represents the configuration options that control the function of the ImageAnalyzer")
model ImageAnalysisOptions{
  @doc("Gets or sets the gender neutrality of the Image Analysis caption result.")
  genderNeutralCaption: boolean;

}

@doc("The secret key for your Azure Cognitive Services subscription.")
model ImageAnalysisApiKeyAuth
  is ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">;


alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;

@doc("A specific deployment")
@TypeSpec.Rest.resource("deployments")
model Deployment {
  @visibility("read")
  @doc("Specifies either the model deployment name (when using Azure OpenAI) or model name (when using non-Azure OpenAI) to use for this request.")
  @projectedName("java", "deploymentOrModelName")
  @key
  deploymentId: string;
}

@doc("Performs a single Image Analysis operation")
@actionSeparator("/")
@route("imageanalysis/analyze") //@convenientAPI(true)
op analyze is Azure.Core.RpcOperation<
  ImageAnalysisOptions,
  ImageAnalysisResult
>;