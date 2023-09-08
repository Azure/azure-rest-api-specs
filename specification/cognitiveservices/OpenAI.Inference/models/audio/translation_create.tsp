import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

import "./commons.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.OpenAI;

@doc("This format will return an JSON structure containing a single \"text\" with the translation.")
@added(ServiceApiVersions.v2023_09_01_Preview)
model AudioTranslationOptionsSimpleJson {
    ...AudioTranscriptionOptionsCommon;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.simpleJson;
}

@doc("This format will return an JSON structure containing an enriched structure with the translation.")
@added(ServiceApiVersions.v2023_09_01_Preview)
model AudioTranslationOptionsVerboseJson {
    ...AudioTranscriptionOptionsCommon;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.verboseJson;
}

@doc("This will make the response return the translation as plain/text.")
@added(ServiceApiVersions.v2023_09_01_Preview)
model AudioTranslationOptionsPlainText {
    ...AudioTranscriptionOptionsCommon;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.text;
}

@doc("The translation will be provided in SRT format (SubRip Text) in the form of plain/text.")
@added(ServiceApiVersions.v2023_09_01_Preview)
model AudioTranslationOptionsSrt {
    ...AudioTranscriptionOptionsCommon;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.srt;
}

@doc("The translation will be provided in VTT format (Web Video Text Tracks) in the form of plain/text.")
@added(ServiceApiVersions.v2023_09_01_Preview)
model AudioTranslationOptionsVtt {
    ...AudioTranscriptionOptionsCommon;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: AudioTranscriptionFormat = AudioTranscriptionFormat.vtt;
}
