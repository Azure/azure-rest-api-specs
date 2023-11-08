import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models-shared.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace DocumentTranslation;

#suppress "@azure-tools/typespec-azure-core/known-encoding" "Custom encoding."
@doc("Binary data format.")
@encode("binary")
scalar binary extends bytes;

@doc("Request parameters for the Document Translate.")
model TranslateDocumentParameters {
    ...CommonParameters;
    @doc("The from language of the Translation Request, if empty or not specified it will be autodetect.")
    @query("From")
    from?: string,

    @doc("The to language of the Translation Request.")
    @query("To")
    to: string,

    @doc("The category of the translation. If empty, default to general.")
    @query("Category")
    category?: string,

    @doc("The category of the translation. If not specified, default to true.")
    @query("AllowFallback")
    allowFallback?: string,

    @doc("Mandatory API version parameter")
    @query("api-version")
    apiVersion: string,
}

@doc("Translate Document Request Body.")
model TranslateDocumentRequestBody {
    @doc("Actual Document in the form.")
    document: binary[];
  }

  @doc("Successful request and the document is translated.  The translated document is returned in the body.")
  model TranslateDocumentResult {
    ...CommonResultHeaders;
    @body
    @doc("Translated document")
    document: bytes;
  }
  