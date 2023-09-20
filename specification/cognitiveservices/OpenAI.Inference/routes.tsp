import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./models/completions.create.tsp";
import "./models/chat.completions.tsp";
import "./models/embeddings.create.tsp";
import "./models/images.tsp";
import "./models/audio.transcription.tsp";
import "./models/audio.translation.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

using Azure.Core;

namespace Azure.OpenAI;

@doc("Return the embeddings for a given prompt.")
@actionSeparator("/")
@action("embeddings") //@convenientAPI(true)
op getEmbeddings is Azure.Core.ResourceAction<
  Deployment,
  EmbeddingsOptions,
  Embeddings
>;

@doc("""
Gets completions for the provided input prompts.
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data.
""")
@actionSeparator("/")
@action("completions") //@convenientAPI(true)
op getCompletions is Azure.Core.ResourceAction<
  Deployment,
  CompletionsOptions,
  Completions
>;

@doc("""
Gets chat completions for the provided chat messages.
Completions support a wide variety of tasks and generate text that continues from or "completes"
provided prompt data.
""")
@added(ServiceApiVersions.v2023_05_15)
@actionSeparator("/")
@action("chat/completions") //@convenientAPI(true)
op getChatCompletions is ResourceAction<
  Deployment,
  ChatCompletionsOptions,
  ChatCompletions
>;

@doc("""
Gets chat completions for the provided chat messages.
This is an Azure-specific version of chat completions that supports integration with configured data sources and
other augmentations to the base chat completions capabilities.
""")
// Note: client libraries should abstract the existence of this as a distinct REST route and instead perform dynamic
//        selection of the appropriate request URL structure based on the presence or non-presence of matching
//        chat extensions configuration in the request options model. Future service API versions may merge this
//        capability into the standard /chat/completions route.
@added(ServiceApiVersions.v2023_08_01_Preview)
@actionSeparator("/")
@action("extensions/chat/completions")
op getChatCompletionsWithAzureExtensions is ResourceAction<
  Deployment,
  ChatCompletionsOptions,
  ChatCompletions
>;

// Note: pending resolution of  cross-language code emission behavior for long-running operations, image generation
//        reuses its final operation response model as its status polling model.
#suppress "@azure-tools/typespec-azure-core/rpc-operation-request-body" "MUST fix in next update"
#suppress "@azure-tools/typespec-azure-core/no-rpc-path-params" "Allowed because this is a non-standard status polling operation."
@doc("Returns the status of the images operation")
@added(ServiceApiVersions.v2023_06_01_Preview)
@route("/operations/images/{operationId}")
op getAzureBatchImageGenerationOperationStatus is RpcOperation<
  {
    @doc(".") @path operationId: string;
  },
  BatchImageGenerationOperationResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@doc("Starts the generation of a batch of images from a text caption")
@added(ServiceApiVersions.v2023_06_01_Preview)
@route("/images/generations:submit")
@pollingOperation(
  getAzureBatchImageGenerationOperationStatus,
  {
    operationId: ResponseProperty<"id">,
  }
)
op beginAzureBatchImageGeneration is OaiLongRunningRpcOperation<
  ImageGenerationOptions,
  BatchImageGenerationOperationResponse,
  BatchImageGenerationOperationResponse
>;

// Audio implementation note: depending on the response_format provided in operation request bodies, these operations
// may respond with a response body that's either a JSON object or a text/plain string. Pending more precise
// specification of the relationship between the input format selection and resulting output response format, the two
// content-type-specific options are provided for each operation with no delineation between the matching request body
// requirements. These content-type-specific operations should be hidden by clients and combined into single operations
// that share common characteristics whenever possible.

alias MultipartFormDataRequestHeadersTraits = Azure.Core.Traits.RequestHeadersTrait<{
  @doc("The content type for the operation. Always multipart/form-data for this operation.")
  @header("content-type")
  contentType: "multipart/form-data";
}>;

#suppress "@azure-tools/typespec-azure-core/byos" "representation of existing multipart/form-data operation"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "non-model response value needed"
@doc("""
Gets transcribed text and associated metadata from provided spoken audio data. Audio will be transcribed in the
written language corresponding to the language it was spoken in.
""")
@added(ServiceApiVersions.v2023_09_01_Preview)
@actionSeparator("/")
@action("audio/transcriptions")
@sharedRoute
op getAudioTranscriptionAsPlainText is Azure.Core.Foundations.ResourceOperation<
  Deployment,
  AudioTranscriptionOptions,  // response_format must be one of: text, srt, vtt
  string,
  MultipartFormDataRequestHeadersTraits
>;

#suppress "@azure-tools/typespec-azure-core/byos" "representation of existing multipart/form-data operation"
@doc("""
Gets transcribed text and associated metadata from provided spoken audio data. Audio will be transcribed in the
written language corresponding to the language it was spoken in.
""")
@added(ServiceApiVersions.v2023_09_01_Preview)
@actionSeparator("/")
@action("audio/transcriptions")
@sharedRoute
op getAudioTranscriptionAsResponseObject is Azure.Core.ResourceAction<
  Deployment,
  AudioTranscriptionOptions,  // response_format must be unspecified (json) or one of: json, verbose_json
  AudioTranscription,
  MultipartFormDataRequestHeadersTraits
>;

#suppress "@azure-tools/typespec-azure-core/byos" "representation of existing multipart/form-data operation"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "non-model response value needed"
@doc("""
Gets English language transcribed text and associated metadata from provided spoken audio data.
""")
@added(ServiceApiVersions.v2023_09_01_Preview)
@actionSeparator("/")
@action("audio/translations")
@sharedRoute
op getAudioTranslationAsPlainText is Azure.Core.Foundations.ResourceOperation<
  Deployment,
  AudioTranslationOptions,  // response_format must be one of: text, srt, vtt
  string,
  MultipartFormDataRequestHeadersTraits
>;

#suppress "@azure-tools/typespec-azure-core/byos" "representation of existing multipart/form-data operation"
@doc("""
Gets English language transcribed text and associated metadata from provided spoken audio data.
""")
@added(ServiceApiVersions.v2023_09_01_Preview)
@actionSeparator("/")
@action("audio/translations")
@sharedRoute
op getAudioTranslationAsResponseObject is Azure.Core.ResourceAction<
  Deployment,
  AudioTranslationOptions,  // response_format must be unspecified (json) or one of: json, verbose_json
  AudioTranslation,
  MultipartFormDataRequestHeadersTraits
>;
