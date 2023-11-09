import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models-glossaryformats.tsp";
import "./models-documentformats.tsp";
import "./models-documenttranslate.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DocumentTranslation;

/** Defines Document Translation custom Operation */
op CustomOperation<
  TBody,
  TParams,
  TResponse,
  TError = ErrorResponse
>(
  ...TParams,

  #suppress "@azure-tools/typespec-azure-core/request-body-problem"
  /** Defines the content of the request */
  @body
  requestBody: TBody,
): TResponse | TError;

/** Defines Document Translation custom Operations which doesn't have any content in the request */
op CustomGetOperation<TParams, TResponse, TError = ErrorResponse>(
  ...TParams,
): TResponse | TError;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@get
@route("single/glossary/formats")
@summary("Gets the set of file formats currently supported by glossaries.")
/** The Get supported glossary formats method returns a list of glossary formats supported by the Document Translation service.
 *  The list includes the common file extension used. */
op getSingleGlossaryFormats is CustomGetOperation<
  GlossaryFormatParameters,
  GlossaryFormatResult,
  ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@get
@route("single/formats")
@summary("Gets the set of file formats currently supported by documents.")
/** The Get supported document formats method returns a list of document formats supported by the Document Translation service.
 *  The list includes the common file extension used. */
op getSingleDocumentFormats is CustomGetOperation<
  DocumentFormatParameters,
  DocumentormatResult,
  ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
#suppress "@azure-tools/typespec-azure-core/byos"
@post
/** Use this API to translate a single document.
 * All supported document formats can be obtained with `single/formats` API.
 * Single Glossary / Translation memory can be included in the request and applied by the service when the document is translated.
*/
@route("single:translateDocument")
op singleTranslateDocument is CustomOperation<
  TranslateDocumentRequest,
  TranslateDocumentParameters,
  TranslateDocumentResult,
  ErrorResponse
>;