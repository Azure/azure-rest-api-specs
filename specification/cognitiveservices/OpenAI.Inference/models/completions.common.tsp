namespace Azure.OpenAI;

using TypeSpec.Versioning;

@doc("""
Representation of the token counts processed for a completions request.
Counts consider all tokens across prompts, choices, choice alternates, best_of generations, and
other consumers.
""")
model CompletionsUsage {
  @doc("The number of tokens generated across all completions emissions.")
  @projectedName("json", "completion_tokens")
  completionTokens: int32;

  @doc("The number of tokens in the provided prompts for the completions request.")
  @projectedName("json", "prompt_tokens")
  promptTokens: int32;

  @doc("The total number of tokens processed for the completions request and response.")
  @projectedName("json", "total_tokens")
  totalTokens: int32;
}

@doc("""
Representation of the manner in which a completions response concluded.
""")
enum CompletionsFinishReason {
  @doc("Completions ended normally and reached its end of token generation.")
  stopped: "stop",

  @doc("Completions exhausted available token limits before generation could complete.")
  tokenLimitReached: "length",

  @doc("""
    Completions generated a response that was identified as potentially sensitive per content
    moderation policies.
    """)
  contentFiltered: "content_filter",
}

@added(ServiceApiVersions.v2023_06_01_Preview)
@doc("Ratings for the intensity and risk level of harmful content.")
enum ContentFilterSeverity {
  @doc("General content or related content in generic or non-harmful contexts.")
  safe: "safe";

  @doc("Harmful content at a low intensity and risk level.")
  low: "low";

  @doc("Harmful content at a medium intensity and risk level.")
  medium: "medium";

  @doc("Harmful content at a high intensity and risk level.")
  high: "high";
}

@added(ServiceApiVersions.v2023_06_01_Preview)
@doc("Information about filtered content severity level and if it has been filtered or not.")
model ContentFilterResult {
  @doc("")
  @projectedName("json", "severity")
  severity: ContentFilterSeverity;

  @doc("")
  @projectedName("json", "filtered")
  filtered: boolean;

}

@added(ServiceApiVersions.v2023_06_01_Preview)
@doc("Information about the content filtering category, if it has been detected.")
model ContentFilterResults {
  sexual: ContentFilterResult;
  violence: ContentFilterResult;
  hate: ContentFilterResult;
  selfHarm: ContentFilterResult;
  //error?
}

@added(ServiceApiVersions.v2023_06_01_Preview)
@doc("""
Content filtering results for a single prompt in the request.
""")
model PromptFilterResult {
  @doc("")
  @projectedName("json", "prompt_index")
  promptIndex: int32;

  @doc("asdfasdfasdf")
  @projectedName("json", "contentFilterResults")
  contentFilterResults?: ContentFilterResults;
}