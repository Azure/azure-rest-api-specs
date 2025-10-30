import "@typespec/openapi";
import "@typespec/http";
import "../chat/models.tsp";
import "../conversations/models.tsp";
using TypeSpec.OpenAPI;
using TypeSpec.Http;
namespace OpenAI;
#suppress "@azure-tools/typespec-azure-core/no-enum" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
enum ImageDetail {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  low,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  high,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  auto,
}

/**Control how much effort the model will exert to match the style and features,
especially facial features, of input images. This parameter is only supported
for `gpt-image-1`. Supports `high` and `low`. Defaults to `low`.*/
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
union ImageInputFidelity {
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  "high" | "low",
  null,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model CreateImageEditRequest {
  /**The image(s) to edit. Must be a supported image file or an array of images.

  For `gpt-image-1`, each image should be a `png`, `webp`, or `jpg` file less
  than 50MB. You can provide up to 16 images.

  For `dall-e-2`, you can only provide one image, and it should be a square
  `png` file less than 4MB.*/
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-oaiMeta", #{ exampleFilePath: "otter.png" })
  image: HttpPart<bytes | bytes[]>;

  /** A text description of the desired image(s). The maximum length is 1000 characters for `dall-e-2`, and 32000 characters for `gpt-image-1`. */
  prompt: HttpPart<string>;

  /** An additional image whose fully transparent areas (e.g. where alpha is zero) indicate where `image` should be edited. If there are multiple images provided, the mask will be applied on the first image. Must be a valid PNG file, less than 4MB, and have the same dimensions as `image`. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-oaiMeta", #{ exampleFilePath: "mask.png" })
  mask?: HttpPart<bytes>;

  /**Allows to set transparency for the background of the generated image(s).
  This parameter is only supported for `gpt-image-1`. Must be one of
  `transparent`, `opaque` or `auto` (default value). When `auto` is used, the
  model will automatically determine the best background for the image.

  If `transparent`, the output format needs to support transparency, so it
  should be set to either `png` (default value) or `webp`.*/
  background?: HttpPart<"transparent" | "opaque" | "auto" | null>;

  /** The model to use for image generation. Only `dall-e-2` and `gpt-image-1` are supported. Defaults to `dall-e-2` unless a parameter specific to `gpt-image-1` is used. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-oaiTypeLabel", "string")
  `model`?: HttpPart<string | "dall-e-2" | "gpt-image-1" | null>;

  /** The number of images to generate. Must be between 1 and 10. */
  n?: HttpPart<integer | null>;

  /** The size of the generated images. Must be one of `1024x1024`, `1536x1024` (landscape), `1024x1536` (portrait), or `auto` (default value) for `gpt-image-1`, and one of `256x256`, `512x512`, or `1024x1024` for `dall-e-2`. */
  size?: HttpPart<
    | "256x256"
    | "512x512"
    | "1024x1024"
    | "1536x1024"
    | "1024x1536"
    | "auto"
    | null>;

  /** The format in which the generated images are returned. Must be one of `url` or `b64_json`. URLs are only valid for 60 minutes after the image has been generated. This parameter is only supported for `dall-e-2`, as `gpt-image-1` will always return base64-encoded images. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  response_format?: HttpPart<"url" | "b64_json" | null>;

  /**The format in which the generated images are returned. This parameter is
  only supported for `gpt-image-1`. Must be one of `png`, `jpeg`, or `webp`.
  The default value is `png`.*/
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  output_format?: HttpPart<"png" | "jpeg" | "webp" | null>;

  /**The compression level (0-100%) for the generated images. This parameter
  is only supported for `gpt-image-1` with the `webp` or `jpeg` output
  formats, and defaults to 100.*/
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  output_compression?: HttpPart<integer | null>;

  /** A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse. [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids). */
  user?: HttpPart<string>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  input_fidelity?: HttpPart<ImageInputFidelity>;

  /**Edit the image in streaming mode. Defaults to `false`. See the
  [Image generation guide](https://platform.openai.com/docs/guides/image-generation) for more information.*/
  stream?: HttpPart<boolean | null>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  partial_images?: HttpPart<PartialImages>;

  /** The quality of the image that will be generated. `high`, `medium` and `low` are only supported for `gpt-image-1`. `dall-e-2` only supports `standard` quality. Defaults to `auto`. */
  quality?: HttpPart<"standard" | "low" | "medium" | "high" | "auto" | null>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model CreateImageRequest {
  /** A text description of the desired image(s). The maximum length is 32000 characters for `gpt-image-1`, 1000 characters for `dall-e-2` and 4000 characters for `dall-e-3`. */
  prompt: string;

  /** The model to use for image generation. One of `dall-e-2`, `dall-e-3`, or `gpt-image-1`. Defaults to `dall-e-2` unless a parameter specific to `gpt-image-1` is used. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-oaiTypeLabel", "string")
  `model`?: string | "dall-e-2" | "dall-e-3" | "gpt-image-1" | null;

  /** The number of images to generate. Must be between 1 and 10. For `dall-e-3`, only `n=1` is supported. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  @maxValue(10)
  @minValue(1)
  n?: integer | null = 1;

  /**The quality of the image that will be generated.

  - `auto` (default value) will automatically select the best quality for the given model.
  - `high`, `medium` and `low` are supported for `gpt-image-1`.
  - `hd` and `standard` are supported for `dall-e-3`.
  - `standard` is the only option for `dall-e-2`.*/
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  quality?:
    | "standard"
    | "hd"
    | "low"
    | "medium"
    | "high"
    | "auto"
    | null = "auto";

  /** The format in which generated images with `dall-e-2` and `dall-e-3` are returned. Must be one of `url` or `b64_json`. URLs are only valid for 60 minutes after the image has been generated. This parameter isn't supported for `gpt-image-1` which will always return base64-encoded images. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  response_format?: "url" | "b64_json" | null = "url";

  /** The format in which the generated images are returned. This parameter is only supported for `gpt-image-1`. Must be one of `png`, `jpeg`, or `webp`. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  output_format?: "png" | "jpeg" | "webp" | null = "png";

  /** The compression level (0-100%) for the generated images. This parameter is only supported for `gpt-image-1` with the `webp` or `jpeg` output formats, and defaults to 100. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  output_compression?: integer | null = 100;

  /**Generate the image in streaming mode. Defaults to `false`. See the
  [Image generation guide](https://platform.openai.com/docs/guides/image-generation) for more information.
  This parameter is only supported for `gpt-image-1`.*/
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  stream?: boolean | null;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  partial_images?: PartialImages;

  /** The size of the generated images. Must be one of `1024x1024`, `1536x1024` (landscape), `1024x1536` (portrait), or `auto` (default value) for `gpt-image-1`, one of `256x256`, `512x512`, or `1024x1024` for `dall-e-2`, and one of `1024x1024`, `1792x1024`, or `1024x1792` for `dall-e-3`. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  size?:
    | "auto"
    | "1024x1024"
    | "1536x1024"
    | "1024x1536"
    | "256x256"
    | "512x512"
    | "1792x1024"
    | "1024x1792"
    | null = "auto";

  /** Control the content-moderation level for images generated by `gpt-image-1`. Must be either `low` for less restrictive filtering or `auto` (default value). */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  moderation?: "low" | "auto" | null = "auto";

  /**Allows to set transparency for the background of the generated image(s).
  This parameter is only supported for `gpt-image-1`. Must be one of
  `transparent`, `opaque` or `auto` (default value). When `auto` is used, the
  model will automatically determine the best background for the image.

  If `transparent`, the output format needs to support transparency, so it
  should be set to either `png` (default value) or `webp`.*/
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  background?: "transparent" | "opaque" | "auto" | null = "auto";

  /** The style of the generated images. This parameter is only supported for `dall-e-3`. Must be one of `vivid` or `natural`. Vivid causes the model to lean towards generating hyper-real and dramatic images. Natural causes the model to produce more natural, less hyper-real looking images. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  style?: "vivid" | "natural" | null = "vivid";

  /** A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse. [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids). */
  user?: string;
}

/**The number of partial images to generate. This parameter is used for
streaming responses that return partial images. Value must be between 0 and 3.
When set to 0, the response will be a single image sent in one streaming event.

Note that the final image may be sent before the full number of partial images
are generated if the full image is generated more quickly.*/
@maxValue(3)
@minValue(0)
union PartialImages {
  integer,
  null,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model CreateImageVariationRequest {
  /** The image to use as the basis for the variation(s). Must be a valid PNG file, less than 4MB, and square. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-oaiMeta", #{ exampleFilePath: "otter.png" })
  image: HttpPart<bytes>;

  /** The model to use for image generation. Only `dall-e-2` is supported at this time. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-oaiTypeLabel", "string")
  `model`?: HttpPart<string | "dall-e-2" | null>;

  /** The number of images to generate. Must be between 1 and 10. */
  n?: HttpPart<integer | null>;

  /** The format in which the generated images are returned. Must be one of `url` or `b64_json`. URLs are only valid for 60 minutes after the image has been generated. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  response_format?: HttpPart<"url" | "b64_json" | null>;

  /** The size of the generated images. Must be one of `256x256`, `512x512`, or `1024x1024`. */
  size?: HttpPart<"256x256" | "512x512" | "1024x1024" | null>;

  /** A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse. [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids). */
  user?: HttpPart<string>;
}

#suppress "@azure-tools/typespec-azure-core/no-enum" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
enum DetailEnum {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  low,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  high,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  auto,
}

/** Represents the content or the URL of an image generated by the OpenAI API. */
model Image {
  /** The base64-encoded JSON of the generated image. Default value for `gpt-image-1`, and only present if `response_format` is set to `b64_json` for `dall-e-2` and `dall-e-3`. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  b64_json?: string;

  /** When using `dall-e-2` or `dall-e-3`, the URL of the generated image if `response_format` is set to `url` (default value). Unsupported for `gpt-image-1`. */
  url?: string;

  /** For `dall-e-3` only, the revised prompt that was used to generate the image. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  revised_prompt?: string;
}

/** Emitted when image editing has completed and the final image is available. */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@extension(
  "x-oaiMeta",
  #{
    name: "image_edit.completed",
    group: "images",
    example: "{\n  \"type\": \"image_edit.completed\",\n  \"b64_json\": \"...\",\n  \"created_at\": 1620000000,\n  \"size\": \"1024x1024\",\n  \"quality\": \"high\",\n  \"background\": \"transparent\",\n  \"output_format\": \"png\",\n  \"usage\": {\n    \"total_tokens\": 100,\n    \"input_tokens\": 50,\n    \"output_tokens\": 50,\n    \"input_tokens_details\": {\n      \"text_tokens\": 10,\n      \"image_tokens\": 40\n    }\n  }\n}\n",
  }
)
model ImageEditCompletedEvent extends ImageEditStreamEvent {
  /** The type of the event. Always `image_edit.completed`. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "image_edit.completed";

  /** Base64-encoded final edited image data, suitable for rendering as an image. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  b64_json: string;

  /** The Unix timestamp when the event was created. */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  created_at: integer;

  /** The size of the edited image. */
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  size: "1024x1024" | "1024x1536" | "1536x1024" | "auto";

  /** The quality setting for the edited image. */
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  quality: "low" | "medium" | "high" | "auto";

  /** The background setting for the edited image. */
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  background: "transparent" | "opaque" | "auto";

  /** The output format for the edited image. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  output_format: "png" | "webp" | "jpeg";

  usage: ImagesUsage;
}

/** For `gpt-image-1` only, the token usage information for the image generation. */
model ImagesUsage {
  /** The total number of tokens (images and text) used for the image generation. */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  total_tokens: integer;

  /** The number of tokens (images and text) in the input prompt. */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  input_tokens: integer;

  /** The number of image tokens in the output image. */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  output_tokens: integer;

  /** The input tokens detailed information for the image generation. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  input_tokens_details: ImagesUsageInputTokensDetails;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model ImagesUsageInputTokensDetails {
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  text_tokens: integer;
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  image_tokens: integer;
}

/** Emitted when a partial image is available during image editing streaming. */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@extension(
  "x-oaiMeta",
  #{
    name: "image_edit.partial_image",
    group: "images",
    example: "{\n  \"type\": \"image_edit.partial_image\",\n  \"b64_json\": \"...\",\n  \"created_at\": 1620000000,\n  \"size\": \"1024x1024\",\n  \"quality\": \"high\",\n  \"background\": \"transparent\",\n  \"output_format\": \"png\",\n  \"partial_image_index\": 0\n}\n",
  }
)
model ImageEditPartialImageEvent extends ImageEditStreamEvent {
  /** The type of the event. Always `image_edit.partial_image`. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "image_edit.partial_image";

  /** Base64-encoded partial image data, suitable for rendering as an image. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  b64_json: string;

  /** The Unix timestamp when the event was created. */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  created_at: integer;

  /** The size of the requested edited image. */
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  size: "1024x1024" | "1024x1536" | "1536x1024" | "auto";

  /** The quality setting for the requested edited image. */
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  quality: "low" | "medium" | "high" | "auto";

  /** The background setting for the requested edited image. */
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  background: "transparent" | "opaque" | "auto";

  /** The output format for the requested edited image. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  output_format: "png" | "webp" | "jpeg";

  /** 0-based index for the partial image (streaming). */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  partial_image_index: integer;
}

/** Emitted when image generation has completed and the final image is available. */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@extension(
  "x-oaiMeta",
  #{
    name: "image_generation.completed",
    group: "images",
    example: "{\n  \"type\": \"image_generation.completed\",\n  \"b64_json\": \"...\",\n  \"created_at\": 1620000000,\n  \"size\": \"1024x1024\",\n  \"quality\": \"high\",\n  \"background\": \"transparent\",\n  \"output_format\": \"png\",\n  \"usage\": {\n    \"total_tokens\": 100,\n    \"input_tokens\": 50,\n    \"output_tokens\": 50,\n    \"input_tokens_details\": {\n      \"text_tokens\": 10,\n      \"image_tokens\": 40\n    }\n  }\n}\n",
  }
)
model ImageGenCompletedEvent extends ImageGenStreamEvent {
  /** The type of the event. Always `image_generation.completed`. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "image_generation.completed";

  /** Base64-encoded image data, suitable for rendering as an image. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  b64_json: string;

  /** The Unix timestamp when the event was created. */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  created_at: integer;

  /** The size of the generated image. */
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  size: "1024x1024" | "1024x1536" | "1536x1024" | "auto";

  /** The quality setting for the generated image. */
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  quality: "low" | "medium" | "high" | "auto";

  /** The background setting for the generated image. */
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  background: "transparent" | "opaque" | "auto";

  /** The output format for the generated image. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  output_format: "png" | "webp" | "jpeg";

  usage: ImagesUsage;
}

/** Emitted when a partial image is available during image generation streaming. */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@extension(
  "x-oaiMeta",
  #{
    name: "image_generation.partial_image",
    group: "images",
    example: "{\n  \"type\": \"image_generation.partial_image\",\n  \"b64_json\": \"...\",\n  \"created_at\": 1620000000,\n  \"size\": \"1024x1024\",\n  \"quality\": \"high\",\n  \"background\": \"transparent\",\n  \"output_format\": \"png\",\n  \"partial_image_index\": 0\n}\n",
  }
)
model ImageGenPartialImageEvent extends ImageGenStreamEvent {
  /** The type of the event. Always `image_generation.partial_image`. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
  @extension("x-stainless-const", true)
  type: "image_generation.partial_image";

  /** Base64-encoded partial image data, suitable for rendering as an image. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  b64_json: string;

  /** The Unix timestamp when the event was created. */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  created_at: integer;

  /** The size of the requested image. */
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  size: "1024x1024" | "1024x1536" | "1536x1024" | "auto";

  /** The quality setting for the requested image. */
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  quality: "low" | "medium" | "high" | "auto";

  /** The background setting for the requested image. */
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  background: "transparent" | "opaque" | "auto";

  /** The output format for the requested image. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  output_format: "png" | "webp" | "jpeg";

  /** 0-based index for the partial image (streaming). */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  partial_image_index: integer;
}

/** The response from the image generation endpoint. */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Image generation response")
@extension(
  "x-oaiMeta",
  #{
    name: "The image generation response",
    group: "images",
    example: "{\n  \"created\": 1713833628,\n  \"data\": [\n    {\n      \"b64_json\": \"...\"\n    }\n  ],\n  \"background\": \"transparent\",\n  \"output_format\": \"png\",\n  \"size\": \"1024x1024\",\n  \"quality\": \"high\",\n  \"usage\": {\n    \"total_tokens\": 100,\n    \"input_tokens\": 50,\n    \"output_tokens\": 50,\n    \"input_tokens_details\": {\n      \"text_tokens\": 10,\n      \"image_tokens\": 40\n    }\n  }\n}\n",
  }
)
model ImagesResponse {
  /** The Unix timestamp (in seconds) of when the image was created. */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  created: integer;

  /** The list of generated images. */
  data?: Image[];

  /** The background parameter used for the image generation. Either `transparent` or `opaque`. */
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  background?: "transparent" | "opaque";

  /** The output format of the image generation. Either `png`, `webp`, or `jpeg`. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  output_format?: "png" | "webp" | "jpeg";

  /** The size of the image generated. Either `1024x1024`, `1024x1536`, or `1536x1024`. */
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  size?: "1024x1024" | "1024x1536" | "1536x1024";

  /** The quality of the image generated. Either `low`, `medium`, or `high`. */
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  quality?: "low" | "medium" | "high";

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  usage?: ImageGenUsage;
}

/** For `gpt-image-1` only, the token usage information for the image generation. */
@summary("Image generation usage")
model ImageGenUsage {
  /** The number of tokens (images and text) in the input prompt. */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  input_tokens: integer;

  /** The total number of tokens (images and text) used for the image generation. */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  total_tokens: integer;

  /** The number of output tokens generated by the model. */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  output_tokens: integer;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  input_tokens_details: ImageGenInputUsageDetails;
}

/** The input tokens detailed information for the image generation. */
@summary("Input usage details")
model ImageGenInputUsageDetails {
  /** The number of text tokens in the input prompt. */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  text_tokens: integer;

  /** The number of image tokens in the input prompt. */
  #suppress "@azure-tools/typespec-azure-core/no-generic-numeric" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  image_tokens: integer;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model CreateImageEditStreamingResponse {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  @header
  contentType: "text/event-stream";

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  @body
  body: ImageEditStreamEvent;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
@discriminator("type")
model ImageEditStreamEvent {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Auto-suppressed warnings non-applicable rules during import."
  type: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
model CreateImageStreamingResponse {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  @header
  contentType: "text/event-stream";

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  @body
  body: ImageGenStreamEvent;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
@discriminator("type")
model ImageGenStreamEvent {
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Auto-suppressed warnings non-applicable rules during import."
  type: string;
}
