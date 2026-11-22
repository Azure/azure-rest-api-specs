using TypeSpec.OpenAPI;

namespace Azure.AI.Projects.ManagedAgents;

/** Common history discriminator. Individual variants retain their own required fields and nullability. */
model SessionItemBase {
  /** The variant discriminator. */
  type: string;
}

/** Common output discriminator, separate from history-only messages and callback records. */
model SessionOutputItemBase {
  /** The variant discriminator. */
  type: string;
}

/** Common discriminator for credential-free browser approval history. */
model SessionBrowserAuthenticationHistoryResponseBase {
  /** The variant discriminator. */
  action: string;
}

/** Common discriminator for typed web-search actions. */
model SessionWebSearchActionBase {
  /** The variant discriminator. */
  type: string;
}

/** All saved OpenAI Session item variants plus Foundry tool and MCP approval records. Includes all six subagent coordination calls and history-only agent_message; item.turn_id identifies the containing turn, not the target child's turn. */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
@extension("x-ms-foundry-meta", ManagedAgentsRequiredPreviews)
union SessionItem extends SessionItemBase {
  message: SessionMessageItem,
  reasoning: SessionReasoningItem,
  function_call: SessionFunctionCallItem,
  function_call_output: SessionFunctionCallOutputItem,
  agent_message: SessionAgentMessageItem,
  mcp_call: SessionMcpCallItem,
  computer_use_call: SessionComputerUseCallItem,
  computer_use_approval_request: SessionComputerUseApprovalRequestItem,
  computer_use_approval_request_result: SessionComputerUseApprovalResponseItem,
  web_search_call: SessionWebSearchCallItem,
  command_execution: SessionCommandExecutionItem,
  create_subagent_call: SessionCreateSubagentCallItem,
  send_subagent_input_call: SessionSendSubagentInputCallItem,
  resume_subagent_call: SessionResumeSubagentCallItem,
  wait_for_subagents_call: SessionWaitForSubagentsCallItem,
  interrupt_subagent_call: SessionInterruptSubagentCallItem,
  close_subagent_call: SessionCloseSubagentCallItem,
  tool_call: SessionToolCallItem,
  tool_result: SessionToolResultItem,
  mcp_approval_request: SessionMcpApprovalRequestItem,
  mcp_approval_response: SessionMcpApprovalResponseItem,
}

/** Preserves the OpenAI message history item, including optional provider fields. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionMessageItem extends SessionItemBase {
  ...OmitProperties<OpenAI.MessageItemResource, "id" | "phase" | "type">;

  /** The variant discriminator. */
  type: "message";

  ...OptionalProperties<PickProperties<
    OpenAI.MessageItemResource,
    "id" | "phase"
  >>;
}

/** Preserves the OpenAI reasoning history item, including optional provider fields. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
@example(#{
  type: "reasoning",
  id: "item_reasoning",
  turn_id: "turn_1",
  summary: #[#{ type: "summary_text", text: "Summary" }],
  status: null,
})
model SessionReasoningItem extends SessionItemBase {
  ...OmitProperties<OpenAI.ReasoningItemResource, "status">;
  ...OptionalProperties<PickProperties<OpenAI.ReasoningItemResource, "status">>;
}

/** Preserves the OpenAI function_call history item, including optional provider fields. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionFunctionCallItem extends SessionItemBase {
  ...OpenAI.FunctionCallItemResource;
}

/** Preserves the OpenAI function_call_output history item, including optional provider fields. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionFunctionCallOutputItem extends SessionItemBase {
  ...OmitProperties<
    OpenAI.FunctionCallOutputItemResource,
    "output" | "error" | "type"
  >;

  /** The variant discriminator. */
  type: "function_call_output";

  ...OptionalProperties<PickProperties<
    OpenAI.FunctionCallOutputItemResource,
    "output" | "error"
  >>;
}

/** An interagent message in saved history or item.added events. Sender and recipient are runtime agent IDs; this record has no status and is not an item.done output variant. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
@example(#{
  type: "agent_message",
  id: "item_child_message",
  turn_id: "turn_root",
  sender_agent_id: "subagent_1",
  recipient_agent_id: "provider_root",
  content: #[],
})
model SessionAgentMessageItem extends SessionItemBase {
  ...OmitProperties<OpenAI.AgentMessageItemResource, "type">;

  /** The variant discriminator. */
  type: "agent_message";
}

/** Preserves the OpenAI mcp_call history item, including optional provider fields. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionMcpCallItem extends SessionItemBase {
  ...OpenAI.McpCallItemResource;
}

/** Preserves the OpenAI computer_use_call history item, including optional provider fields. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionComputerUseCallItem extends SessionItemBase {
  ...OmitProperties<OpenAI.ComputerUseCallItemResource, "title" | "output">;
  ...OptionalProperties<PickProperties<
    OpenAI.ComputerUseCallItemResource,
    "title" | "output"
  >>;
}

/** Preserves the OpenAI computer_use_approval_request history item, including optional provider fields. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionComputerUseApprovalRequestItem extends SessionItemBase {
  ...OmitProperties<OpenAI.BrowserAuthenticationRequestItemResource, "request">;

  /** Credential-free browser request, including form descriptors and options. */
  request: SessionBrowserAuthenticationContent;
}

