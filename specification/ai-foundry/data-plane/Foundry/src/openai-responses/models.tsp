import "@azure-tools/typespec-azure-core/experimental";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";

import "../openai-conversations/models.tsp";
import "../tools/models.tsp";

using Azure.Core.Experimental;
using TypeSpec.Http;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Experimental features applied to augment inherited OpenAI models"
namespace Azure.AI.Projects {
  @@changePropertyType(OpenAI.CreateResponse.`model`, string);
  @@changePropertyType(OpenAI.Response.`model`, string);

  @@doc(OpenAI.CreateResponse.`model`,
    "The model deployment to use for the creation of this response."
  );
  @@doc(OpenAI.Response.`model`,
    "The model deployment to use for the creation of this response."
  );

  @@copyProperties(OpenAI.CreateResponse,
    {
      /**
       * (Deprecated) Use agent_reference instead.
       *  The agent to use for generating the response.
       */
      @removed(Versions.v1)
      agent?: AgentReference,

      /** The agent to use for generating the response. */
      agent_reference?: AgentReference,

      /** The structured inputs to the response that can participate in prompt template substitution or tool argument bindings. */
      structured_inputs?: Record<unknown>,
    }
  );

  @@copyProperties(OpenAI.Response,
    {
      /**
       * (Deprecated) Use agent_reference instead.
       * The agent used for this response
       */
      @removed(Versions.v1)
      agent?: AgentId,

      /** The agent used for this response */
      agent_reference: AgentReference | null,
    }
  );

  @@withoutOmittedProperties(OpenAI.CodeInterpreterTool, "container");
  @@copyProperties(OpenAI.CodeInterpreterTool,
    {
      /** The code interpreter container. Can be a container ID or an object that
       * specifies uploaded file IDs to make available to your code, along with an
       * optional `memory_limit` setting.
       * If not provided, the service assumes auto.
       */
      #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Copying existing union type."
      container?: string | OpenAI.CodeInterpreterContainerAuto,
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

  model AgentReference {
    type: "agent_reference";

    @doc("The name of the agent.")
    @maxLength(256)
    name: string;

    @doc("The version identifier of the agent.")
    version?: string;
  }

  @removed(Versions.v1)
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
    oauth_consent_request: "oauth_consent_request",
    memory_search_preview_call: "memory_search_preview_call",
    workflow_preview_action: "workflow_preview_action",
  }

  @@copyVariants(OpenAI.ItemType, _AgentItemType);

  @@copyVariants(OpenAI.ItemResourceType, _AgentItemType);

  /* created_by conflicts with the property in OpenAI.FunctionShellCall, ApplyPatchToolCall, and ApplyPatchToolCallOutput, to work around it we use a union type here */
  @@copyProperties(OpenAI.ItemResource,
    {
      /** The information about the creator of the item */
      #suppress "@azure-tools/typespec-autorest/union-unsupported" "Temporary suppression to allow union type."
      #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "This is required due to a conflict with the service."
      @removed(Versions.v1)
      created_by?: CreatedBy | string,

      @doc("The agent that created the item.")
      agent_reference?: AgentReference,

      @doc("The response on which the item is created.")
      response_id?: string,
    }
  );

  @removed(Versions.v1)
  model CreatedBy {
    @doc("The agent that created the item.")
    agent?: AgentId;

    @doc("The response on which the item is created.")
    response_id?: string;
  }

  model StructuredOutputsItemResource extends OpenAI.ItemResource {
    type: "structured_outputs";

    @doc("The structured output captured during the response.")
    output: Record<unknown>;
  }

  model WorkflowPreviewActionOutputItemResource extends OpenAI.ItemResource {
    type: "workflow_preview_action";

    @doc("The kind of CSDL action (e.g., 'SetVariable', 'InvokeAzureAgent').")
    kind: string;

    @doc("Unique identifier for the action.")
    action_id: string;

    @doc("ID of the parent action if this is a nested action.")
    parent_action_id?: string;

    @doc("ID of the previous action if this action follows another.")
    previous_action_id?: string;

    #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
    @doc("Status of the action (e.g., 'in_progress', 'completed', 'failed', 'cancelled').")
    status: "completed" | "failed" | "in_progress" | "cancelled";
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
}
