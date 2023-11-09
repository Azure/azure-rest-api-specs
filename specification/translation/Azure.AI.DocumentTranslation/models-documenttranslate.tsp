import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models-shared.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace DocumentTranslation;

/** Request parameters for the Document Translate. */
model TranslateDocumentParameters {
    ...CommonParameters;
    /** The from language of the Translation Request, if empty or not specified it will be autodetect. */
    @query("From")
    from?: string,

    /** The to language of the Translation Request. */
    @query("To")
    to: string,

    /** The category of the translation. If empty, default to general. */
    @query("Category")
    category?: string = "generalnn",

    /** The category of the translation. If not specified, default to true. */
    @query("AllowFallback", )
    allowFallback?: boolean,

    /** Content Type as multipart/form-data */
    @header contentType: "multipart/form-data",
}

/** Translate Document Request Body. */
model TranslateDocumentRequest {
    /** Actual Document in the form. */
    document: bytes;
    /** Actual glossary in the form. */
    glossary: bytes;
  }

  /** Successful request and the document is translated. The translated document is returned in the body. */
  model TranslateDocumentResult {
    ...CommonResultHeaders;
    /** response conent type */
    @header contentType: "application/octet-stream",
    @body
    /** Request response is a document */
    document: bytes;
  }
  