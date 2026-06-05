import "../common/models.tsp";
import "@typespec/http";
import "@azure-tools/openai-typespec/models/completions";
using TypeSpec.Http;
using OpenAI;
namespace Azure.AI.Projects;
@route("openai/v1/completions")
@tag("Completions")
interface Completions {
  @post
  @summary("""
    Creates a completion for the provided prompt and parameters.
    
    Returns a completion object, or a sequence of completion objects if the request is streamed.
    
    """)
  createCompletion is OpenAIOperation<
    {
      @body
      body: OpenAI.CreateCompletionRequest;
    },
    OpenAI.CreateCompletionResponse
  >;
}
