import "@typespec/rest";
import "@typespec/http";

import "./commons.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.OpenAI;

@doc("""
Translation request.
Requesting format 'json' will result on only the 'text' field being set.
For more output data use 'verbose_json.
""")
model AudioTranslationOptions {
    @doc("The audio file to translate.")
    file: bytes;

    @doc("An optional text to guide the model's style or continue a previous audio segment. The prompt should be in English.")
    prompt?: string;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: "json" | "verbose_json" | "text" | "srt" | "vtt" = "json"; //AudioTranscriptionFormat = AudioTranscriptionFormat.json;

    @doc("""
    The sampling temperature, between 0 and 1.
    Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
    If set to 0, the model will use log probability to automatically increase the temperature until certain thresholds are hit.
    """)
    temperature?: float32 = 0;
}

@doc("TODO")
model AudioTranslationOptionsJsonSimple extends AudioTranslationOptions {
    @doc("TODO")
    responseFormat: "json";
}

@doc("TODO")
model AudioTranslationOptionsJsonVerbose extends AudioTranslationOptions {
    @doc("TODO")
    responseFormat: "verbose_json";
}
