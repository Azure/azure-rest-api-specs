import "../openai-conversations/models.tsp";
import "../tools/models.tsp";

using Azure.Core.Experimental;
using TypeSpec.Http;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Experimental features applied to augment inherited OpenAI models"
namespace Azure.AI.Projects {
  @@changePropertyType(OpenAI.CreateResponse.`model`, string);
  @@changePropertyType(OpenAI.Response.`model`, string);

  // This is a temporary correction to the OpenAI source spec pending an upstream fix via overlay/origin.
  @@changePropertyType(OpenAI.MCPToolCall.error, Record<unknown>);

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

      /**
       * Optional session identifier for sandbox affinity. Currently only relevant for hosted agents.
       * When provided, the request is routed to the same sandbox. When omitted, auto-derived from
       * conversation_id/prev_response_id or a new UUID is generated.
       */
      @removed(Versions.v1)
      agent_session_id?: string,

      ...AzureCreateResponseOptions,
    }
  );

  // Any fields marked with `@removed` need to be placed directly under `@@copyProperties`
  /** Azure specific fields used in the creation of "Response" object (i.e. "AgentReference") */
  model AzureCreateResponseOptions {
    /** The agent to use for generating the response. */
    agent_reference?: AgentReference;

    /** The structured inputs to the response that can participate in prompt template substitution or tool argument bindings. */
    structured_inputs?: Record<unknown>;
  }

  @@copyProperties(OpenAI.Response,
    {
      /**
       * (Deprecated) Use agent_reference instead.
       * The agent used for this response
       */
      @removed(Versions.v1)
      agent?: AgentId,

      /**
       * The session identifier for this response. Currently only relevant for hosted agents.
       * Always returned for hosted agents — either the caller-provided value, the auto-derived value,
       * or an auto-generated UUID. Use for session-scoped operations and to maintain sandbox
       * affinity in follow-up calls.
       */
      @removed(Versions.v1)
      agent_session_id?: string,

      ...AzureCreateResponseDetails,
    }
  );

  // Any fields marked with `@removed` need to be placed directly under `@@copyProperties`
  /** Azure specific fields returned in a "Response" object */
  model AzureCreateResponseDetails {
    /** The agent used for this response */
    agent_reference: AgentReference | null;
  }

  @@withoutOmittedProperties(OpenAI.CodeInterpreterTool, "container");
  @@copyProperties(OpenAI.CodeInterpreterTool,
    {
      /** The code interpreter container. Can be a container ID or an object that
       * specifies uploaded file IDs to make available to your code, along with an
       * optional `memory_limit` setting.
       * If not provided, the service assumes auto.
       */
      #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Copying existing union type."
      container?: string | OpenAI.AutoCodeInterpreterToolParam,
    }
  );

  // See GitHub issue https://github.com/microsoft/openai-openapi-pr/issues/644
  @@summary(OpenAI.AutoCodeInterpreterToolParam,
    "Automatic Code Interpreter Tool Parameters"
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
    memory_search_call: "memory_search_call",
    workflow_action: "workflow_action",
    a2a_preview_call: "a2a_preview_call",
    a2a_preview_call_output: "a2a_preview_call_output",
    bing_grounding_call: "bing_grounding_call",
    bing_grounding_call_output: "bing_grounding_call_output",
    sharepoint_grounding_preview_call: "sharepoint_grounding_preview_call",
    sharepoint_grounding_preview_call_output: "sharepoint_grounding_preview_call_output",
    azure_ai_search_call: "azure_ai_search_call",
    azure_ai_search_call_output: "azure_ai_search_call_output",
    bing_custom_search_preview_call: "bing_custom_search_preview_call",
    bing_custom_search_preview_call_output: "bing_custom_search_preview_call_output",
    openapi_call: "openapi_call",
    openapi_call_output: "openapi_call_output",
    browser_automation_preview_call: "browser_automation_preview_call",
    browser_automation_preview_call_output: "browser_automation_preview_call_output",
    fabric_dataagent_preview_call: "fabric_dataagent_preview_call",
    fabric_dataagent_preview_call_output: "fabric_dataagent_preview_call_output",
    azure_function_call: "azure_function_call",
    azure_function_call_output: "azure_function_call_output",
  }

  @@copyVariants(OpenAI.ItemType, _AgentItemType);
  @@copyVariants(OpenAI.ItemResourceType, _AgentItemType);
  @@copyVariants(OpenAI.OutputItemType, _AgentItemType);

  /* created_by conflicts with the property in OpenAI.FunctionShellCall, ApplyPatchToolCall, and ApplyPatchToolCallOutput, to work around it we use a union type here */
  @@copyProperties(OpenAI.OutputItem,
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

  model StructuredOutputsOutputItem extends OpenAI.OutputItem {
    type: "structured_outputs";

    @doc("The structured output captured during the response.")
    output: unknown;
  }

  model WorkflowActionOutputItem extends OpenAI.OutputItem {
    type: "workflow_action";

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

  union ResponseObjectType {
    response: "response",
  }

  @doc("The result of a delete response operation.")
  model DeleteResponseResult {
    @doc("The operation ID.")
    id: string;

    @doc("Always return 'response'.")
    object: ResponseObjectType.response;

    @doc("Always return true")
    deleted: true;
  }

  @doc("Request from the service for the user to perform OAuth consent.")
  model OAuthConsentRequestOutputItem extends OpenAI.OutputItem {
    id: string;
    type: "oauth_consent_request";

    @doc("The link the user can use to perform OAuth consent.")
    consent_link: string;

    @doc("The server label for the OAuth consent request.")
    server_label: string;
  }

  // ── Content Filter and Guardrail Types ──────────────────

  @doc("A content filter result indicating severity level and whether content was filtered.")
  model AzureContentFilterSeverityResult {
    @doc("Whether the content was filtered.")
    filtered: boolean;

    @doc("The severity level of the content.")
    severity: AzureContentFilterSeverity;
  }

  @doc("Ratings for the intensity and risk level of harmful content.")
  union AzureContentFilterSeverity {
    string,

    @doc("Content appropriate for most audiences.")
    safe: "safe",

    @doc("Harmful content at a low intensity and risk level.")
    low: "low",

    @doc("Harmful content at a medium intensity and risk level.")
    medium: "medium",

    @doc("Harmful content at a high intensity and risk level.")
    high: "high",
  }

  @doc("A content filter result indicating whether the content was detected and filtered.")
  model AzureContentFilterDetectionResult {
    @doc("Whether the content was filtered.")
    filtered: boolean;

    @doc("Whether the content category was detected.")
    detected: boolean;
  }

  @doc("A content filter blocklist ID result.")
  model AzureContentFilterBlocklistIdResult {
    @doc("The ID of the custom blocklist.")
    id: string;

    @doc("Whether the blocklist resulted in filtering.")
    filtered: boolean;
  }

  @doc("A collection of filtering results for configured custom blocklists.")
  model AzureContentFilterBlocklistResult {
    @doc("Whether any blocklist resulted in filtering.")
    filtered: boolean;

    @doc("The pairs of individual blocklist IDs and their filtering results.")
    details?: AzureContentFilterBlocklistIdResult[];
  }

  @doc("A content filter detection result that includes a reason description.")
  model AzureContentFilterDetectionWithReasonResult {
    @doc("Whether the content was filtered.")
    filtered: boolean;

    @doc("Whether the content category was detected.")
    detected: boolean;

    @doc("A human-readable explanation of why the detection result was produced.")
    reason?: string;
  }

  @doc("A representation of a span of completion text as used by Azure OpenAI content filter results.")
  model AzureContentFilterCompletionTextSpan {
    @doc("Offset of the UTF32 code point which begins the span.")
    completion_start_offset: int32;

    @doc("Offset of the first UTF32 code point which is excluded from the span.")
    completion_end_offset: int32;
  }

  @doc("A content filter detection result with completion text span details.")
  model AzureContentFilterCompletionTextSpanDetectionResult {
    @doc("Whether the content was filtered.")
    filtered: boolean;

    @doc("Whether the content category was detected.")
    detected: boolean;

    @doc("Detailed information about the detected completion text spans.")
    details: AzureContentFilterCompletionTextSpan[];
  }

  @doc("A content filter detection result that includes citation information for protected material.")
  model AzureContentFilterDetectionWithCitationResult {
    @doc("Whether the content was filtered.")
    filtered: boolean;

    @doc("Whether the content category was detected.")
    detected: boolean;

    @doc("Citation details describing the associated license and its location.")
    citation?: AzureContentFilterCitation;
  }

  @doc("Citation details for protected material detection.")
  model AzureContentFilterCitation {
    @doc("The license associated with the detection.")
    license?: string;

    @doc("The URL associated with the license.")
    URL?: url;
  }

  @doc("Result details for an individual PII subcategory.")
  model AzureContentFilterPiiSubCategoryResult {
    @doc("The PII subcategory that was evaluated.")
    sub_category: string;

    @doc("Whether the content was filtered for this subcategory.")
    filtered: boolean;

    @doc("Whether the subcategory was detected in the content.")
    detected: boolean;
  }

  @doc("A content filter detection result for Personally Identifiable Information.")
  model AzureContentFilterPersonallyIdentifiableInformationResult {
    @doc("Whether the content was filtered.")
    filtered: boolean;

    @doc("Whether PII was detected in the content.")
    detected: boolean;

    @doc("Detailed results for individual PII subcategories.")
    sub_categories?: AzureContentFilterPiiSubCategoryResult[];
  }

  @doc("Content filter results for the Responses API.")
  model AzureContentFilterResultsForResponses {
    @doc("Severity result for sexual content.")
    sexual?: AzureContentFilterSeverityResult;

    @doc("Severity result for hate content.")
    hate?: AzureContentFilterSeverityResult;

    @doc("Severity result for violence content.")
    violence?: AzureContentFilterSeverityResult;

    @doc("Severity result for self-harm content.")
    self_harm?: AzureContentFilterSeverityResult;

    @doc("Detection result for profanity.")
    profanity?: AzureContentFilterDetectionResult;

    @doc("Results for configured custom blocklists.")
    custom_blocklists?: AzureContentFilterBlocklistResult;

    @doc("Detection result for jailbreak attempts.")
    jailbreak?: AzureContentFilterDetectionResult;

    @doc("Detection result for task adherence evaluation.")
    task_adherence?: AzureContentFilterDetectionWithReasonResult;

    @doc("Detection result for protected material text.")
    protected_material_text?: AzureContentFilterDetectionResult;

    @doc("Detection result for protected material code with citation.")
    protected_material_code?: AzureContentFilterDetectionWithCitationResult;

    @doc("Detection result for ungrounded material with completion text span details.")
    ungrounded_material?: AzureContentFilterCompletionTextSpanDetectionResult;

    @doc("Detection result for Personally Identifiable Information.")
    personally_identifiable_information?: AzureContentFilterPersonallyIdentifiableInformationResult;

    @doc("Detection result for indirect attacks.")
    indirect_attack?: AzureContentFilterDetectionResult;

    @doc("Error details if content filtering evaluation failed.")
    error?: AzureContentFilterError;
  }

  @doc("Error details from the content filtering system.")
  model AzureContentFilterError {
    @doc("A machine-readable error code.")
    code: int32;

    @doc("A human-readable error message.")
    message: string;
  }

  @doc("A content filter evaluation result for a specific source in the response.")
  model ContentFilterResult {
    @doc("Whether the content was blocked by the content filter.")
    blocked: boolean;

    @doc("The source type of the content filter evaluation (e.g., 'prompt', 'response', 'pre_tool_call', 'post_tool_call').")
    source_type: string;

    @doc("The content filter results for this evaluation.")
    content_filter_results: AzureContentFilterResultsForResponses;

    @doc("The ID of the tool call associated with this content filter result, if applicable.")
    tool_call_id?: string;
  }

  #suppress "@azure-tools/typespec-azure-core/experimental-feature" "Experimental features applied to augment inherited OpenAI models"
  @@copyProperties(OpenAI.Response,
    {
      /** The content filter evaluation results. */
      content_filters?: ContentFilterResult[],
    }
  );
}
