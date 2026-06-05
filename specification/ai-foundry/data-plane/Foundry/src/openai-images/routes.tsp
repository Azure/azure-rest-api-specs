import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/images";
using TypeSpec.Http;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/images")
@tag("Images")
interface Images {
  @sharedRoute
  @route("edits")
  @post
  @summary("Creates an edited or extended image given one or more source images and a prompt. This endpoint supports GPT Image models (`gpt-image-1.5`, `gpt-image-1`, `gpt-image-1-mini`, and `chatgpt-image-latest`) and `dall-e-2`.")
  createImageEditMultipart is OpenAIOperation<
    {
      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateImageEditRequest;
    },
    OpenAI.ImagesResponse
  >;

  @sharedRoute
  @route("edits")
  @post
  @summary("Creates an edited or extended image given one or more source images and a prompt. This endpoint supports GPT Image models (`gpt-image-1.5`, `gpt-image-1`, `gpt-image-1-mini`, and `chatgpt-image-latest`) and `dall-e-2`.")
  createImageEditJson is OpenAIOperation<
    {
      @body
      body: OpenAI.EditImageBodyJsonParam;
    },
    OpenAI.ImagesResponse
  >;

  @route("generations")
  @post
  @summary("""
    Creates an image given a prompt. [Learn more](/docs/guides/images).
    
    """)
  createImage is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateImageRequest;
    },
    OpenAI.ImagesResponse
  >;

  @route("variations")
  @post
  @summary("Creates a variation of a given image. This endpoint only supports `dall-e-2`.")
  createImageVariation is OpenAIOperation<
    {
      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateImageVariationRequest;
    },
    OpenAI.ImagesResponse
  >;
}
