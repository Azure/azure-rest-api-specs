import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.authorizationCode,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/token",
      scopes: ["https://cognitiveservices.azure.com/.default"],
    }
  ]>
)
@service({
  title: "Azure.AI.DocumentTranslation",
})
@server(
  "{Endpoint}",
  "Document Translation Endpoint",
  {
    /** Supported document Translation endpoints (protocol and hostname, for example: https://{TranslatorResourceName}.cognitiveservices.azure.com/translator). */
    Endpoint: url,
  }
)
@versioned(DocumentTranslation.Versions)
namespace DocumentTranslation;

/** The Azure.AI.DocumentTranslation versions. */
enum Versions {
  /** The 2023-11-01-preview version of the Azure.AI.DocumentTranslation. */
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  `2023-11-01-preview`,
}

/** Document Translate Request / Content. */
model DocumentTranslateContent {
  /** Specifies source language of the input document.
   * If this parameter isn't specified, automatic language detection is applied to determine the source language.
   * For example if the source document is written in English, then use sourceLanguage=en */
  @query("sourceLanguage")
  sourceLanguage?: string;

  /** Specifies the language of the output document.
   * The target language must be one of the supported languages included in the translation scope.
   * For example if you want to translate the document in German language, then use targetLanguage=de */
  @query("targetLanguage")
  targetLanguage: string;

  /** A string specifying the category (domain) of the translation. This parameter is used to get translations 
    from a customized system built with Custom Translator. Add the Category ID from your Custom Translator 
    project details to this parameter to use your deployed customized system. Default value is: general. */
  @query("category")
  category?: string = "general";

  /** Specifies that the service is allowed to fall back to a general system when a custom system doesn't exist. 
    Possible values are: true (default) or false. */
  @query("allowFallback")
  allowFallback?: boolean;

  /** Content Type as multipart/form-data */
  @header contentType: "multipart/form-data";

  /** Document to be translated in the form */
  document: bytes;

  /** Glossary / translation memory will be used during translation in the form. */
  glossary?: bytes[];
}

/** Document Translate Result / Response. */
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
op documentTranslate is RpcOperation<
  DocumentTranslateContent,
  DocumentTranslateResult,
  ServiceTraits
>;
