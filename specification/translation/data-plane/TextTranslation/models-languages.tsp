import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models-shared.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace TextTranslation;

@doc("Request parameters for the language API.")
model GetSupportedLanguagesParameters {
  ...CommonParameters;

  @query
  @doc("""
    A comma-separated list of names defining the group of languages to return.
    Allowed group names are: `translation`, `transliteration` and `dictionary`.
    If no scope is given, then all groups are returned, which is equivalent to passing 
    `scope=translation,transliteration,dictionary`. To decide which set of supported languages 
    is appropriate for your scenario, see the description of the [response object](#response-body).
    """)
  scope?: string;

  @header("Accept-Language")
  @doc("""
    The language to use for user interface strings. Some of the fields in the response are names of languages or 
    names of regions. Use this parameter to define the language in which these names are returned. 
    The language is specified by providing a well-formed BCP 47 language tag. For instance, use the value `fr` 
    to request names in French or use the value `zh-Hant` to request names in Chinese Traditional.
    Names are provided in the English language when a target language is not specified or when localization 
    is not available.
    """)
  acceptLanguage?: string = "en";

  @header("If-None-Match")
  @doc("""
    Passing the value of the ETag response header in an If-None-Match field will allow the service to optimize the response. 
    If the resource has not been modified, the service will return status code 304 and an empty response body.
    """)
  ifNoneMatch?: string;
}

@doc("Response for the languages API.")
model GetSupportedLanguagesResult {
  ...CommonResultHeaders;

  @header("ETag")
  @doc("""
    Current value of the entity tag for the requested groups of supported languages. 
    To make subsequent requests more efficient, the client may send the `ETag` value in an 
    `If-None-Match` header field.
    """)
  etag: eTag;

  @doc("Languages that support translate API.")
  @renamedFrom(APIVersion.v2025_10_01_preview, "translation")
  @removed(APIVersion.v2025_10_01_preview)
  translationV3?: Record<TranslationLanguage>;

  @doc("Languages that support transliteration API.")
  @renamedFrom(APIVersion.v2025_10_01_preview, "transliteration")
  @removed(APIVersion.v2025_10_01_preview)
  transliterationV3?: Record<TransliterationLanguage>;

  @doc("Languages that support translate API.")
  @added(APIVersion.v2025_10_01_preview)
  @visibility(Lifecycle.Read)
  translation?: Record<TranslationLanguage>;

  @doc("Languages that support transliteration API.")
  @added(APIVersion.v2025_10_01_preview)
  @visibility(Lifecycle.Read)
  transliteration?: Record<TransliterationLanguage>;

  @doc("Languages that support dictionary API.")
  @removed(APIVersion.v2025_10_01_preview)
  dictionary?: Record<SourceDictionaryLanguage>;

  @doc("LLM models supported.")
  @added(APIVersion.v2025_10_01_preview)
  @visibility(Lifecycle.Read)
  models?: string[];
}

alias BaseLanguage = {
  @doc("Display name of the language in the locale requested via Accept-Language header.")
  name: string;

  @doc("Display name of the language in the locale native for this language.")
  nativeName: string;
};

@doc("""
  The value of the translation property is a dictionary of (key, value) pairs. Each key is a BCP 47 language tag.
  A key identifies a language for which text can be translated to or translated from.
  """)
model TranslationLanguage {
  ...BaseLanguage;

  @doc("Directionality, which is rtl for right-to-left languages or ltr for left-to-right languages.")
  dir: LanguageDirectionality;

  @doc("LLM models supported for translation.")
  @added(APIVersion.v2025_10_01_preview)
  @visibility(Lifecycle.Read)
  models: string[];
}

@doc("""
  The value of the transliteration property is a dictionary of (key, value) pairs. 
  Each key is a BCP 47 language tag. A key identifies a language for which text can be converted from one script 
  to another script.
  """)
model TransliterationLanguage {
  ...BaseLanguage;

  @doc("List of scripts to convert from.")
  @removed(APIVersion.v2025_10_01_preview)
  @renamedFrom(APIVersion.v2025_10_01_preview, "scripts")
  scriptsV3: TransliterableScript[];

  @doc("List of scripts to convert from.")
  @added(APIVersion.v2025_10_01_preview)
  @visibility(Lifecycle.Read)
  scripts: TransliterableScript[];
}

@doc("Script definition with list of script into which given script can be translitered.")
model TransliterableScript extends LanguageScript {
  @doc("List of scripts available to convert text to.")
  toScripts: LanguageScript[];
}

@doc("Common properties of language script")
model LanguageScript {
  @doc("Code identifying the script.")
  code: string;

  @doc("Display name of the script in the locale requested via Accept-Language header.")
  name: string;

  @doc("Display name of the language in the locale native for the language.")
  nativeName: string;

  @doc("Directionality, which is rtl for right-to-left languages or ltr for left-to-right languages.")
  dir: LanguageDirectionality;
}

@doc("Properties ot the source dictionary language")
@removed(APIVersion.v2025_10_01_preview)
model SourceDictionaryLanguage {
  ...BaseLanguage;

  @doc("Directionality, which is rtl for right-to-left languages or ltr for left-to-right languages.")
  dir: LanguageDirectionality;

  @doc("List of languages with alterative translations and examples for the query expressed in the source language.")
  translations: TargetDictionaryLanguage[];
}

@doc("Properties of the target dictionary language")
@removed(APIVersion.v2025_10_01_preview)
model TargetDictionaryLanguage {
  ...BaseLanguage;

  @doc("Directionality, which is rtl for right-to-left languages or ltr for left-to-right languages.")
  dir: LanguageDirectionality;

  @doc("Language code identifying the target language.")
  code: string;
}

#suppress "@azure-tools/typespec-azure-core/no-enum" "Azure services should not use the enum keyword."
@doc("Language Directionality")
enum LanguageDirectionality {
  @doc("Language is written left to right.")
  LeftToRight: "ltr",

  @doc("Language is written right to left.")
  RightToLeft: "rtl",
}
