

@doc("""
Representation of the token counts processed for a completions request.
Counts consider all tokens across prompts, choices, choice alternates, best_of generations, and other consumers.
""")
model CompletionsUsage {
    @doc("Number of tokens received in the completion")
    completionTokens: int32,
    @doc("Number of tokens sent in the original request")
    promptTokens: int32,
    @doc("Total number of tokens transacted in this request/response")
    totalTokens: int32
}

@doc("Representation of the manner in which a completions response concluded.")
enum FinishReason {
    @doc("Completions ended normally and reached its end of token generation.")
    @projectedName("json", "stop")
    Stopped,
    @doc("Completions exhausted available token limits before generation could complete.")
    @projectedName("json", "length")
    TokenLimitReached,
    @doc("Completions generated a response that was identified as potentially sensitive per content moderation policies.")
    ContentFiltered
}
