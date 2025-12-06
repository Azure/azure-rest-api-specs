import "../.external-readonly/azure.openai.v1.typespec/models/responses.tsp";
import "../conversations/models.tsp";
import "../tools/models.tsp";
import "azure-ai-decorators";

import "@typespec/http";
import "@typespec/openapi";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.AI.Decorators;

namespace Azure.AI.Projects;

@@extendModel(OpenAI.CreateResponse,
  {
    /** The agent to use for generating the response. */
    agent?: AgentReference,

    /** The structured inputs to the response that can participate in prompt template substitution or tool argument bindings. */
    structured_inputs?: Record<unknown>,
  }
);

@@extendModel(OpenAI.Response,
  {
    /** The agent used for this response */
    agent?: AgentId,

    /** The structured inputs to the response that can participate in prompt template substitution or tool argument bindings. */
    structured_inputs?: Record<unknown>,
  }
);

alias AgentNameQueryParam = {
  @query
  @doc("Filter by agent name. If provided, only items associated with the specified agent will be returned.")
  agent_name?: string;
};

alias AgentIdQueryParam = {
  @query
  @doc("Filter by agent ID in the format `name:version`. If provided, only items associated with the specified agent ID will be returned.")
  agent_id?: string;
};

alias ConversationIdQueryParam = {
  @query
  @doc("Filter by conversation ID. If provided, only responses associated with the specified conversation will be returned.")
  conversation_id?: string;
};

model ResponseList {
  @doc("""
    The type of object returned, must be `list`.
    """)
  object: "list";

  /** A list of items used to generate this response. */
  data: OpenAI.Response[];

  /** Whether there are more items available. */
  has_more: boolean;

  /** The ID of the first item in the list. */
  first_id: string;

  /** The ID of the last item in the list. */
  last_id: string;
}

model AgentReference {
  type: "agent_reference";

  @doc("The name of the agent.")
  @maxLength(256)
  name: string;

  @doc("The version identifier of the agent.")
  version?: string;
}

model AgentId {
  type: "agent_id";

  @doc("The name of the agent.")
  @maxLength(256)
  name: string;

  @doc("The version identifier of the agent.")
  version: string;
}

// We add to OpenAI's existing Response Item types.
// Pending investigation of reintegrating a direct type-change decorator,
// this process has a few steps in TypeSpec:
//  1. Define an extended union for the extended set of discriminator label values
//  2. Define extended base types using the new extended discriminator
//  3. Replace references to pre-extension base types with extended base types

union _AgentItemType {
  structured_outputs: "structured_outputs",
  workflow_action: "workflow_action",
  memory_search_call: "memory_search_call",
  oauth_consent_request: "oauth_consent_request",
}

@@copyVariants(OpenAI.ItemType, _AgentItemType);

@@extendModel(OpenAI.ItemResource,
  {
    /** The information about the creator of the item */
    created_by?: CreatedBy,
  }
);

model CreatedBy {
  @doc("The agent that created the item.")
  agent?: AgentId;

  @doc("The response on which the item is created.")
  response_id?: string;
}

model StructuredOutputsItemResource extends OpenAI.ItemResource {
  type: "structured_outputs";

  @doc("The structured output captured during the response.")
  output: unknown;
}

@discriminator("kind")
model WorkflowActionOutputItemResource extends OpenAI.ItemResource {
  type: "workflow_action";

  @doc("The kind of CSDL action (e.g., 'SetVariable', 'InvokeAzureAgent').")
  kind: string;

  @doc("Unique identifier for the action.")
  action_id: string;

  @doc("ID of the parent action if this is a nested action.")
  parent_action_id?: string;

  @doc("ID of the previous action if this action follows another.")
  previous_action_id?: string;

  @doc("Status of the action (e.g., 'in_progress', 'completed', 'failed', 'cancelled').")
  status: "completed" | "failed" | "in_progress" | "cancelled";
}

@doc("Details about an agent invocation as part of a workflow action.")
model InvokeAzureAgentWorkflowActionOutputItemResource
  extends WorkflowActionOutputItemResource {
  kind: "InvokeAzureAgent";

  @doc("Agent id.")
  agent: AgentId;

  @doc("ID of the conversation for the agent invocation.")
  conversation_id?: string;

  @doc("The response id for the agent invocation.")
  response_id: string;
}

@doc("The result of a delete response operation.")
model DeleteResponseResult {
  @doc("The operation ID.")
  id: string;

  @doc("Always return 'response'.")
  object: "response";

  @doc("Always return true")
  deleted: true;
}

@doc("Request from the service for the user to perform OAuth consent.")
model OAuthConsentRequestItemResource extends OpenAI.ItemResource {
  id: string;
  type: "oauth_consent_request";

  @doc("The link the user can use to perform OAuth consent.")
  consent_link: string;

  @doc("The server label for the OAuth consent request.")
  server_label: string;
}
