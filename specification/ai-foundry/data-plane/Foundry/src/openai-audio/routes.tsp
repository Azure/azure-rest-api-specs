import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/audio";
using TypeSpec.Http;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/audio")
@tag("Audio")
interface Audio {
  @route("speech")
  @post
  @summary("""
    Generates audio from the input text.
    
    Returns the audio file content, or a stream of audio events.
    
    """)
  createSpeech is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateSpeechRequest;
    },
    {
      @header("Transfer-Encoding")
      TransferEncoding?: string;

      @header
      contentType: "application/octet-stream";

      @body
      body: bytes;
    }
  >;

  @route("transcriptions")
  @post
  @summary("""
    Transcribes audio into the input language.
    
    Returns a transcription object in `json`, `diarized_json`, or `verbose_json`
    format, or a stream of transcript events.
    
    """)
  createTranscription is OpenAIOperation<
    {
      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateTranscriptionRequest;
    },
    TypeSpec.Http.Body<
      | OpenAI.CreateTranscriptionResponseJson
      | OpenAI.CreateTranscriptionResponseDiarizedJson
      | OpenAI.CreateTranscriptionResponseVerboseJson>
  >;

  @route("translations")
  @post
  @summary("Translates audio into English.")
  createTranslation is OpenAIOperation<
    {
      @header
      contentType: "multipart/form-data";

      @multipartBody
      body: OpenAI.CreateTranslationRequest;
    },
    TypeSpec.Http.Body<
      | OpenAI.CreateTranslationResponseJson
      | OpenAI.CreateTranslationResponseVerboseJson>
  >;
}
