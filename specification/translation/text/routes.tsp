import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models-languages.tsp";
import "./models-translate.tsp";
import "./models-transliterate.tsp";
import "./models-breaksentence.tsp";
import "./models-dictionary.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace TextTranslation;

op CustomOperation<TParams, TResponse, Traits = {}, TError = ErrorResponse>(
  ...TParams,

  @query("api-version")
  apiVersion: string
): TResponse | TError;

@get
@route("languages")
@summary("Gets the set of languages currently supported by other operations of the Translator.")
@doc("Gets the set of languages currently supported by other operations of the Translator.")
op GetLanguages is CustomOperation<
  GetLanguageParameters,
  GetLanguagesResult,
  {},
  ErrorResponse
>;

@post
@route("translate")
@summary("Translate Text")
@doc("Translate Text")
op Translate is CustomOperation<
  TranslateParameters,
  TranslationResult,
  {},
  ErrorResponse
>;

@post
@route("transliterate")
@summary("Transliterate Text")
@doc("Transliterate Text")
op Transliterate is CustomOperation<
  TransliterateParameters,
  TransliterateResult,
  {},
  ErrorResponse
>;

@post
@route("breaksentence")
@summary("Find Sentence Boundaries")
@doc("Find Sentence Boundaries")
op FindSentenceBoundaries is CustomOperation<
  BreakSentenceParameters,
  BreakSentenceResult,
  {},
  ErrorResponse
>;

@post
@route("dictionary/lookup")
@summary("Lookup Dictionary Entries")
@doc("Lookup Dictionary Entries")
op LookupDictionaryEntries is CustomOperation<
  DictionaryLookupParamters,
  DictionaryLookupResult,
  {},
  ErrorResponse
>;

@post
@route("dictionary/examples")
@summary("Lookup Dictionary Examples")
@doc("Lookup Dictionary Examples")
op LookupDictionaryExamples is CustomOperation<
  DictionaryExamplesParamters,
  DictionaryExamplesResult,
  {},
  ErrorResponse
>;
