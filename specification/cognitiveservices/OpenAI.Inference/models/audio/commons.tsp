import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.OpenAI;

@doc("Defines the format of the output.")
enum AudioTranscriptionFormat {
    @doc("Lorem ipsum")
    simpleJson: "json",

    @doc("Lorem ipsum")
    text: "text",

    @doc("Lorem ipsum")
    srt: "srt",

    @doc("Lorem ipsum")
    verboseJson: "verbose_json",

    @doc("Lorem ipsum")
    vtt: "vtt",
}

@doc("""
Transcription request.
Requesting format 'json' will result on only the 'text' field being set.
For more output data use 'verbose_json.
""")
model AudioTranscriptionOptionsCommon {
    @doc("The audio file object to transcribe.")
    file: bytes;

    @doc("An optional text to guide the model's style or continue a previous audio segment. The prompt should match the audio language.")
    prompt?: string;

    @doc("""
    The sampling temperature, between 0 and 1.
    Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
    If set to 0, the model will use log probability to automatically increase the temperature until certain thresholds are hit.
    """)
    temperature?: float32 = 0;
}

@doc("Lorem ipsum")
model AudioTranscriptionSimpleJson {
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

@doc("Transcription segment.")
model AudioTranscriptionSegment {
    @doc("Segment identifier.")
    id: int32;

    @doc("Segment start offset.")
    start: float32;

    @doc("Segment end offset.")
    end: float32;

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

    @doc("Tokens in this segment")
    tokens: int32[];

    @doc("TODO")
    seek: int32;
}

@doc("Transcription response.")
model AudioTranscriptionVerboseJson extends AudioTranscriptionSimpleJson {
    @doc("Audio transcription task.")
    task: AudioTranscriptionTask;

    @doc("Language detected in the source audio file.")
    language: string;

    @doc("Duration.")
    @encode("seconds", float32)
    duration: duration;

    @doc("Segments.")
    segments: AudioTranscriptionSegment[];
}
