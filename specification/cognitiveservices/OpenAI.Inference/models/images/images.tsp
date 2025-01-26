import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

import "./common.tsp";
import "../completions/azure_content_filtering.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Azure.OpenAI;

@doc("The desired size of generated images.")
@added(ServiceApiVersions.v2023_06_01_Preview)
union ImageSize {
  string,

  @doc("""
    Very small image size of 256x256 pixels.
    Only supported with dall-e-2 models.
    """)
  size256x256: "256x256",

  @doc("""
    A smaller image size of 512x512 pixels.
    Only supported with dall-e-2 models.
    """)
  size512x512: "512x512",

  @doc("""
    A standard, square image size of 1024x1024 pixels.
    Supported by both dall-e-2 and dall-e-3 models.
    """)
  @added(ServiceApiVersions.v2024_02_15_Preview)
  size1024x1024: "1024x1024",

  @doc("""
    A wider image size of 1024x1792 pixels.
    Only supported with dall-e-3 models.
    """)
  @added(ServiceApiVersions.v2024_02_15_Preview)
  size1792x1024: "1792x1024",

  @doc("""
    A taller image size of 1792x1024 pixels.
    Only supported with dall-e-3 models.
    """)
  @added(ServiceApiVersions.v2024_02_15_Preview)
  size1024x1792: "1024x1792",
}

@doc("""
  An image generation configuration that specifies how the model should prioritize quality, cost, and speed.
  Only configurable with dall-e-3 models.
  """)
@added(ServiceApiVersions.v2024_02_15_Preview)
union ImageGenerationQuality {
  string,

  @doc("""
    Requests image generation with standard, balanced characteristics of quality, cost, and speed.
    """)
  standard: "standard",

  @doc("""
    Requests image generation with higher quality, higher cost and lower speed relative to standard.
    """)
  hd: "hd",
}

@doc("""
  An image generation configuration that specifies how the model should incorporate realism and other visual characteristics.
  Only configurable with dall-e-3 models.
  """)
@added(ServiceApiVersions.v2024_02_15_Preview)
union ImageGenerationStyle {
  string,

  @doc("""
    Requests image generation in a natural style with less preference for dramatic and hyper-realistic characteristics.
    """)
  natural: "natural",

  @doc("""
    Requests image generation in a vivid style with a higher preference for dramatic and hyper-realistic
    characteristics.
    """)
  vivid: "vivid",
}

@doc("The format in which the generated images are returned.")
@added(ServiceApiVersions.v2023_06_01_Preview)
union ImageGenerationResponseFormat {
  string,

  @doc("Image generation response items should provide a URL from which the image may be retrieved.")
  url: "url",

  @doc("Image generation response items should provide image data as a base64-encoded string.")
  base64: "b64_json",
}

@doc("Represents the request data used to generate images.")
@added(ServiceApiVersions.v2023_06_01_Preview)
model ImageGenerationOptions {
  @doc("""
    The model name or Azure OpenAI model deployment name to use for image generation. If not specified, dall-e-2 will be
    inferred as a default.
    """)
  `model`?: string;

  @doc("A description of the desired images.")
  prompt: string;

  @doc("""
    The number of images to generate.
    Dall-e-2 models support values between 1 and 10.
    Dall-e-3 models only support a value of 1.
    """)
  @clientName("ImageCount", "csharp")
  n?: int32 = 1;

  @doc("""
    The desired dimensions for generated images.
    Dall-e-2 models support 256x256, 512x512, or 1024x1024.
    Dall-e-3 models support 1024x1024, 1792x1024, or 1024x1792.
    """)
  size?: ImageSize = ImageSize.size1024x1024;

  @doc("The format in which image generation response items should be presented.")
  @encodedName("application/json", "response_format")
  responseFormat?: ImageGenerationResponseFormat = ImageGenerationResponseFormat.url;

  @doc("""
    The desired image generation quality level to use.
    Only configurable with dall-e-3 models.
    """)
  @added(ServiceApiVersions.v2024_02_15_Preview)
  quality?: ImageGenerationQuality = ImageGenerationQuality.standard;

  @doc("""
    The desired image generation style to use.
    Only configurable with dall-e-3 models.
    """)
  @added(ServiceApiVersions.v2024_02_15_Preview)
  style?: ImageGenerationStyle = ImageGenerationStyle.vivid;

  @doc("A unique identifier representing your end-user, which can help to monitor and detect abuse.")
  user?: string;
}

