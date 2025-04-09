import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models-languages.tsp";
import "./models-translate.tsp";
import "./models-transliterate.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace TextTranslation;

@doc("Defines Text Translation custom Operation")
op CustomOperation<
  TBody,
  TParams,
  TResponse,
  Traits = {},
  TError = ErrorResponse
>(
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
op CustomGetOperation<TParams, TResponse, Traits = {}, TError = ErrorResponse>(
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
  {},
  ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
@post
@route("translate")
@summary("Translate Text")
@doc("Translate Text")
op translate is CustomOperation<
  TranslateBodyDetails[],
  TranslateParameters,
  TranslationResult,
  {},
  ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
@post
@route("transliterate")
@summary("Transliterate Text")
@doc("Transliterate Text")
op transliterate is CustomOperation<
  InputTextItem[],
  TransliterateParameters,
  TransliterateResult,
  {},
  ErrorResponse
>;
