import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models-glossaryformats.tsp";
import "./models-documentformats.tsp";
import "./models-documenttranslate.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DocumentTranslation;

@doc("Defines Document Translation custom Operation")
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
  @body
  requestBody: TBody,

  @doc("Mandatory API version parameter")
  @query("api-version")
  apiVersion: string,
): TResponse | TError;

@doc("Defines Document Translation custom Operations which doesn't have any content in the request")
op CustomGetOperation<TParams, TResponse, Traits = {}, TError = ErrorResponse>(
  ...TParams,

  @doc("Mandatory API version parameter")
  @query("api-version")
  apiVersion: string,
): TResponse | TError;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom routes."
@get
@route("single/glossary/formats")
@summary("Gets the set of file formats currently supported by glossaries.")
@doc("Gets the set of file formats currently supported by glossaries.")
op getSingleGlossaryFormats is CustomGetOperation<
  GlossaryFormatParameters,
  GlossaryFormatResult,
  {},
  ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom routes."
@get
@route("single/formats")
@summary("Gets the set of file formats currently supported by documents.")
@doc("Gets the set of file formats currently supported by documents.")
op getSingleDocumentFormats is CustomGetOperation<
  DocumentFormatParameters,
  DocumentormatResult,
  {},
  ErrorResponse
>;