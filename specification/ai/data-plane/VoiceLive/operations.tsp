import "./common";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace VoiceLive;

alias VoiceLiveBetaHeader = {
  @header("VoiceLive-Beta") voiceLiveBeta: "voicelive=v1";
};
