import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
@server(
  "https://eastus.document.microsofttranslator-int.com",
  "Development endpoint"
)
@useAuth(ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">)
@service({
  title: "Azure.AI.DocumentTranslation",
})
@versioned(DocumentTranslation.Versions)
namespace DocumentTranslation;

/** The Azure.AI.DocumentTranslation versions. */
enum Versions {
  /** The 2023-11-01-preview version of the Azure.AI.DocumentTranslation. */
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  `2023-11-01-preview`,
}

/** Request parameters for the Document Translate. */
model DocumentTranslateParameters {
  /** Use this header to specify the translator resource region. */
  @header("Ocp-Apim-Subscription-Region")
  subscriptionRegion?: string;

  /** Specifies source language of the input document.
   * If this parameter isn't specified, automatic language detection is applied to determine the source language.
   * For example if the source document is written in English, then use sourceLanguage=en */
  @query("SourceLanguage")
  sourceLanguage?: string;

  /** Specifies the language of the output document.
   * The target language must be one of the supported languages included in the translation scope.
   * For example if you want to translate the document in German language, then use targetLanguage=de */
  @query("TargetLanguage")
  targetLanguage: string;

  /** A string specifying the category (domain) of the translation. This parameter is used to get translations 
    from a customized system built with Custom Translator. Add the Category ID from your Custom Translator 
    project details to this parameter to use your deployed customized system. Default value is: general. */
  @query("Category")
  category?: string = "general";

  /** Specifies that the service is allowed to fall back to a general system when a custom system doesn't exist. 
    Possible values are: true (default) or false.
    allowFallback=false specifies that the translation should only use systems trained for the category specified 
    by the request. If a translation for language X to language Y requires chaining through a pivot language E, 
    then all the systems in the chain (X → E and E → Y) will need to be custom and have the same category. 
    If no system is found with the specific category, the request will return a 400 status code. allowFallback=true 
    specifies that the service is allowed to fall back to a general system when a custom system doesn't exist. */
  @query("AllowFallback")
  allowFallback?: boolean;

  /** Content Type as multipart/form-data */
  @header contentType: "multipart/form-data";

  /** Document to be translated in the form */
  document: bytes;

  /** Glossary / translation memory will be used during translation in the form. */
  glossary?: bytes;
}

/** Successful request and the document is translated. The translated document is returned in the body. */
model DocumentTranslateResult {
  /** response content type */
  @header
  contentType: "application/octet-stream";

  /** Request response, response is a translated document. */
  @body
  document: bytes;
}

alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;

/** API to translate a document. */
#suppress "@azure-tools/typespec-azure-core/byos"
@post
@route("document:translate")
op documentTanslate is RpcOperation<
  DocumentTranslateParameters,
  DocumentTranslateResult,
  ServiceTraits
>;
