import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@service(#{ title: "Text Analyzer" })
@versioned(Versions)
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
      scopes: ["https://textanalyzer.azure.com/.default"],
    }
  ]>
)
@server("https://{endpoint}", "Text Analyzer service", { endpoint: string })
namespace TextAnalyzer;

@doc("Service API versions.")
enum Versions {
  @doc("The 2026-01-01 stable version.")
  v2026_01_01: "2026-01-01",
}

@doc("Input to a text analysis request.")
model AnalyzeRequest {
  @doc("Text to analyze. Maximum 10,000 characters.")
  @maxLength(10000)
  text: string;

  @doc("BCP-47 language tag of the input text, for example 'en-US'. When omitted the service detects the language.")
  language?: string;

  @doc("Depth of analysis to perform.")
  mode?: AnalysisMode;
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The wire protocol frames a request as either single-sentence or whole-document; a third depth would need a different request shape, not a third member, so the set cannot grow."
@doc("Depth of analysis to perform.")
union AnalysisMode {
  @doc("Sentence-level analysis only. Lower latency.")
  Shallow: "Shallow",

  @doc("Full document analysis including cross-sentence coreference.")
  Deep: "Deep",
}

@doc("Result of a text analysis request.")
model AnalyzeResult {
  @doc("Overall sentiment score, from -1.0 (most negative) to 1.0 (most positive).")
  sentimentScore: float32;

  @doc("BCP-47 language tag of the language the service detected or was given.")
  detectedLanguage: string;

  @doc("Key phrases extracted from the input text, most significant first.")
  keyPhrases: string[];
}

@doc("A language supported by the analyzer.")
model SupportedLanguage {
  @doc("BCP-47 language tag, for example 'en-US'.")
  tag: string;

  @doc("English name of the language, for example 'English (United States)'.")
  displayName: string;
}

@doc("The set of languages the analyzer supports.")
model SupportedLanguageCollection {
  @doc("The supported languages, ordered by tag.")
  value: SupportedLanguage[];
}

@doc("Account-level analyzer configuration.")
@resource("configurations")
model Configuration {
  @doc("Identifier of the configuration. The only supported value is 'default'.")
  @key("configurationName")
  @visibility(Lifecycle.Read)
  @pattern("^default$")
  name: string;

  @doc("Default analysis mode used when a request omits `mode`.")
  defaultMode: AnalysisMode;

  @doc("""
    Whether the analyzer is enabled for this account. When false, analysis
    requests are rejected and no configuration other than this flag applies.
    """)
  enabled: boolean;

  @doc("Time at which the configuration was last changed, in UTC.")
  @visibility(Lifecycle.Read)
  updatedAt: utcDateTime;
}

@doc("Analysis operations.")
interface Analysis {
  @doc("""
    Analyzes a block of text and returns sentiment, detected language, and key
    phrases. The result is computed on demand, is not addressable, and is not
    retained by the service; callers that need to keep a result must store it
    themselves.
    """)
  @route("/text:analyze")
  analyze is Azure.Core.RpcOperation<AnalyzeRequest, AnalyzeResult>;

  @doc("""
    Lists the languages the analyzer supports. This collection is fixed by the
    service, is currently 42 entries, and is documented never to exceed 200; it
    is therefore returned unpaged so that callers can cache it in a single
    call.
    """)
  @route("/languages")
  getSupportedLanguages is Azure.Core.RpcOperation<{}, SupportedLanguageCollection>;
}

@doc("Configuration operations.")
interface Configurations {
  @doc("Gets the account's analyzer configuration.")
  getConfiguration is StandardResourceOperations.ResourceRead<Configuration>;

  @doc("Replaces the account's analyzer configuration.")
  createOrReplaceConfiguration is StandardResourceOperations.ResourceCreateOrReplace<Configuration>;

  @doc("""
    Resets the account's analyzer configuration to service defaults. This is
    the delete-equivalent for a resource that cannot be absent: the
    configuration always exists for the lifetime of the account.
    """)
  resetConfiguration is StandardResourceOperations.ResourceAction<Configuration, {}, Configuration>;
}