/** Preserves the OpenAI computer_use_approval_request_result history item, including optional provider fields. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionComputerUseApprovalResponseItem extends SessionItemBase {
  ...OmitProperties<
    OpenAI.ComputerUseApprovalRequestResultItemResource,
    "response" | "type"
  >;

  /** The variant discriminator. */
  type: "computer_use_approval_request_result";

  /** Admitted decision without submitted credential values. */
  response: SessionBrowserAuthenticationHistoryResponse;
}

/** Preserves the OpenAI web_search_call history item, including optional provider fields. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionWebSearchCallItem extends SessionItemBase {
  ...OmitProperties<OpenAI.WebSearchCallItemResource, "action">;

  /** The typed search, open-page, find, or other action, when recorded. */
  action?: SessionWebSearchAction | null;
}

/** Preserves the OpenAI command_execution history item, including optional provider fields. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionCommandExecutionItem extends SessionItemBase {
  ...OmitProperties<
    OpenAI.CommandExecutionItemResource,
    "cwd" | "duration_ms" | "exit_code" | "output"
  >;
  ...OptionalProperties<PickProperties<
    OpenAI.CommandExecutionItemResource,
    "cwd" | "duration_ms" | "exit_code" | "output"
  >>;
}

/** A harness-issued delegation call. agent_id identifies the requesting agent, not the newly created child; lifecycle events supply the child ID and parent relationship. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionCreateSubagentCallItem extends SessionItemBase {
  ...OmitProperties<
    OpenAI.CreateSubagentCallItemResource,
    "model" | "reasoning_effort"
  >;
  ...OptionalProperties<PickProperties<
    OpenAI.CreateSubagentCallItemResource,
    "model" | "reasoning_effort"
  >>;
}

/** Preserves the OpenAI send_subagent_input_call history item, including optional provider fields. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionSendSubagentInputCallItem extends SessionItemBase {
  ...OpenAI.SendSubagentInputCallItemResource;
}

/** Preserves the OpenAI resume_subagent_call history item, including optional provider fields. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionResumeSubagentCallItem extends SessionItemBase {
  ...OpenAI.ResumeSubagentCallItemResource;
}

/** Preserves the OpenAI wait_for_subagents_call history item, including optional provider fields. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionWaitForSubagentsCallItem extends SessionItemBase {
  ...OpenAI.WaitForSubagentsCallItemResource;
}

/** Preserves the OpenAI interrupt_subagent_call history item, including optional provider fields. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionInterruptSubagentCallItem extends SessionItemBase {
  ...OpenAI.InterruptSubagentCallItemResource;
}

/** Preserves the OpenAI close_subagent_call history item, including optional provider fields. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionCloseSubagentCallItem extends SessionItemBase {
  ...OpenAI.CloseSubagentCallItemResource;
}

/** Credential-free browser authentication request; nullable optional fields may be absent. */
model SessionBrowserAuthenticationContent {
  ...OmitProperties<
    OpenAI.BrowserAuthenticationHistoryRequestKindResourceBrowserAuthentication,
    "credential_origin" | "reason"
  >;
  ...OptionalProperties<PickProperties<
    OpenAI.BrowserAuthenticationHistoryRequestKindResourceBrowserAuthentication,
    "credential_origin" | "reason"
  >>;
}

/** Credential-free submit or cancel history, distinct from the credential-bearing input response. */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "action" })
union SessionBrowserAuthenticationHistoryResponse
  extends SessionBrowserAuthenticationHistoryResponseBase {
  submit: SessionBrowserAuthenticationSubmitted,
  cancel: SessionBrowserAuthenticationCancelled,
}

/** An admitted browser submission with only its selected option retained. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionBrowserAuthenticationSubmitted
  extends SessionBrowserAuthenticationHistoryResponseBase {
  ...OmitProperties<
    OpenAI.ComputerUseApprovalResponseKindResourceBrowserAuthenticationSubmitResource,
    "selected_option" | "action"
  >;

  /** The action discriminator. */
  action: "submit";

  ...OptionalProperties<PickProperties<
    OpenAI.ComputerUseApprovalResponseKindResourceBrowserAuthenticationSubmitResource,
    "selected_option"
  >>;
}

/** A cancelled browser authentication request. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionBrowserAuthenticationCancelled
  extends SessionBrowserAuthenticationHistoryResponseBase {
  ...OmitProperties<
    OpenAI.ComputerUseApprovalResponseKindResourceBrowserAuthenticationCancelResource,
    "action"
  >;

  /** The action discriminator. */
  action: "cancel";
}

