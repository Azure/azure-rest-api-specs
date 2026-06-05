import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/common";
import "@typespec/openapi";
import "@azure-tools/openai-typespec/models/video";
using TypeSpec.Http;
using OpenAI;
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@route("openai/v1/videos")
@tag("Videos")
interface VideoGeneration {
  @list
  @get
  @summary("List recently generated videos for the current project.")
  ListVideos is OpenAIOperation<
    {
      /** Number of items to retrieve */
      @minValue(0)
      @maxValue(100)
      @query(#{ explode: true })
      limit?: integer;

      /** Sort order of results by timestamp. Use `asc` for ascending order or `desc` for descending order. */
      @query(#{ explode: true })
      order?: OpenAI.OrderEnum;

      /** Identifier for the last item from the previous pagination request */
      @extension("x-ms-list-continuation-token", true)
      @continuationToken
      @query(#{ explode: true })
      after?: string;
    },
    OpenAI.VideoListResource
  >;

  @post
  @summary("Create a new video generation job from a prompt and optional reference assets.")
  createVideo is OpenAIOperation<
    {
      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateVideoMultipartBody;
    },
    OpenAI.VideoResource
  >;

  @route("characters")
  @post
  @summary("Create a character from an uploaded video.")
  CreateVideoCharacter is OpenAIOperation<
    {
      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateVideoCharacterBody;
    },
    OpenAI.VideoCharacterResource
  >;

  @route("characters/{character_id}")
  @get
  @summary("Fetch a character.")
  GetVideoCharacter is OpenAIOperation<
    {
      /** The identifier of the character to retrieve. */
      @path
      character_id: string;
    },
    OpenAI.VideoCharacterResource
  >;

  @sharedRoute
  @route("edits")
  @post
  @summary("Create a new video generation job by editing a source video or existing generated video.")
  CreateVideoEditMultipart is OpenAIOperation<
    {
      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateVideoEditMultipartBody;
    },
    OpenAI.VideoResource
  >;

  @sharedRoute
  @route("edits")
  @post
  @summary("Create a new video generation job by editing a source video or existing generated video.")
  CreateVideoEditJson is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateVideoEditJsonBody;
    },
    OpenAI.VideoResource
  >;

  @sharedRoute
  @route("extensions")
  @post
  @summary("Create an extension of a completed video.")
  CreateVideoExtendMultipart is OpenAIOperation<
    {
      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateVideoExtendMultipartBody;
    },
    OpenAI.VideoResource
  >;

  @sharedRoute
  @route("extensions")
  @post
  @summary("Create an extension of a completed video.")
  CreateVideoExtendJson is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateVideoExtendJsonBody;
    },
    OpenAI.VideoResource
  >;

  @route("{video_id}")
  @delete
  @summary("Permanently delete a completed or failed video and its stored assets.")
  DeleteVideo is OpenAIOperation<
    {
      /** The identifier of the video to delete. */
      @path
      video_id: string;
    },
    OpenAI.DeletedVideoResource
  >;

  @route("{video_id}")
  @get
  @summary("Fetch the latest metadata for a generated video.")
  GetVideo is OpenAIOperation<
    {
      /** The identifier of the video to retrieve. */
      @path
      video_id: string;
    },
    OpenAI.VideoResource
  >;

  @route("{video_id}/content")
  @get
  @summary("""
    Download the generated video bytes or a derived preview asset.
    
    Streams the rendered video content for the specified video job.
    """)
  RetrieveVideoContent is OpenAIOperation<
    {
      /** The identifier of the video whose media to download. */
      @path
      video_id: string;

      /** Which downloadable asset to return. Defaults to the MP4 video. */
      @query(#{ explode: true })
      variant?: OpenAI.VideoContentVariant;
    },
    {
      @header
      contentType: "video/mp4";

      @body
      body: bytes;
    }
  >;

  @route("{video_id}/remix")
  @post
  @summary("Create a remix of a completed video using a refreshed prompt.")
  CreateVideoRemix is OpenAIOperation<
    {
      /** The identifier of the completed video to remix. */
      @path
      video_id: string;

      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateVideoRemixBody;
    },
    OpenAI.VideoResource
  >;
}
