import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./models-languages.tsp";
import "./models-translate.tsp";
import "./models-transliterate.tsp";
import "./models-breaksentence.tsp";
import "./models-dictionary.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace TextTranslation;

@doc("Defines Text Translation custom Operation")
op CustomOperation<TBody, TParams, TResponse, TError = ErrorResponse>(
  ...TParams,

  #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Existing spec"
  @doc("Defines the content of the request")
  @bodyRoot
  body: TBody,

  @doc("Mandatory API version parameter")
  @query("api-version")
  apiVersion: string,
): TResponse | TError;

@doc("Defines Text Translation custom Operations which doesn't have any content in the request")
op CustomGetOperation<TParams, TResponse, TError = ErrorResponse>(
  ...TParams,

  @doc("Mandatory API version parameter")
  @query("api-version")
  apiVersion: string,
): TResponse | TError;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
@get
@route("languages")
@summary("Gets the set of languages currently supported by other operations of the Translator.")
@doc("Gets the set of languages currently supported by other operations of the Translator.")
op getSupportedLanguages is CustomGetOperation<
  GetSupportedLanguagesParameters,
  GetSupportedLanguagesResult,
  ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
@post
@summary("Translate Text")
@doc("Translate Text")
@route("translate")
@sharedRoute
@renamedFrom(APIVersion.v2025_10_01_preview, "translate")
@removed(APIVersion.v2025_10_01_preview)
op translateV3 is CustomOperation<
  InputTextItem[],
  TranslateParameters,
  TranslationResultV3,
  ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
@post
@sharedRoute
@summary("Translate Text")
@doc("Translate Text")
@route("translate")
@added(APIVersion.v2025_10_01_preview)
op translate is CustomOperation<
  TranslateBody,
  TranslateParameters,
  TranslationResult,
  ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
@post
@sharedRoute
@route("transliterate")
@summary("Transliterate Text")
@doc("Transliterate Text")
@renamedFrom(APIVersion.v2025_10_01_preview, "transliterate")
@removed(APIVersion.v2025_10_01_preview)
op transliterateV3 is CustomOperation<
  InputTextItem[],
  TransliterateParameters,
  TransliterateResultV3,
  ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
@post
@sharedRoute
@route("transliterate")
@summary("Transliterate Text")
@doc("Transliterate Text")
@added(APIVersion.v2025_10_01_preview)
op transliterate is CustomOperation<
  TransliterateBody,
  TransliterateParameters,
  TransliterateResult,
  ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
@removed(APIVersion.v2025_10_01_preview)
@post
@route("breaksentence")
@summary("Find Sentence Boundaries")
@doc("Find Sentence Boundaries")
op findSentenceBoundaries is CustomOperation<
  InputTextItem[],
  BreakSentenceParameters,
  BreakSentenceResult,
  ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
@removed(APIVersion.v2025_10_01_preview)
@post
@route("dictionary/lookup")
@summary("Lookup Dictionary Entries")
@doc("Lookup Dictionary Entries")
op lookupDictionaryEntries is CustomOperation<
  InputTextItem[],
  DictionaryLookupParameters,
  DictionaryLookupResult,
  ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
@post
@route("dictionary/examples")
@summary("Lookup Dictionary Examples")
@doc("Lookup Dictionary Examples")
@removed(APIVersion.v2025_10_01_preview)
op lookupDictionaryExamples is CustomOperation<
  DictionaryExampleTextItem[],
  DictionaryExamplesParameters,
  DictionaryExamplesResult,
  ErrorResponse
>;