@doc("Describes the content filtering result for the image generation request.")
@added(ServiceApiVersions.v2024_02_15_Preview)
model ImageGenerationContentFilterResults {
  @doc("""
    Describes language related to anatomical organs and genitals, romantic relationships,
     acts portrayed in erotic or affectionate terms, physical sexual acts, including
     those portrayed as an assault or a forced sexual violent act against one’s will,
     prostitution, pornography, and abuse.
    """)
  sexual?: ContentFilterResult;

  @doc("""
    Describes language related to physical actions intended to hurt, injure, damage, or
    kill someone or something; describes weapons, etc.
    """)
  violence?: ContentFilterResult;

  @doc("""
    Describes language attacks or uses that include pejorative or discriminatory language
    with reference to a person or identity group on the basis of certain differentiating
    attributes of these groups including but not limited to race, ethnicity, nationality,
    gender identity and expression, sexual orientation, religion, immigration status, ability
    status, personal appearance, and body size.
    """)
  hate?: ContentFilterResult;

  @doc("""
    Describes language related to physical actions intended to purposely hurt, injure,
    or damage one’s body, or kill oneself.
    """)
  @encodedName("application/json", "self_harm")
  selfHarm?: ContentFilterResult;
}

@doc("Describes the content filtering results for the prompt of a image generation request.")
@added(ServiceApiVersions.v2024_02_15_Preview)
model ImageGenerationPromptFilterResults {
  ...ImageGenerationContentFilterResults;

  @doc("Describes whether profanity was detected.")
  profanity?: ContentFilterDetectionResult;

  @doc("Whether a jailbreak attempt was detected in the prompt.")
  jailbreak?: ContentFilterDetectionResult;

  /** Information about customer block lists and if something was detected the associated list ID. */
  @encodedName("application/json", "custom_blocklists")
  @added(ServiceApiVersions.v2024_05_01_Preview)
  customBlocklists?: ContentFilterDetailedResults;
}

@doc("""
  A representation of a single generated image, provided as either base64-encoded data or as a URL from which the image
  may be retrieved.
  """)
@added(ServiceApiVersions.v2023_06_01_Preview)
model ImageGenerationData {
  @doc("The URL that provides temporary access to download the generated image.")
  url?: url;

  @doc("The complete data for an image, represented as a base64-encoded string.")
  @encodedName("application/json", "b64_json")
  base64Data?: string;

  @doc("Information about the content filtering results.")
  @added(ServiceApiVersions.v2024_02_15_Preview)
  @encodedName("application/json", "content_filter_results")
  contentFilterResults?: ImageGenerationContentFilterResults;

  @doc("""
    The final prompt used by the model to generate the image.
    Only provided with dall-3-models and only when revisions were made to the prompt.
    """)
  @added(ServiceApiVersions.v2024_02_15_Preview)
  @encodedName("application/json", "revised_prompt")
  revisedPrompt?: string;

  @doc("""
    Information about the content filtering category (hate, sexual, violence, self_harm), if
    it has been detected, as well as the severity level (very_low, low, medium, high-scale
    that determines the intensity and risk level of harmful content) and if it has been
    filtered or not. Information about jailbreak content and profanity, if it has been detected,
    and if it has been filtered or not. And information about customer block list, if it has
    been filtered and its id.
    """)
  @added(ServiceApiVersions.v2024_02_15_Preview)
  @encodedName("application/json", "prompt_filter_results")
  promptFilterResults?: ImageGenerationPromptFilterResults;
}

@doc("The result of a successful image generation operation.")
@added(ServiceApiVersions.v2023_06_01_Preview)
model ImageGenerations {
  @doc("""
    A timestamp representing when this operation was started.
    Expressed in seconds since the Unix epoch of 1970-01-01T00:00:00+0000.
    """)
  @clientName("createdAt", "java")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  created: utcDateTime;

  @doc("The images generated by the operation.")
  data: ImageGenerationData[];
}

// Note: pending resolution of  cross-language code emission behavior for long-running operations, image generation
//        reuses its final operation response model as its status polling model.

// Note2: the Java emitter currently does not support versioning annotations
// To prevent code generation from picking this up we have to flat out remove it
// We need to check in an arch board meeting, whether @removed indeed should prevent
// models from being generated. It might not be the case, it should probably enforce a "maximum"
// version, but not prevent generation of models for older versions.

//@lroStatus
@doc("A polling status update or final response payload for an image operation.")
@added(ServiceApiVersions.v2023_06_01_Preview)
@removed(ServiceApiVersions.v2024_02_15_Preview)
model BatchImageGenerationOperationResponse {
  @doc("The ID of the operation.")
  id: string;

  @doc("A timestamp when this job or item was created (in unix epochs).")
  @clientName("createdAt", "java")
  @encode(DateTimeKnownEncoding.unixTimestamp, int32)
  created: utcDateTime;

  @doc("A timestamp when this operation and its associated images expire and will be deleted (in unix epochs).")
  expires?: int64;

  @doc("The result of the operation if the operation succeeded.")
  result?: ImageGenerations;

  @doc("The status of the operation")
  status: AzureOpenAIOperationState;

  @doc("The error if the operation failed.")
  error?: Foundations.Error;
}

/**
 * Get image generation body.
 */
@added(ServiceApiVersions.v2023_06_01_Preview)
model GetImageGenerationsBody {
  /**
   * Represents the request data used to generate images.
   */
  @bodyRoot
  body: ImageGenerationOptions;
}
