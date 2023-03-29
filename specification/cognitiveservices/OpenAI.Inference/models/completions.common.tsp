@doc("""
Representation of the token counts processed for a completions request.
Counts consider all tokens across prompts, choices, choice alternates, best_of generations, and
other consumers.
""")
model CompletionsUsage {
    @doc("The number of tokens generated across all completions emissions.")
    @projectedName("json", "completion_tokens")
    completionTokens: int32,
    @doc("The number of tokens in the provided prompts for the completions request.")
    @projectedName("json", "prompt_tokens")
    promptTokens: int32,
    @doc("The total number of tokens processed for the completions request and response.")
    @projectedName("json", "total_tokens")
    totalTokens: int32
}

@doc("""
Representation of the manner in which a completions response concluded.
""")
enum CompletionsFinishReason {
    @doc("""
    Completions are not yet finished. This generally indicates a streaming operation is still in
    progress.
    """)
    // Note: this is a representation of an explicitly serialized null for finish_reason
    none,

    @doc("Completions ended normally and reached its end of token generation.")
    @projectedName("json", "stop")
    stopped,

    @doc("Completions exhausted available token limits before generation could complete.")
    @projectedName("json", "length")
    tokenLimitReached,

    @doc("""
    Completions generated a response that was identified as potentially sensitive per content
    moderation policies.
    """)
    @projectedName("json", "content_filter")
    contentFiltered
}