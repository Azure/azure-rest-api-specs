import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models-shared.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace DocumentTranslation;

#suppress "@azure-tools/typespec-azure-core/known-encoding"
/** Binary data format. */
@encode("binary")
scalar binary extends bytes;

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

    /** Mandatory API version parameter */
    @query("api-version")
    apiVersion: string,

    /** Content Type as multipart/form-data */
    @header contentType: "multipart/form-data",

    /** accepted content types */
    @header accept: "application/octet-stream" | "text/csv" | "text/html" | "text/markdown" | "text/x-markdown" | "message/rfc822" | "application/x-mimearchive" | "multipart/related" | "application/vnd.openxmlformats-officedocument" | "application/vnd.openxmlformats-officedocument.presentationml.presentation" | "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" | "application/vnd.openxmlformats-officedocument.wordprocessingml.document" | "application/vnd.ms-outlook" | "text/plain" | "text/tab-separated-values" | "application/xliff+xml",
}

/** Translate Document Request Body. */
model TranslateDocumentRequest {
    /** Actual Document in the form. */
    document: binary[];
    /** Actual glossary in the form. */
    glossary: binary[];
  }

  /** Successful request and the document is translated. The translated document is returned in the body. */
  model TranslateDocumentResult {
    ...CommonResultHeaders;
    /** response conent type */
    @header contentType: "application/octet-stream" | "text/csv" | "text/html" | "text/markdown" | "text/x-markdown" | "message/rfc822" | "application/x-mimearchive" | "multipart/related" | "application/vnd.openxmlformats-officedocument" | "application/vnd.openxmlformats-officedocument.presentationml.presentation" | "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" | "application/vnd.openxmlformats-officedocument.wordprocessingml.document" | "application/vnd.ms-outlook" | "text/plain" | "text/tab-separated-values" | "application/xliff+xml",
    @body
    /** Request response is a document */
    document: bytes;
  }
  