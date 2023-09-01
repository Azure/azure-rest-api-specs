import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.OpenAI;

//TODO remove-me: this is so that I can focus on a single route for now
alias AudioTranscription = AudioTranscriptionJsonVerbose;

@doc("Transcription response.")
model AudioTranscriptionJsonVerbose {
    @doc("Audio transcription task.")
    task?: AudioTranscriptionTask;

    @doc("Transcribed text.")
    text: string;

    @doc("Language detected in the source audio file.")
    language?: string;

    @doc("Duration.")
    @encode("seconds", float32)
    duration?: duration;

    @doc("Segments.")
    segments?: AudioTranscriptionSegment[];
}

@doc("Transcription response.")
model AudioTranscriptionJsonSimple {
    @doc("Transcribed text.")
    text: string;
}

@doc("Audio transcription task type")
enum AudioTranscriptionTask {
    @doc("Value for a transcription task")
    transcribe: "transcribe",

    @doc("Value for a translation task")
    translate: "translate",
}

// models extending with hardcoded values do not seem to accept an enum, just a string
// @doc("Defines the format of the output.")
// enum AudioTranscriptionFormat {
//     @doc("JSON format. The translation/transcription response will only contain 'text'.")
//     json: "json",

//     @doc("Text format. The translation/transcription response will be of type text/plain.")
//     text: "text",

//     @doc("SRT format. The translation/transcription response will be of type text/plain.")
//     srt: "srt",

//     @doc("Verbose JSON format.The translation/transcription response will contain additional information.")
//     verbose_json: "verbose_json",

//     @doc("VTT format. The translation/transcription response will be of type text/plain.")
//     vtt: "vtt",
// }

@doc("Transcription segment.")
model AudioTranscriptionSegment {
    @doc("Segment identifier.")
    id?: int32;

    @doc("Segment start offset.")
    start?: float32;

    @doc("Segment end offset.")
    end?: float32;

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

    @doc("Tokens in this segment")
    tokens: int32[];

    @doc("TODO")
    seek: int32;
}
