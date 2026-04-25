import "./main.tsp";
import "@typespec/json-schema";

using TypeSpec.JsonSchema;

namespace Azure.AI.Projects {
  // Wrapper models for conversations to match C# contract names
  @jsonSchema
  model CreateConversationBody is OpenAI.CreateConversationBody;

  @jsonSchema
  model UpdateConversationRequest is OpenAI.UpdateConversationBody;

  @@jsonSchema(CreateConversationItemsRequest);

  // JSON Schema decorators for request body models
  // Agent request models
  @@jsonSchema(CreateAgentRequest);
  @@jsonSchema(CreateAgentVersionRequest);
  @@jsonSchema(UpdateAgentRequest);
  @@jsonSchema(CreateAgentFromManifestRequest);
  @@jsonSchema(CreateAgentVersionFromManifestRequest);
  @@jsonSchema(UpdateAgentFromManifestRequest);

  // Response request models
  @@jsonSchema(OpenAI.CreateResponse);
  @@jsonSchema(OpenAI.CompactResponseMethodPublicBody);
}
