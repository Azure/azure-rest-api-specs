using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

/** Common history discriminator. Individual variants retain their own required fields and nullability. */
@discriminator("type")
model ManagedSessionItemBase {
  /** The variant discriminator. */
  type: string;
}

/** Common output discriminator, separate from history-only messages and callback records. */
@discriminator("type")
model ManagedSessionOutputItemBase {
  /** The variant discriminator. */
  type: string;
}

/** Common discriminator for credential-free browser approval history. */
@discriminator("action")
model ManagedSessionBrowserAuthenticationHistoryResponseBase {
  /** The variant discriminator. */
  action: string;
}

/** Common discriminator for typed web-search actions. */
@discriminator("type")
model ManagedSessionWebSearchActionBase {
  /** The variant discriminator. */
  type: string;
}

/** All saved OpenAI Session item variants plus Foundry tool and MCP approval records. */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
@extension("x-ms-foundry-meta", ManagedAgentsRequiredPreviews)
union ManagedSessionItem extends ManagedSessionItemBase {
  message: ManagedSessionMessageItem,
  reasoning: ManagedSessionReasoningItem,
  function_call: ManagedSessionFunctionCallItem,
  function_call_output: ManagedSessionFunctionCallOutputItem,
  agent_message: ManagedSessionAgentMessageItem,
  mcp_call: ManagedSessionMcpCallItem,
  computer_use_call: ManagedSessionComputerUseCallItem,
  computer_use_approval_request: ManagedSessionComputerUseApprovalRequestItem,
  computer_use_approval_request_result: ManagedSessionComputerUseApprovalResponseItem,
  web_search_call: ManagedSessionWebSearchCallItem,
  command_execution: ManagedSessionCommandExecutionItem,
  create_subagent_call: ManagedSessionCreateSubagentCallItem,
  send_subagent_input_call: ManagedSessionSendSubagentInputCallItem,
  resume_subagent_call: ManagedSessionResumeSubagentCallItem,
  wait_for_subagents_call: ManagedSessionWaitForSubagentsCallItem,
  interrupt_subagent_call: ManagedSessionInterruptSubagentCallItem,
  close_subagent_call: ManagedSessionCloseSubagentCallItem,
  tool_call: ManagedSessionToolCallItem,
  tool_result: ManagedSessionToolResultItem,
  mcp_approval_request: ManagedSessionMcpApprovalRequestItem,
  mcp_approval_response: ManagedSessionMcpApprovalResponseItem,
}

/** Preserves the OpenAI message history item, including optional provider fields. */
model ManagedSessionMessageItem extends ManagedSessionItemBase {
  ...OmitProperties<OpenAI.MessageItemResource, "id" | "phase" | "type">;

  /** The variant discriminator. */
  type: "message";

  ...OptionalProperties<PickProperties<
    OpenAI.MessageItemResource,
    "id" | "phase"
  >>;
}

/** Preserves the OpenAI reasoning history item, including optional provider fields. */
@example(#{
  type: "reasoning",
  id: "item_reasoning",
  turn_id: "turn_1",
  summary: #[#{ type: "summary_text", text: "Summary" }],
  status: null,
})
model ManagedSessionReasoningItem extends ManagedSessionItemBase {
  ...OmitProperties<OpenAI.ReasoningItemResource, "status">;
  ...OptionalProperties<PickProperties<OpenAI.ReasoningItemResource, "status">>;
}

/** Preserves the OpenAI function_call history item, including optional provider fields. */
model ManagedSessionFunctionCallItem extends ManagedSessionItemBase {
  ...OpenAI.FunctionCallItemResource;
}