/** The complete upstream web-search action family with optional nullable provider fields preserved. */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
union SessionWebSearchAction extends SessionWebSearchActionBase {
  search: SessionWebSearchQuery,
  open_page: SessionWebSearchOpenPage,
  find_in_page: SessionWebSearchFindInPage,
  other: SessionWebSearchOther,
}

/** Preserves the upstream Search web-search action. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionWebSearchQuery extends SessionWebSearchActionBase {
  ...OmitProperties<
    OpenAI.WebSearchActionResourceSearch,
    "query" | "queries" | "type"
  >;

  /** The variant discriminator. */
  type: "search";

  ...OptionalProperties<PickProperties<
    OpenAI.WebSearchActionResourceSearch,
    "query" | "queries"
  >>;
}

/** Preserves the upstream OpenPage web-search action. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionWebSearchOpenPage extends SessionWebSearchActionBase {
  ...OmitProperties<OpenAI.WebSearchActionResourceOpenPage, "url" | "type">;

  /** The variant discriminator. */
  type: "open_page";

  ...OptionalProperties<PickProperties<
    OpenAI.WebSearchActionResourceOpenPage,
    "url"
  >>;
}

/** Preserves the upstream FindInPage web-search action. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionWebSearchFindInPage extends SessionWebSearchActionBase {
  ...OmitProperties<
    OpenAI.WebSearchActionResourceFindInPage,
    "pattern" | "url" | "type"
  >;

  /** The variant discriminator. */
  type: "find_in_page";

  ...OptionalProperties<PickProperties<
    OpenAI.WebSearchActionResourceFindInPage,
    "pattern" | "url"
  >>;
}

/** Preserves the upstream Other web-search action. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionWebSearchOther extends SessionWebSearchActionBase {
  ...OmitProperties<OpenAI.WebSearchActionResourceOther, "type">;

  /** The variant discriminator. */
  type: "other";
}

/** A Foundry tool invocation used only when no upstream item type applies. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionToolCallItem extends SessionItemBase {
  /** The item discriminator. */
  type: "tool_call";

  /** The stable item identifier. */
  id: string;

  /** The owning turn identifier. */
  turn_id: string;

  /** The tool-call state. */
  status: OpenAI.FunctionCallStatusResource;

  /** The tool name. */
  tool_name: string;

  /** The tool's protocol or category. */
  tool_type: string;

  /** The MCP server label, when applicable. */
  server_label?: string;

  /** Tool-defined JSON arguments. */
  arguments: unknown;
}

/** A Foundry tool's output, without projecting an existing typed upstream item into this shape. */
model SessionToolResultOutput {
  /** Tool-defined JSON content, including structured or multimodal content. */
  content: unknown;

  /** Whether the tool reported an error. */
  is_error: boolean;

  /** Whether content was truncated. */
  truncated: boolean;

  /** References to retained output artifacts. */
  artifact_ids: string[];
}

/** A Foundry tool result used only when no upstream item type applies. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionToolResultItem extends SessionItemBase {
  /** The item discriminator. */
  type: "tool_result";

  /** The stable item identifier. */
  id: string;

  /** The owning turn identifier. */
  turn_id: string;

  /** The tool-result state. */
  status: OpenAI.FunctionCallStatusResource;

  /** The corresponding tool-call item identifier. */
  call_item_id: string;

  /** The recorded tool output. */
  output: SessionToolResultOutput;
}

/** A proposed Foundry MCP approval request recorded in item history. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionMcpApprovalRequestItem extends SessionItemBase {
  /** The item discriminator. */
  type: "mcp_approval_request";

  /** The stable item identifier. */
  id: string;

  /** The owning turn identifier. */
  turn_id: string;

  /** The approval-request state. */
  status: OpenAI.FunctionCallStatusResource;

  /** The pending request identifier. */
  request_id: string;

  /** The MCP server label. */
  server_label: string;

  /** The tool awaiting approval. */
  name: string;

  /** The proposed tool arguments. */
  arguments: unknown;
}

/** A proposed Foundry MCP approval response recorded in item history. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionMcpApprovalResponseItem extends SessionItemBase {
  /** The item discriminator. */
  type: "mcp_approval_response";

  /** The stable item identifier. */
  id: string;

  /** The owning turn identifier. */
  turn_id: string;

  /** The response state. */
  status: OpenAI.FunctionCallStatusResource;

  /** The request being answered. */
  request_id: string;

  /** Whether the caller approved the call. */
  approve: boolean;

  /** The caller's explanation, when supplied. */
  reason?: string;
}

