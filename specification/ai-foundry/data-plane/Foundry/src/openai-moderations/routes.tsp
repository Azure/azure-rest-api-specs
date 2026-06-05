import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/moderations";
using TypeSpec.Http;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/moderations")
@tag("Moderations")
interface Moderations {
  @post
  @summary("""
    Classifies if text and/or image inputs are potentially harmful. Learn
    more in the [moderation guide](/docs/guides/moderation).
    
    """)
  createModeration is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateModerationRequest;
    },
    OpenAI.CreateModerationResponse
  >;
}
