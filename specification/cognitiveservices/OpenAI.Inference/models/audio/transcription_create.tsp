import "@typespec/rest";
import "@typespec/http";

import "./commons.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.OpenAI;

@doc("Lorem ipsum")
model AudioTranscriptionOptions {
    ...AudioTranscriptionOptionsCommon;

    @doc("The language of the input audio. Supplying the input language in ISO-639-1 format will improve accuracy and latency.")
    language?: string;
}

@doc("Lorem ipsum")
model AudioTranscriptionOptionsSimpleJson {
    ...AudioTranscriptionOptions;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.simpleJson;
}

@doc("Lorem ipsum")
model AudioTranscriptionOptionsVerboseJson {
    ...AudioTranscriptionOptions;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.verboseJson;
}

@doc("Lorem ipsum")
model AudioTranscriptionOptionsPlainText {
    ...AudioTranscriptionOptions;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.text;
}

@doc("Lorem ipsum")
model AudioTranscriptionOptionsSrt {
    ...AudioTranscriptionOptions;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.srt;
}

@doc("Lorem ipsum")
model AudioTranscriptionOptionsVtt {
    ...AudioTranscriptionOptions;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.vtt;
}
