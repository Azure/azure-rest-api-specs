import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models-shared.tsp";
import "./models-transliterate.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace TextTranslation;

@doc("Request body parameters for the translate API.")
model TranslateBodyParameters {
  ...CommonParameters;

  @doc("""
    Details of the translate request
    """)
  @body
  body: TranslateBodyDetails;
}

@doc("Request parameters for the translate API.")
model TranslateParameters {
  ...CommonParameters;

  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Existing Spec"
  @query(#{ explode: true })
  @doc("""
    Specifies the language of the output text. The target language must be one of the supported languages included 
    in the translation scope. For example, use to=de to translate to German.
    It's possible to translate to multiple languages simultaneously by repeating the parameter in the query string. 
    For example, use to=de&to=it to translate to German and Italian.
    """)
  to: string[];

  @query
  @doc("""
    Specifies the language of the input text. Find which languages are available to translate from by 
    looking up supported languages using the translation scope. If the from parameter isn't specified, 
    automatic language detection is applied to determine the source language.
    
    You must use the from parameter rather than autodetection when using the dynamic dictionary feature. 
    Note: the dynamic dictionary feature is case-sensitive.
    """)
  from?: string;

  @query
  @doc("""
    Defines whether the text being translated is plain text or HTML text. Any HTML needs to be a well-formed, 
    complete element. Possible values are: plain (default) or html.
    """)
  textType?: TextType = "Plain";

  @query
  @doc("""
    A string specifying the category (domain) of the translation. This parameter is used to get translations 
    from a customized system built with Custom Translator. Add the Category ID from your Custom Translator 
    project details to this parameter to use your deployed customized system. Default value is: general.
    """)
  category?: string = "general";

  @query
  @doc("""
    Specifies how profanities should be treated in translations.
    Possible values are: NoAction (default), Marked or Deleted.
    """)
  profanityAction?: ProfanityAction = ProfanityAction.NoAction;

  @query
  @doc("""
    Specifies how profanities should be marked in translations.
    Possible values are: Asterisk (default) or Tag. 
    """)
  profanityMarker?: ProfanityMarker = ProfanityMarker.Asterisk;

  @query
  @doc("""
    Specifies whether to include alignment projection from source text to translated text.
    Possible values are: true or false (default).
    """)
  includeAlignment?: boolean = false;

  @query
  @doc("""
    Specifies whether to include sentence boundaries for the input text and the translated text.
    Possible values are: true or false (default).
    """)
  includeSentenceLength?: boolean = false;

  @query
  @doc("""
    Specifies a fallback language if the language of the input text can't be identified. 
    Language autodetection is applied when the from parameter is omitted. If detection fails, 
    the suggestedFrom language will be assumed.
    """)
  suggestedFrom?: string;

  @query
  @doc("""
    Specifies the script of the input text.
    """)
  fromScript?: string;

  @query
  @doc("""
    Specifies the script of the translated text.
    """)
  toScript?: string;

  @query
  @doc("""
    Specifies that the service is allowed to fall back to a general system when a custom system doesn't exist. 
    Possible values are: true (default) or false.
    
    allowFallback=false specifies that the translation should only use systems trained for the category specified 
    by the request. If a translation for language X to language Y requires chaining through a pivot language E, 
    then all the systems in the chain (X → E and E → Y) will need to be custom and have the same category. 
    If no system is found with the specific category, the request will return a 400 status code. allowFallback=true 
    specifies that the service is allowed to fall back to a general system when a custom system doesn't exist.
    """)
  allowFallback?: boolean = true;
}

@doc("Request body parameters for the translate API.")
model TranslateBodyDetails {
  @doc("""
    Specifies the text string to be translated in the translate API.
    """)
  text: InputTextItem[];

  @doc("""
    Specifies the language of the output text. The target language must be one of the supported languages included 
    in the translation scope. It's possible to translate to multiple languages simultaneously by including 
    multiple string values in the targetsLanguage array.
    """)
  targetsLanguage: string[];

  @doc("""
    Defines whether the text being translated is plain text or HTML text. Any HTML needs to be a well-formed, 
    complete element. Possible values are: plain (default) or html.
    """)
  targetsTextType?: TextType = "Plain";

  @doc("""
    Specifies how profanities should be treated in translations.
    Possible values are: NoAction (default), Marked or Deleted.
    """)
  targetsProfanityAction?: ProfanityAction = ProfanityAction.NoAction;

  @doc("""
    Specifies how profanities should be marked in translations.
    Possible values are: Asterisk (default) or Tag. 
    """)
  targetsProfanityMarker?: ProfanityMarker = ProfanityMarker.Asterisk;

  @doc("""
    Specifies the script of the input text.
    """)
  script?: string;

  @doc("""
    Specifies the script of the translated text.
    """)
  targetsScript?: string;

  @doc("""
    Model that should be used for translation.
    """)
  targetsdeploymentNameModel?: string;

  @doc("""
    In the case where a custom system is being used, specifies that the service is allowed to fall back to a
    general system when a custom system doesn't exist. 
    In the case where a Large Language Model is being used, specifies that the service is allowed to fall
    back to a Small Language Model if an error occurs.
    Possible values are: true (default) or false.
    
    allowFallback=false specifies that the translation should only use systems trained for the category specified 
    by the request. If a translation for language X to language Y requires chaining through a pivot language E, 
    then all the systems in the chain (X → E and E → Y) will need to be custom and have the same category. 
    If no system is found with the specific category, the request will return a 400 status code. allowFallback=true 
    specifies that the service is allowed to fall back to a general system when a custom system doesn't exist.
    """)
  targetsAllowFallback?: boolean = true;

  @doc("""
    Defines complexity of LLM prompts to provide high accuracy translation.
    """)
  targetsGrade?: string;

  @doc("""
    Desired tone of target translation.
    """)
  targetsTone?: string;

  @doc("""
    Desired gender of target translation.
    """)
  targetsGender?: string;

  @doc("""
    Reference dataset ID having sentence pair to generate adaptive customized translation.
    """)
  targetsAdaptiveDatasetIds?: string[];

  @doc("""
      Reference sentence pairs to generate adaptive results.
    """)
  targetsReferenceTextPairs?: ReferenceSentencePair[];
}

@doc("Reference sentence pair.")
model ReferenceSentencePair {
  @doc("Source reference sentence.")
  targetsReferenceTextPairsSource: string;

  @doc("Target reference sentence.")
  targetsReferenceTextPairsTarget: string;
}

@doc("Response for the translation API.")
model TranslationResult {
  ...CommonResultHeaders;

  @bodyRoot
  @doc("Array of the translated text elements.")
  result: TranslatedTextItem[];

  @header("x-mt-system")
  @doc("""
    Specifies the system type that was used for translation for each 'to' language requested for translation. 
    The value is a comma-separated list of strings. Each string indicates a type:
    
    * Custom - Request includes a custom system and at least one custom system was used during translation.
    * Team - All other requests
    """)
  mtSystem: string;

  @header("x-metered-usage")
  @doc("""
    Specifies consumption (the number of characters for which the user will be charged) for the translation 
    job request. For example, if the word "Hello" is translated from English (en) to French (fr), 
    this field will return the value '5'.
    """)
  meteredUsage: int32;
}

@doc("Translation text type")
union TextType {
  string,

  @doc("Plain text.")
  Plain: "Plain",

  @doc("HTML-encoded text.")
  Html: "Html",
}

#suppress "@azure-tools/typespec-azure-core/use-extensible-enum" "Enums should be defined without the `@fixed` decorator."
#suppress "@azure-tools/typespec-azure-core/no-enum" "Azure services should not use the enum keyword."
@fixed
@doc("Translator profanity actions")
enum ProfanityAction {
  @doc("No Action is taken on profanity")
  NoAction: "NoAction",

  @doc("Profanity is marked.")
  Marked: "Marked",

  @doc("Profanity is deleted from the translated text.")
  Deleted: "Deleted",
}

#suppress "@azure-tools/typespec-azure-core/use-extensible-enum" "Enums should be defined without the `@fixed` decorator."
#suppress "@azure-tools/typespec-azure-core/no-enum" "Azure services should not use the enum keyword."
@fixed
@doc("Translator profanity markers")
enum ProfanityMarker {
  @doc("Profanity is marked with asterisk.")
  Asterisk: "Asterisk",

  @doc("Profanity is marked with the tags.")
  Tag: "Tag",
}

@doc("Element containing the translated text")
model TranslatedTextItem {
  @doc("The detectedLanguage property is only present in the result object when language auto-detection is requested.")
  detectedLanguage?: DetectedLanguage;

  @doc("""
    An array of translation results. The size of the array matches the number of target 
    languages specified through the to query parameter.
    """)
  translations: TranslationText[];

  @doc("""
    Input text in the default script of the source language. sourceText property is present only when 
    the input is expressed in a script that's not the usual script for the language. For example, 
    if the input were Arabic written in Latin script, then sourceText.text would be the same Arabic text 
    converted into Arab script.
    """)
  sourceText?: SourceText;
}

@doc("An object describing the detected language.")
model DetectedLanguage {
  @doc("A string representing the code of the detected language.")
  language: string;

  @doc("""
    A float value indicating the confidence in the result.
    The score is between zero and one and a low score indicates a low confidence.
    """)
  score: float32;
}

@doc("Translation result")
model TranslationText {
  @doc("A string representing the language code of the target language.")
  to: string;

  @doc("A string giving the translated text.")
  text: string;

  @doc("""
    An object giving the translated text in the script specified by the toScript parameter.
    """)
  transliteration?: TransliteratedText;
}

@doc("Input text in the default script of the source language. ")
model SourceText {
  @doc("""
    Input text in the default script of the source language.
    """)
  text: string;
}
