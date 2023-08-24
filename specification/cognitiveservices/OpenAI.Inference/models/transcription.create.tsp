import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.OpenAI;

@doc("Transcription request.")
model TranscriptionsOptions {

    @doc("The audio file object to transcribe. Binary data.")
    // how do we handle binary format for a member?
    file: string;

    @doc("An optional text to guide the model's style or continue a previous audio segment. The prompt should match the audio language.")
    prompt?: string;

    @doc("The format of the transcription output, in one of these options: json, text, srt, verbose_json, or vtt.")
    @projectedName("json", "response_format")
    responseFormat?: TranscriptionFormat = TranscriptionFormat.json;

    @doc("The sampling temperature, between 0 and 1. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. If set to 0, the model will use log probability to automatically increase the temperature until certain thresholds are hit.")
    temperature?: float32 = 0;

    @doc("The language of the input audio. Supplying the input language in ISO-639-1 format will improve accuracy and latency.")
    language?: string;
}

@doc("Transcription format.")
enum TranscriptionFormat {

    @doc("JSON format.")
    json : "json";

    @doc("Text format.")
    text : "text";

    @doc("SRT format.")
    srt : "srt";

    @doc("Verbose JSON format.")
    verbose_json : "verbose_json";

    @doc("VTT format.")
    vtt : "vtt";
}

@doc("Transcription response.")
model Transcription {
    @doc("Transcription task.")
    task: string;

    @doc("Transcribed text.")
    text: string;

    @doc("Language.")
    language: string;

    @doc("Duration.")
    duration: uint32;

    @doc("Segments.")
    segments: TranscriptionSegment[];
}

@doc("Transcription segment.")
model TranscriptionSegment {
    @doc("Segment identifier.")
    id: string;

    @doc("Segment start offset.")
    start: int32;

    @doc("Segment end offset.")
    end: int32;

    @doc("Segment text.")
    text: string;

    @doc("Temperature.")
    temperature: float32;

    @doc("Average log probability.")
    @projectedName("json", "avg_logprob")
    averageLogProb: float32;

    @doc("Compression ratio.")
    @projectedName("json", "compression_ratio")
    compressionRatio: float32;

    @doc("Probability of 'no speech'.")
    @projectedName("json", "no_speech_prob")
    noSpeechProb: float32;
}
