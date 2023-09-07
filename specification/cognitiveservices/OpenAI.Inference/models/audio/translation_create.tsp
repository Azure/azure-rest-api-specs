import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./commons.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.OpenAI;

@doc("Lorem ipsum")
@added(ServiceApiVersions.v2023_09_01_Preview)
model AudioTranslationOptionsSimpleJson {
    ...AudioTranscriptionOptionsCommon;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.simpleJson;
}

@doc("Lorem ipsum")
@added(ServiceApiVersions.v2023_09_01_Preview)
model AudioTranslationOptionsVerboseJson {
    ...AudioTranscriptionOptionsCommon;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.verboseJson;
}

@doc("Lorem ipsum")
@added(ServiceApiVersions.v2023_09_01_Preview)
model AudioTranslationOptionsPlainText {
    ...AudioTranscriptionOptionsCommon;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.text;
}

@doc("Lorem ipsum")
@added(ServiceApiVersions.v2023_09_01_Preview)
model AudioTranslationOptionsSrt {
    ...AudioTranscriptionOptionsCommon;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.srt;
}

@doc("Lorem ipsum")
@added(ServiceApiVersions.v2023_09_01_Preview)
model AudioTranslationOptionsVtt {
    ...AudioTranscriptionOptionsCommon;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.vtt;
}