/** OpenAI AgentOutputItem variants plus applicable Foundry output variants, distinct from saved Session history. */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
@extension("x-ms-foundry-meta", ManagedAgentsRequiredPreviews)
union SessionOutputItem extends SessionOutputItemBase {
  message: SessionOutputMessageItem,
  reasoning: SessionOutputReasoningItem,
  function_call: SessionOutputFunctionCallItem,
  mcp_call: SessionOutputMcpCallItem,
  computer_use_call: SessionOutputComputerUseCallItem,
  computer_use_approval_request: SessionOutputComputerUseApprovalRequestItem,
  web_search_call: SessionOutputWebSearchCallItem,
  command_execution: SessionOutputCommandExecutionItem,
  create_subagent_call: SessionOutputCreateSubagentCallItem,
  send_subagent_input_call: SessionOutputSendSubagentInputCallItem,
  resume_subagent_call: SessionOutputResumeSubagentCallItem,
  wait_for_subagents_call: SessionOutputWaitForSubagentsCallItem,
  interrupt_subagent_call: SessionOutputInterruptSubagentCallItem,
  close_subagent_call: SessionOutputCloseSubagentCallItem,
  tool_call: SessionOutputToolCallItem,
  tool_result: SessionOutputToolResultItem,
  mcp_approval_request: SessionOutputMcpApprovalRequestItem,
}

/** Preserves the message output item without accepting its history-only counterparts. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionOutputMessageItem extends SessionOutputItemBase {
  ...OmitProperties<OpenAI.AssistantMessageItemResource, "phase" | "type">;

  /** The variant discriminator. */
  type: "message";

  ...OptionalProperties<PickProperties<
    OpenAI.AssistantMessageItemResource,
    "phase"
  >>;
}

/** Preserves the reasoning output item without accepting its history-only counterparts. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionOutputReasoningItem extends SessionOutputItemBase {
  ...SessionReasoningItem;
}

/** Preserves the function_call output item without accepting its history-only counterparts. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionOutputFunctionCallItem extends SessionOutputItemBase {
  ...SessionFunctionCallItem;
}

/** Preserves the mcp_call output item without accepting its history-only counterparts. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionOutputMcpCallItem extends SessionOutputItemBase {
  ...SessionMcpCallItem;
}

/** Preserves the computer_use_call output item without accepting its history-only counterparts. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionOutputComputerUseCallItem extends SessionOutputItemBase {
  ...SessionComputerUseCallItem;
}

/** Preserves the computer_use_approval_request output item without accepting its history-only counterparts. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionOutputComputerUseApprovalRequestItem
  extends SessionOutputItemBase {
  ...SessionComputerUseApprovalRequestItem;
}

/** Preserves the web_search_call output item without accepting its history-only counterparts. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionOutputWebSearchCallItem extends SessionOutputItemBase {
  ...SessionWebSearchCallItem;
}

/** Preserves the command_execution output item without accepting its history-only counterparts. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionOutputCommandExecutionItem extends SessionOutputItemBase {
  ...SessionCommandExecutionItem;
}

/** Preserves the create_subagent_call output item without accepting its history-only counterparts. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionOutputCreateSubagentCallItem extends SessionOutputItemBase {
  ...SessionCreateSubagentCallItem;
}

/** Preserves the send_subagent_input_call output item without accepting its history-only counterparts. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionOutputSendSubagentInputCallItem extends SessionOutputItemBase {
  ...SessionSendSubagentInputCallItem;
}

/** Preserves the resume_subagent_call output item without accepting its history-only counterparts. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionOutputResumeSubagentCallItem extends SessionOutputItemBase {
  ...SessionResumeSubagentCallItem;
}

/** Preserves the wait_for_subagents_call output item without accepting its history-only counterparts. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionOutputWaitForSubagentsCallItem extends SessionOutputItemBase {
  ...SessionWaitForSubagentsCallItem;
}

/** Preserves the interrupt_subagent_call output item without accepting its history-only counterparts. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionOutputInterruptSubagentCallItem extends SessionOutputItemBase {
  ...SessionInterruptSubagentCallItem;
}

/** Preserves the close_subagent_call output item without accepting its history-only counterparts. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionOutputCloseSubagentCallItem extends SessionOutputItemBase {
  ...SessionCloseSubagentCallItem;
}

/** Preserves the tool_call output item without accepting its history-only counterparts. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionOutputToolCallItem extends SessionOutputItemBase {
  ...SessionToolCallItem;
}

/** Preserves the tool_result output item without accepting its history-only counterparts. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionOutputToolResultItem extends SessionOutputItemBase {
  ...SessionToolResultItem;
}

/** Preserves the mcp_approval_request output item without accepting its history-only counterparts. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "union-extends requires inherited variants; @discriminated on the union supplies the discriminator."
model SessionOutputMcpApprovalRequestItem extends SessionOutputItemBase {
  ...SessionMcpApprovalRequestItem;
}
