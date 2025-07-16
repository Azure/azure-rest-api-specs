import "./common";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace VoiceLive;

@route("voicelive")
@tag("VoiceLive")
interface VoiceLive {
  @summary("Starts a real-time session for conversation or transcription.")
  startVoiceLiveSession(
    ...VoiceLiveBetaHeader,
    @body requestMessages: VoiceLiveClientEvent[],
  ): VoiceLiveServerEvent[];

  @post
  @route("sessions")
  @operationId("create-voicelive-session")
  @summary("""
    Create an ephemeral API token for use in client-side applications with the VoiceLive API. Can be configured with the same session parameters as the session.update client event.
    
    It responds with a session object, plus a client_secret key which contains a usable ephemeral API token that can be used to authenticate browser clients for the VoiceLive API.
    """)
  createEphemeralToken(
    @body request: VoiceLiveSessionCreateRequest,
  ): VoiceLiveSessionCreateResponse | ErrorResponse;


alias VoiceLiveBetaHeader = {
  @header("VoiceLive-Beta") voiceLiveBeta: "voicelive=v1";
};
