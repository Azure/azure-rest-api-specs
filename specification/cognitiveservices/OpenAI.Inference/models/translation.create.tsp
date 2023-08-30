import "@typespec/rest";
import "@typespec/http";

import "./transcription.create.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.OpenAI;

@doc("Translation request.")
model AudioTranslationOptions {
    @doc("The audio file to translate.")
    // how do we handle binary format for a member?
    file: string;

    @doc("An optional text to guide the model's style or continue a previous audio segment. The prompt should be in English.")
    prompt?: string;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.json;

    @doc("""
    The sampling temperature, between 0 and 1.
    Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
    If set to 0, the model will use log probability to automatically increase the temperature until certain thresholds are hit.
    """)
    temperature?: float32 = 0;
}

@doc("Translation response.")
model AudioTranslation {
    @doc("Translation task.")
    task?: string;

    @doc("Translated text.")
    text: string;

    @doc("Language.")
    language?: string;

    @doc("Duration.")
    duration?: duration;

    @doc("Transcription segments.")
    segments?: AudioTranscriptionSegment[];
}