/** Preserves the OpenAI function_call_output history item, including optional provider fields. */
model ManagedSessionFunctionCallOutputItem extends ManagedSessionItemBase {
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

/** Preserves the OpenAI agent_message history item, including optional provider fields. */
model ManagedSessionAgentMessageItem extends ManagedSessionItemBase {
  ...OmitProperties<OpenAI.AgentMessageItemResource, "type">;

  /** The variant discriminator. */
  type: "agent_message";
}

/** Preserves the OpenAI mcp_call history item, including optional provider fields. */
model ManagedSessionMcpCallItem extends ManagedSessionItemBase {
  ...OpenAI.McpCallItemResource;
}

/** Preserves the OpenAI computer_use_call history item, including optional provider fields. */
model ManagedSessionComputerUseCallItem extends ManagedSessionItemBase {
  ...OmitProperties<OpenAI.ComputerUseCallItemResource, "title" | "output">;
  ...OptionalProperties<PickProperties<
    OpenAI.ComputerUseCallItemResource,
    "title" | "output"
  >>;
}

/** Preserves the OpenAI computer_use_approval_request history item, including optional provider fields. */
model ManagedSessionComputerUseApprovalRequestItem
  extends ManagedSessionItemBase {
  ...OmitProperties<OpenAI.BrowserAuthenticationRequestItemResource, "request">;

  /** Credential-free browser request, including form descriptors and options. */
  request: ManagedSessionBrowserAuthenticationContent;
}

/** Preserves the OpenAI computer_use_approval_request_result history item, including optional provider fields. */
model ManagedSessionComputerUseApprovalResponseItem
  extends ManagedSessionItemBase {
  ...OmitProperties<
    OpenAI.ComputerUseApprovalRequestResultItemResource,
    "response" | "type"
  >;

  /** The variant discriminator. */
  type: "computer_use_approval_request_result";

  /** Admitted decision without submitted credential values. */
  response: ManagedSessionBrowserAuthenticationHistoryResponse;
}

/** Preserves the OpenAI web_search_call history item, including optional provider fields. */
model ManagedSessionWebSearchCallItem extends ManagedSessionItemBase {
  ...OmitProperties<OpenAI.WebSearchCallItemResource, "action">;

  /** The typed search, open-page, find, or other action, when recorded. */
  action?: ManagedSessionWebSearchAction | null;
}

/** Preserves the OpenAI command_execution history item, including optional provider fields. */
model ManagedSessionCommandExecutionItem extends ManagedSessionItemBase {
  ...OmitProperties<
    OpenAI.CommandExecutionItemResource,
    "cwd" | "duration_ms" | "exit_code" | "output"
  >;
  ...OptionalProperties<PickProperties<
    OpenAI.CommandExecutionItemResource,
    "cwd" | "duration_ms" | "exit_code" | "output"
  >>;
}

/** Preserves the OpenAI create_subagent_call history item, including optional provider fields. */
model ManagedSessionCreateSubagentCallItem extends ManagedSessionItemBase {
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
model ManagedSessionSendSubagentInputCallItem extends ManagedSessionItemBase {
  ...OpenAI.SendSubagentInputCallItemResource;
}

/** Preserves the OpenAI resume_subagent_call history item, including optional provider fields. */
model ManagedSessionResumeSubagentCallItem extends ManagedSessionItemBase {
  ...OpenAI.ResumeSubagentCallItemResource;
}

/** Preserves the OpenAI wait_for_subagents_call history item, including optional provider fields. */
model ManagedSessionWaitForSubagentsCallItem extends ManagedSessionItemBase {
  ...OpenAI.WaitForSubagentsCallItemResource;
}

/** Preserves the OpenAI interrupt_subagent_call history item, including optional provider fields. */
model ManagedSessionInterruptSubagentCallItem extends ManagedSessionItemBase {
  ...OpenAI.InterruptSubagentCallItemResource;
}

/** Preserves the OpenAI close_subagent_call history item, including optional provider fields. */
model ManagedSessionCloseSubagentCallItem extends ManagedSessionItemBase {
  ...OpenAI.CloseSubagentCallItemResource;
}

/** Credential-free browser authentication request; nullable optional fields may be absent. */
model ManagedSessionBrowserAuthenticationContent {
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
union ManagedSessionBrowserAuthenticationHistoryResponse
  extends ManagedSessionBrowserAuthenticationHistoryResponseBase {
  submit: ManagedSessionBrowserAuthenticationSubmitted,
  cancel: ManagedSessionBrowserAuthenticationCancelled,
}

/** An admitted browser submission with only its selected option retained. */
model ManagedSessionBrowserAuthenticationSubmitted
  extends ManagedSessionBrowserAuthenticationHistoryResponseBase {
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
model ManagedSessionBrowserAuthenticationCancelled
  extends ManagedSessionBrowserAuthenticationHistoryResponseBase {
  ...OmitProperties<
    OpenAI.ComputerUseApprovalResponseKindResourceBrowserAuthenticationCancelResource,
    "action"
  >;

  /** The action discriminator. */
  action: "cancel";
}

/** The complete upstream web-search action family with optional nullable provider fields preserved. */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
union ManagedSessionWebSearchAction extends ManagedSessionWebSearchActionBase {
  search: ManagedSessionWebSearchQuery,
  open_page: ManagedSessionWebSearchOpenPage,
  find_in_page: ManagedSessionWebSearchFindInPage,
  other: ManagedSessionWebSearchOther,
}

/** Preserves the upstream Search web-search action. */
model ManagedSessionWebSearchQuery extends ManagedSessionWebSearchActionBase {
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
model ManagedSessionWebSearchOpenPage
  extends ManagedSessionWebSearchActionBase {
  ...OmitProperties<OpenAI.WebSearchActionResourceOpenPage, "url" | "type">;

  /** The variant discriminator. */
  type: "open_page";

  ...OptionalProperties<PickProperties<
    OpenAI.WebSearchActionResourceOpenPage,
    "url"
  >>;
}

/** Preserves the upstream FindInPage web-search action. */
model ManagedSessionWebSearchFindInPage
  extends ManagedSessionWebSearchActionBase {
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
model ManagedSessionWebSearchOther extends ManagedSessionWebSearchActionBase {
  ...OmitProperties<OpenAI.WebSearchActionResourceOther, "type">;

  /** The variant discriminator. */
  type: "other";
}

/** A Foundry tool invocation used only when no upstream item type applies. */
model ManagedSessionToolCallItem extends ManagedSessionItemBase {
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
model ManagedSessionToolResultOutput {
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
model ManagedSessionToolResultItem extends ManagedSessionItemBase {
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
  output: ManagedSessionToolResultOutput;
}

/** A proposed Foundry MCP approval request recorded in item history. */
model ManagedSessionMcpApprovalRequestItem extends ManagedSessionItemBase {
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
model ManagedSessionMcpApprovalResponseItem extends ManagedSessionItemBase {
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
union ManagedSessionOutputItem extends ManagedSessionOutputItemBase {
  message: ManagedSessionOutputMessageItem,
  reasoning: ManagedSessionOutputReasoningItem,
  function_call: ManagedSessionOutputFunctionCallItem,
  mcp_call: ManagedSessionOutputMcpCallItem,
  computer_use_call: ManagedSessionOutputComputerUseCallItem,
  computer_use_approval_request: ManagedSessionOutputComputerUseApprovalRequestItem,
  web_search_call: ManagedSessionOutputWebSearchCallItem,
  command_execution: ManagedSessionOutputCommandExecutionItem,
  create_subagent_call: ManagedSessionOutputCreateSubagentCallItem,
  send_subagent_input_call: ManagedSessionOutputSendSubagentInputCallItem,
  resume_subagent_call: ManagedSessionOutputResumeSubagentCallItem,
  wait_for_subagents_call: ManagedSessionOutputWaitForSubagentsCallItem,
  interrupt_subagent_call: ManagedSessionOutputInterruptSubagentCallItem,
  close_subagent_call: ManagedSessionOutputCloseSubagentCallItem,
  tool_call: ManagedSessionOutputToolCallItem,
  tool_result: ManagedSessionOutputToolResultItem,
  mcp_approval_request: ManagedSessionOutputMcpApprovalRequestItem,
}

/** Preserves the message output item without accepting its history-only counterparts. */
model ManagedSessionOutputMessageItem extends ManagedSessionOutputItemBase {
  ...OmitProperties<OpenAI.AssistantMessageItemResource, "phase" | "type">;

  /** The variant discriminator. */
  type: "message";

  ...OptionalProperties<PickProperties<
    OpenAI.AssistantMessageItemResource,
    "phase"
  >>;
}

/** Preserves the reasoning output item without accepting its history-only counterparts. */
model ManagedSessionOutputReasoningItem extends ManagedSessionOutputItemBase {
  ...ManagedSessionReasoningItem;
}

/** Preserves the function_call output item without accepting its history-only counterparts. */
model ManagedSessionOutputFunctionCallItem
  extends ManagedSessionOutputItemBase {
  ...ManagedSessionFunctionCallItem;
}

/** Preserves the mcp_call output item without accepting its history-only counterparts. */
model ManagedSessionOutputMcpCallItem extends ManagedSessionOutputItemBase {
  ...ManagedSessionMcpCallItem;
}

/** Preserves the computer_use_call output item without accepting its history-only counterparts. */
model ManagedSessionOutputComputerUseCallItem
  extends ManagedSessionOutputItemBase {
  ...ManagedSessionComputerUseCallItem;
}

/** Preserves the computer_use_approval_request output item without accepting its history-only counterparts. */
model ManagedSessionOutputComputerUseApprovalRequestItem
  extends ManagedSessionOutputItemBase {
  ...ManagedSessionComputerUseApprovalRequestItem;
}

/** Preserves the web_search_call output item without accepting its history-only counterparts. */
model ManagedSessionOutputWebSearchCallItem
  extends ManagedSessionOutputItemBase {
  ...ManagedSessionWebSearchCallItem;
}

/** Preserves the command_execution output item without accepting its history-only counterparts. */
model ManagedSessionOutputCommandExecutionItem
  extends ManagedSessionOutputItemBase {
  ...ManagedSessionCommandExecutionItem;
}

/** Preserves the create_subagent_call output item without accepting its history-only counterparts. */
model ManagedSessionOutputCreateSubagentCallItem
  extends ManagedSessionOutputItemBase {
  ...ManagedSessionCreateSubagentCallItem;
}

/** Preserves the send_subagent_input_call output item without accepting its history-only counterparts. */
model ManagedSessionOutputSendSubagentInputCallItem
  extends ManagedSessionOutputItemBase {
  ...ManagedSessionSendSubagentInputCallItem;
}

/** Preserves the resume_subagent_call output item without accepting its history-only counterparts. */
model ManagedSessionOutputResumeSubagentCallItem
  extends ManagedSessionOutputItemBase {
  ...ManagedSessionResumeSubagentCallItem;
}

/** Preserves the wait_for_subagents_call output item without accepting its history-only counterparts. */
model ManagedSessionOutputWaitForSubagentsCallItem
  extends ManagedSessionOutputItemBase {
  ...ManagedSessionWaitForSubagentsCallItem;
}

/** Preserves the interrupt_subagent_call output item without accepting its history-only counterparts. */
model ManagedSessionOutputInterruptSubagentCallItem
  extends ManagedSessionOutputItemBase {
  ...ManagedSessionInterruptSubagentCallItem;
}

/** Preserves the close_subagent_call output item without accepting its history-only counterparts. */
model ManagedSessionOutputCloseSubagentCallItem
  extends ManagedSessionOutputItemBase {
  ...ManagedSessionCloseSubagentCallItem;
}

/** Preserves the tool_call output item without accepting its history-only counterparts. */
model ManagedSessionOutputToolCallItem extends ManagedSessionOutputItemBase {
  ...ManagedSessionToolCallItem;
}

/** Preserves the tool_result output item without accepting its history-only counterparts. */
model ManagedSessionOutputToolResultItem extends ManagedSessionOutputItemBase {
  ...ManagedSessionToolResultItem;
}

/** Preserves the mcp_approval_request output item without accepting its history-only counterparts. */
model ManagedSessionOutputMcpApprovalRequestItem
  extends ManagedSessionOutputItemBase {
  ...ManagedSessionMcpApprovalRequestItem;
}
