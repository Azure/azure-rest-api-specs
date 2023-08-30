import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Versioning;

namespace Azure.OpenAI;

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

  @doc("Completion ended normally, with the model requesting a function to be called.")
  @added(ServiceApiVersions.v2023_07_01_Preview)
  functionCall: "function_call",
}

@added(ServiceApiVersions.v2023_06_01_Preview)
@doc("Ratings for the intensity and risk level of harmful content.")
enum ContentFilterSeverity {
  @doc("""
  Content may be related to violence, self-harm, sexual, or hate categories but the terms 
  are used in general, journalistic, scientific, medical, and similar professional contexts, 
  which are appropriate for most audiences.
  """)
  safe: "safe",

  @doc("""
  Content that expresses prejudiced, judgmental, or opinionated views, includes offensive 
  use of language, stereotyping, use cases exploring a fictional world (for example, gaming,
  literature) and depictions at low intensity.
  """)
  low: "low",

  @doc("""
  Content that uses offensive, insulting, mocking, intimidating, or demeaning language 
  towards specific identity groups, includes depictions of seeking and executing harmful 
  instructions, fantasies, glorification, promotion of harm at medium intensity.
  """)
  medium: "medium",

  @doc("""
  Content that displays explicit and severe harmful instructions, actions, 
  damage, or abuse; includes endorsement, glorification, or promotion of severe 
  harmful acts, extreme or illegal forms of harm, radicalization, or non-consensual 
  power exchange or abuse.
  """)
  high: "high",
}

@added(ServiceApiVersions.v2023_06_01_Preview)
@doc("Information about filtered content severity level and if it has been filtered or not.")
model ContentFilterResult {
  @doc("Ratings for the intensity and risk level of filtered content.")
  @projectedName("json", "severity")
  severity: ContentFilterSeverity;

  @doc("A value indicating whether or not the content has been filtered.")
  @projectedName("json", "filtered")
  filtered: boolean;
}

@added(ServiceApiVersions.v2023_06_01_Preview)
@doc("Information about the content filtering category, if it has been detected.")
model ContentFilterResults {
  @doc("""
  Describes language related to anatomical organs and genitals, romantic relationships,
   acts portrayed in erotic or affectionate terms, physical sexual acts, including 
   those portrayed as an assault or a forced sexual violent act against one’s will, 
   prostitution, pornography, and abuse.
  """)
  sexual?: ContentFilterResult;

  @doc("""
  Describes language related to physical actions intended to hurt, injure, damage, or 
  kill someone or something; describes weapons, etc.
  """)
  violence?: ContentFilterResult;

  @doc("""
  Describes language attacks or uses that include pejorative or discriminatory language 
  with reference to a person or identity group on the basis of certain differentiating 
  attributes of these groups including but not limited to race, ethnicity, nationality,
  gender identity and expression, sexual orientation, religion, immigration status, ability
  status, personal appearance, and body size.
  """)
  hate?: ContentFilterResult;

  @doc("""
  Describes language related to physical actions intended to purposely hurt, injure,
  or damage one’s body, or kill oneself.
  """)
  @projectedName("json", "self_harm")
  selfHarm?: ContentFilterResult;

  @doc("""
  Describes an error returned if the content filtering system is
  down or otherwise unable to complete the operation in time.
  """)
  error?: Azure.Core.Foundations.Error;
}

@added(ServiceApiVersions.v2023_06_01_Preview)
@doc("""
Content filtering results for a single prompt in the request.
""")
model PromptFilterResult {
  @doc("The index of this prompt in the set of prompt results")
  @projectedName("json", "prompt_index")
  promptIndex: int32;

  @doc("Content filtering results for this prompt")
  @projectedName("json", "content_filter_results")
  contentFilterResults?: ContentFilterResults;
}
