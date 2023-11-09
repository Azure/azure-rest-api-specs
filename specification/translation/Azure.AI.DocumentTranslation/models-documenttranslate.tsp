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
    /** Specifies the language of the input document. If the from parameter isn't specified, 
    automatic language detection is applied to determine the source language. */
    @query("From")
    from?: string,

    /** Specifies the language of the output docuement. The target language must be one of the supported languages included 
    in the translation scope. For example, use to=de to translate to German. */
    @query("To")
    to: string,

    /** A string specifying the category (domain) of the translation. This parameter is used to get translations 
    from a customized system built with Custom Translator. Add the Category ID from your Custom Translator 
    project details to this parameter to use your deployed customized system. Default value is: general. */
    @query("Category")
    category?: string = "generalnn",

    /** Specifies that the service is allowed to fall back to a generalnn system when a custom system doesn't exist. 
    Possible values are: true (default) or false.
    allowFallback=false specifies that the translation should only use systems trained for the category specified 
    by the request. If a translation for language X to language Y requires chaining through a pivot language E, 
    then all the systems in the chain (X → E and E → Y) will need to be custom and have the same category. 
    If no system is found with the specific category, the request will return a 400 status code. allowFallback=true 
    specifies that the service is allowed to fall back to a generalnn system when a custom system doesn't exist. */
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
    glossary?: bytes;
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
  