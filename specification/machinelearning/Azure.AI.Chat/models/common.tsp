namespace Azure.AI.Chat;

enum FinishReason {
  stopped: "stop",
  tokenLimitReached: "length",
  contentFiltered: "content_filter",
  functionCall: "function_call",
}

enum Role {
  user: "user",
  system: "system",
  assistant: "assistant",
}

model Message {
  content: string;
  role: Role;

  @projectedName("json", "session_state")
  sessionState: unknown;
}
