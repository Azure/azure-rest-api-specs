import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace ModelInference;

@doc("""
  The configuration information for an image generation request.
  """)
@added(ModelInference.Versions.v2025_05_15_Preview)
model ImageGenerationsOptions {
  @doc("""
    The prompt to use for the image geneartion. Read the model documentation to understand
    which language you should use to prompt the model and get specific results.
    """)
  prompt: string;

  @doc("""
    Optional. The prompt to use for the negative image generation. Read the model documentation
    to understand to prompt the model and get specific results. If the model doesn't support
    negative prompts, a 422 error is returned.
    """)
  negative_prompt?: string;

  @doc("""
    Optional. An image to use as guidance for the image generation process.
    """)
  image_prompt?: ImageGenerationPrompt;

  #suppress "@azure-tools/typespec-autorest/union-unsupported" "OpenAPI v2 support deferred"
  @doc("""
    The size of the image to generate.
    """)
  size: ImageGenerationPreset | ImageGenerationSize;

  @doc("""
    Optional. The format in which to generate the image.
    Returns a 422 error if the model doesn't support the value or parameter.
    """)
  output_format?: ImageGenerationOutputFormat = "png";

  @doc("""
    Optional. The quality of the image to generate.
    Returns a 422 error if the model doesn't support the value or parameter.
    """)
  quality?: ImageGenerationQuality = "standard";

  @doc("""
    The number of images to generate. Defaults to 1.
    """)
  n: int32 = 1;

  @doc("""
    ID of the specific AI model to use, if more than one model is available on the endpoint.
    """)
  `model`?: string;

  @doc("""
    If specified, the system will make a best effort to sample deterministically such that repeated requests with the
    same seed and parameters should return the same result. Determinism is not guaranteed.
    """)
  seed?: int64;

  ...Record<unknown>;
}

@doc("The preset size of the image to generate.")
@added(ModelInference.Versions.v2025_05_15_Preview)
union ImageGenerationPreset {
  string,

  @doc("The size of the image is 672x1566 pixels.")
  nine_twenty_one: "672x1566",

  @doc("The size of the image is 768x1366 pixels.")
  nine_sixteen: "768x1366",

  @doc("The size of the image is 836x1254 pixels.")
  two_three: "836x1254",

  @doc("The size of the image is 916x1145 pixels.")
  four_five: "916x1145",

  @doc("The size of the image is 1024x1024 pixels.")
  one_one: "1024x1024",

  @doc("The size of the image is 1145x916 pixels.")
  five_four: "1145x916",

  @doc("The size of the image is 1254x836 pixels.")
  three_two: "1254x836",

  @doc("The size of the image is 1366x768 pixels.")
  sixteen_nine: "1366x768",

  @doc("The size of the image is 1566x672 pixels.")
  twenty_one_nine: "1566x672",
}

@doc("The size of the image to generate.")
@added(ModelInference.Versions.v2025_05_15_Preview)
model ImageGenerationSize {
  @doc("The width of the image to generate, in pixels.")
  width: int32;

  @doc("The height of the image to generate, in pixels.")
  height: int32;
}

@doc("The image generation format to use in the output.")
@added(ModelInference.Versions.v2025_05_15_Preview)
union ImageGenerationOutputFormat {
  string,

  @doc("Generates images in PNG format.")
  png: "png",

  @doc("Generates images in JPEG format.")
  jpg: "jpg",
}

@doc("Represents an image to use for guidance during the generation.")
@added(ModelInference.Versions.v2025_05_15_Preview)
model ImageGenerationPrompt {
  @doc("""
    The input image encoded in base64 string as a data URL.
    Example: `data:image/{format};base64,{data}`."
    """)
  image: string;

  @doc("""
    The degree at which the generation process uses the image prompt as guidance. 1 indicates
    a generation process that fully follows the input image. 0 a generation a process that doesn't
    take into consideration the prompt image.
    """)
  strength?: float32 = 1;
}

@doc("The quality of the image to generate.")
@added(ModelInference.Versions.v2025_05_15_Preview)
union ImageGenerationQuality {
  string,

  @doc("Generates images with the HD quality.")
  hd: "hd",

  @doc("Generates images with standard quality.")
  standard: "standard",
}

@doc("The result of an image generation request.")
@added(ModelInference.Versions.v2025_05_15_Preview)
model ImageGenerationsResult {
  @doc("Unique identifier for the generation result.")
  id: string;

  #suppress "@microsoft/azure-openapi-validator/IntegerTypeMustHaveFormat" "Format is present but rule only allow int32 or int64."
  @doc("""
    The first timestamp associated with generation activity for this completions response,
    represented as seconds since the beginning of the Unix epoch of 00:00 on 1 Jan 1970.
    """)
  @encode(DateTimeKnownEncoding.unixTimestamp, int64)
  created: utcDateTime;

  @doc("The model used for the chat completion.")
  `model`: string;

  @doc("Embedding values for the prompts submitted in the request.")
  data: ImageGenerationItem[];

  @doc("Usage counts for tokens input using the embeddings API.")
  usage: ImageGenerationUsage;

  @doc("The object type of the image generation result. Will always be `list`.")
  object: "image.generation";
}

@doc("Representation of a single image generation.")
@added(ModelInference.Versions.v2025_05_15_Preview)
model ImageGenerationItem {
  @doc("The image generated, encoded in base64.")
  image: string;

  @doc("The seed that can be used to generate the image.")
  seed?: int64;
}

@doc("Usage counts for image generation API.")
@added(ModelInference.Versions.v2025_05_15_Preview)
model ImageGenerationUsage {
  @doc("The number of image generations performed.")
  image_generations: int32;
}
