import "@typespec/rest";
import "@typespec/http";

import "./transcription.create.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.OpenAI;

@doc("Defines the format of the output.")
enum AudioTranscriptionFormat {
    @doc("JSON format. The translation/transcription response will only contain 'text'.")
    json: "json",

    @doc("Text format. The translation/transcription response will be of type text/plain.")
    text: "text",

    @doc("SRT format. The translation/transcription response will be of type text/plain.")
    srt: "srt",

    @doc("Verbose JSON format.The translation/transcription response will only contain additional information.")
    verbose_json: "verbose_json",

    @doc("VTT format. The translation/transcription response will be of type text/plain.")
    vtt: "vtt",
}

@doc("Transcription segment.")
model AudioTranscriptionSegment {
    @doc("Segment identifier.")
    id?: string;

    @doc("Segment start offset.")
    start?: int32;

    @doc("Segment end offset.")
    end?: int32;

    @doc("Segment text.")
    text?: string;

    @doc("Temperature.")
    temperature?: float32;

    @doc("Average log probability.")
    @projectedName("json", "avg_logprob")
    averageLogProb?: float32;

    @doc("Compression ratio.")
    @projectedName("json", "compression_ratio")
    compressionRatio?: float32;

    @doc("Probability of 'no speech'.")
    @projectedName("json", "no_speech_prob")
    noSpeechProb?: float32;
}
