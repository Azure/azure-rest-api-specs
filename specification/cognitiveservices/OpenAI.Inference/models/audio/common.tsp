import "@typespec/versioning";
import "@typespec/http";

namespace Azure.OpenAI;

using TypeSpec.Http;
using TypeSpec.Versioning;

@doc("Defines the possible descriptors for available audio operation responses.")
@added(ServiceApiVersions.v2024_02_15_Preview)
union AudioTaskLabel {
  string,

  @doc("Accompanying response data resulted from an audio transcription task.")
  transcribe: "transcribe",

  @doc("Accompanying response data resulted from an audio translation task.")
  translate: "translate",
}

alias AudioTextResponse = {
  @doc("Representation of the response data of audio text.")
  @body
  body: string;
};
