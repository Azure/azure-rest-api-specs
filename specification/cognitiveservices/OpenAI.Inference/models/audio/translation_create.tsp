import "@typespec/rest";
import "@typespec/http";

import "./commons.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.OpenAI;

@doc("Lorem ipsum")
model AudioTranslationOptionsSimpleJson {
    ...AudioTranscriptionOptionsCommon;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.simpleJson;
}

@doc("Lorem ipsum")
model AudioTranslationOptionsVerboseJson {
    ...AudioTranscriptionOptionsCommon;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.verboseJson;
}

@doc("Lorem ipsum")
model AudioTranslationOptionsPlainText {
    ...AudioTranscriptionOptionsCommon;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.text;
}

@doc("Lorem ipsum")
model AudioTranslationOptionsSrt {
    ...AudioTranscriptionOptionsCommon;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.srt;
}

@doc("Lorem ipsum")
model AudioTranslationOptionsVtt {
    ...AudioTranscriptionOptionsCommon;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.vtt;
}
