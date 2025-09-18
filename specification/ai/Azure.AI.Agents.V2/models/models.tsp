import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace OpenAI;
model DeleteModelResponse {
  id: string;
  deleted: boolean;
  object: string;
}

model ListModelsResponse {
  @extension("x-stainless-const", true)
  object: "list";

  data: Model[];
}

/** Describes an OpenAI model offering that can be used with the API. */
@summary("Model")
@extension(
  "x-oaiMeta",
  #{
    name: "The model object",
    example: "{\n  \"id\": \"VAR_chat_model_id\",\n  \"object\": \"model\",\n  \"created\": 1686935002,\n  \"owned_by\": \"openai\"\n}\n",
  }
)
model Model {
  /** The model identifier, which can be referenced in the API endpoints. */
  id: string;

  /** The Unix timestamp (in seconds) when the model was created. */
  created: integer;

  /** The object type, which is always "model". */
  @extension("x-stainless-const", true)
  object: "model";

  /** The organization that owns the model. */
  owned_by: string;
}
