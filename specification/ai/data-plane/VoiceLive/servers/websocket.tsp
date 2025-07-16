import "@typespec/http";
import "../models.tsp";
using TypeSpec.Http;

@service(#{
  title: "OpenAI API"
  
})
@server("wss://api.openai.com/v1", "OpenAI Endpoint")


@useAuth(BearerAuth)
namespace OpenAI;
op force_models(session: VoiceLiveClientEventSessionUpdate ): VoiceLiveServerEventSessionUpdated ;
