// FIXTURE (TRUE NEGATIVE -- class 2: legitimate deviation).
// Everything here LOOKS like a violation and is correct:
//   - POST :analyze is a genuine computation, not CRUD in disguise.
//   - listSupportedLanguages is unpaged because the collection is bounded and
//     documented as such.
//   - Configuration is a singleton because there is exactly one per account.
//   - AnalysisMode is a genuinely closed union: the wire protocol admits
//     exactly two values.
//   - There is no delete for Configuration because it cannot be deleted, only
//     reset -- and that is documented.
// The correct review output is silence, or at most a question. Any blocking
// finding is a test failure.
// Not a real service. Not under specification/; not compiled by CI.

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service(#{ title: "Text Analyzer" })
@versioned(Versions)
@server("https://{endpoint}", "Text Analyzer service", { endpoint: string })
namespace TextAnalyzer;

@doc("Service API versions.")
enum Versions {
  @doc("The 2026-01-01 stable version.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2026_01_01: "2026-01-01",
}

@doc("Input to a text analysis request.")
model AnalyzeRequest {
  @doc("Text to analyse. Maximum 10,000 characters.")
  @maxLength(10000)
  text: string;

  @doc("BCP-47 language tag of the input text, for example 'en-US'. When omitted the service detects the language.")
  language?: string;

  @doc("Depth of analysis to perform.")
  mode?: AnalysisMode;
}

@doc("""
  Depth of analysis to perform. This union is intentionally closed: the wire
  protocol admits exactly these two values, and adding a third would require a
  new request shape rather than a new enum member.
  """)
union AnalysisMode {
  @doc("Sentence-level analysis only. Lower latency.")
  Shallow: "Shallow",

  @doc("Full document analysis including cross-sentence coreference.")
  Deep: "Deep",
}

@doc("Result of a text analysis request. Results are computed on demand and are not stored by the service.")
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

@doc("Account-level analyzer configuration. Exactly one configuration exists per account; it is created with the account and cannot be deleted, only reset to defaults.")
model Configuration {
  @doc("Default analysis mode used when a request omits `mode`.")
  defaultMode: AnalysisMode;

  @doc("Whether to redact detected personal data from analysis results before returning them.")
  redactPersonalData: boolean;

  @doc("Time at which the configuration was last changed, in UTC.")
  @visibility(Lifecycle.Read)
  updatedAt: utcDateTime;
}

@doc("Analysis operations.")
interface Analysis {
  @doc("""
    Analyses a block of text and returns sentiment, detected language, and key
    phrases. The result is computed on demand, is not addressable, and is not
    retained by the service; callers that need to keep a result must store it
    themselves.
    """)
  @route("/text:analyze")
  @post
  analyze(@body body: AnalyzeRequest): AnalyzeResult;

  @doc("""
    Lists the languages the analyzer supports. This collection is fixed by the
    service, is currently 42 entries, and is documented never to exceed 200; it
    is therefore returned unpaged so that callers can cache it in a single
    call.
    """)
  @route("/languages")
  @get
  listSupportedLanguages(): SupportedLanguage[];
}

@doc("Configuration operations. The configuration is a singleton: exactly one exists per account.")
interface Configurations {
  @doc("Gets the account's analyzer configuration.")
  @route("/configuration")
  @get
  get(): Configuration;

  @doc("Replaces the account's analyzer configuration.")
  @route("/configuration")
  @put
  createOrReplace(@body body: Configuration): Configuration;

  @doc("""
    Resets the account's analyzer configuration to service defaults. This is
    the delete-equivalent for a resource that cannot be absent: the
    configuration always exists for the lifetime of the account.
    """)
  @route("/configuration:reset")
  @post
  reset(): Configuration;
}
