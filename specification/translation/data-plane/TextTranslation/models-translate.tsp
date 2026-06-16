import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models-shared.tsp";
import "./models-transliterate.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

namespace TextTranslation;

@doc("Request parameters for the translate API.")
model TranslateParameters {
  ...CommonParameters;

  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Existing Spec"
  @removed(APIVersion.v2025_10_01_preview)
  @query(#{ explode: true })
  @doc("""
    Specifies the language of the output text. The target language must be one of the supported languages included 
    in the translation scope. For example, use to=de to translate to German.
    It's possible to translate to multiple languages simultaneously by repeating the parameter in the query string. 
    For example, use to=de&to=it to translate to German and Italian.
    """)
  to: string[];

  @removed(APIVersion.v2025_10_01_preview)
  @query
  @doc("""
    Specifies the language of the input text. Find which languages are available to translate from by 
    looking up supported languages using the translation scope. If the from parameter isn't specified, 
    automatic language detection is applied to determine the source language.
    
    You must use the from parameter rather than autodetection when using the dynamic dictionary feature. 
    Note: the dynamic dictionary feature is case-sensitive.
    """)
  from?: string;

  @removed(APIVersion.v2025_10_01_preview)
  @query
  @doc("""
    Defines whether the text being translated is plain text or HTML text. Any HTML needs to be a well-formed, 
    complete element. Possible values are: plain (default) or html.
    """)
  textType?: TextType = "Plain";

  @removed(APIVersion.v2025_10_01_preview)
  @query
  @doc("""
    A string specifying the category (domain) of the translation. This parameter is used to get translations 
    from a customized system built with Custom Translator. Add the Category ID from your Custom Translator 
    project details to this parameter to use your deployed customized system. Default value is: general.
    """)
  category?: string = "general";

  @removed(APIVersion.v2025_10_01_preview)
  @query
  @doc("""
    Specifies how profanities should be treated in translations.
    Possible values are: NoAction (default), Marked or Deleted.
    """)
  profanityAction?: ProfanityAction = ProfanityAction.NoAction;

  @removed(APIVersion.v2025_10_01_preview)
  @query
  @doc("""
    Specifies how profanities should be marked in translations.
    Possible values are: Asterisk (default) or Tag. 
    """)
  profanityMarker?: ProfanityMarker = ProfanityMarker.Asterisk;

  @removed(APIVersion.v2025_10_01_preview)
  @query
  @doc("""
    Specifies whether to include alignment projection from source text to translated text.
    Possible values are: true or false (default).
    """)
  includeAlignment?: boolean = false;

  @removed(APIVersion.v2025_10_01_preview)
  @query
  @doc("""
    Specifies whether to include sentence boundaries for the input text and the translated text.
    Possible values are: true or false (default).
    """)
  includeSentenceLength?: boolean = false;

  @removed(APIVersion.v2025_10_01_preview)
  @query
  @doc("""
    Specifies a fallback language if the language of the input text can't be identified. 
    Language autodetection is applied when the from parameter is omitted. If detection fails, 
    the suggestedFrom language will be assumed.
    """)
  suggestedFrom?: string;

  @removed(APIVersion.v2025_10_01_preview)
  @query
  @doc("""
    Specifies the script of the input text.
    """)
  fromScript?: string;

  @removed(APIVersion.v2025_10_01_preview)
  @query
  @doc("""
    Specifies the script of the translated text.
    """)
  toScript?: string;

  @removed(APIVersion.v2025_10_01_preview)
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

@doc("Target language and translation configuration parameters.")
@added(APIVersion.v2025_10_01_preview)
model TranslationTarget {
  @doc("""
    Specifies the language of the output text. The target language must be one of the supported languages included 
    in the translation scope. It's possible to translate to multiple languages simultaneously by including 
    multiple string values in the targetsLanguage array.
    """)
  language: string;

  @doc("""
    Specifies the script of the translated text.
    """)
  script?: string;

  @doc("""
    Specifies how profanities should be treated in translations.
    Possible values are: NoAction (default), Marked or Deleted.
    """)
  profanityAction?: ProfanityAction = ProfanityAction.NoAction;

  @doc("""
    Specifies how profanities should be marked in translations.
    Possible values are: Asterisk (default) or Tag. 
    """)
  profanityMarker?: ProfanityMarker = ProfanityMarker.Asterisk;

  @doc("""
    Default is 'general', which uses NMT system.
    'abc-inc-gpt-4o', and 'abc-inc-gpt-4o-mini' are examples of deployment names which use GPT-4o uses or
    GPT-4o-mini model. 'gpt-4o' uses GPT-4o model.
    
    '<custom model id>' uses the custom NMT model tuned by customer.
    'best' system determines which is the best model to use for the request. This intelligence could be introduced
    in future. Customer should have deployed it in their resource.
    
    """)
  deploymentName?: string = "general";

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
  allowFallback?: boolean = true;

  @doc("""
    Defines complexity of LLM prompts to provide high accuracy translation.
    """)
  grade?: string = "basic";

  @doc("""
    Desired tone of target translation.
    """)
  tone?: string;

  @doc("""
    Desired gender of target translation.
    """)
  gender?: string;

  @doc("""
    Reference dataset ID having sentence pair to generate adaptive customized translation.
    """)
  adaptiveDatasetId?: string;

  @doc("""
    Reference text pairs to generate adaptive customized translation.
    """)
  @maxItems(5)
  referenceTextPairs?: ReferenceTextPair[];
}

@doc("Request data for translate.")
@added(APIVersion.v2025_10_01_preview)
model TranslateBody {
  @doc("Array of the input text elements to translate.")
  inputs: TranslateInputItem[];
}

@doc("Element containing the text for translation.")
@added(APIVersion.v2025_10_01_preview)
model TranslateInputItem {
  @doc("Text to translate.")
  text: string;

  @doc("""
    Specifies the script of the input text.
    """)
  script?: string;

  @doc("""
    Specifies the language of the input text. Find which languages are available to translate by 
    looking up supported languages using the translation scope. If the language parameter isn't 
    specified, automatic language detection is applied to determine the source language.
    
    You must use the language parameter rather than autodetection when using the dynamic dictionary feature. 
    Note: the dynamic dictionary feature is case-sensitive.
    """)
  language?: string;

  @doc("""
    Defines whether the text being translated is plain text or HTML text. Any HTML needs to be a well-formed, 
    complete element. Possible values are: plain (default) or html.
    """)
  textType?: TextType = "Plain";

  @doc("""
    Translation target parameters.
    """)
  targets: TranslationTarget[];
}

@doc("Reference text pair to generate adaptive customized translation.")
@added(APIVersion.v2025_10_01_preview)
model ReferenceTextPair {
  @doc("Source reference sentence.")
  source: string;

  @doc("Target reference sentence.")
  target: string;
}

@doc("Response for the translation API.")
@renamedFrom(APIVersion.v2025_10_01_preview, "TranslationResult")
@removed(APIVersion.v2025_10_01_preview)
model TranslationResultV3 {
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

@doc("Response for the translation API.")
@added(APIVersion.v2025_10_01_preview)
model TranslationResult {
  ...CommonResultHeaders;

  @doc("Array of the translated text elements.")
  @visibility(Lifecycle.Read)
  value: TranslatedTextItem[];

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

#suppress "@azure-tools/typespec-azure-core/no-enum" "Azure services should not use the enum keyword."
@doc("Translator profanity actions")
enum ProfanityAction {
  @doc("No Action is taken on profanity")
  NoAction: "NoAction",

  @doc("Profanity is marked.")
  Marked: "Marked",

  @doc("Profanity is deleted from the translated text.")
  Deleted: "Deleted",
}

#suppress "@azure-tools/typespec-azure-core/no-enum" "Azure services should not use the enum keyword."
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
  @renamedFrom(APIVersion.v2025_10_01_preview, "translations")
  @removed(APIVersion.v2025_10_01_preview)
  translationsV3: TranslationText[];

  @doc("""
    An array of translation results. The size of the array matches the number of target 
    languages specified through the to query parameter.
    """)
  @added(APIVersion.v2025_10_01_preview)
  @visibility(Lifecycle.Read)
  translations: TranslationText[];

  @removed(APIVersion.v2025_10_01_preview)
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
  @removed(APIVersion.v2025_10_01_preview)
  @doc("A string representing the language code of the target language.")
  to: string;

  @added(APIVersion.v2025_10_01_preview)
  @doc("A string representing the language code of the target language.")
  language: string;

  @added(APIVersion.v2025_10_01_preview)
  @doc("An integer indicating the number of characters in the source text string")
  sourceCharacters?: int32;

  @added(APIVersion.v2025_10_01_preview)
  @doc("An integer indicating the number of tokens used in generating the translated text")
  instructionTokens?: int32;

  @added(APIVersion.v2025_10_01_preview)
  @doc("An integer indicating the number of tokens used in the source sentence")
  sourceTokens?: int32;

  @added(APIVersion.v2025_10_01_preview)
  @doc("An integer indicating the number of tokens used in the translation response")
  responseTokens?: int32;

  @added(APIVersion.v2025_10_01_preview)
  @doc("An integer indicating the number of tokens used in the target sentence")
  targetTokens?: int32;

  @doc("A string giving the translated text.")
  text: string;

  @removed(APIVersion.v2025_10_01_preview)
  @doc("""
    An object giving the translated text in the script specified by the toScript parameter.
    """)
  transliteration?: TransliteratedText;

  @removed(APIVersion.v2025_10_01_preview)
  @doc("""
    Alignment information.
    """)
  alignment?: TranslatedTextAlignment;

  @removed(APIVersion.v2025_10_01_preview)
  @doc("""
    Sentence boundaries in the input and output texts.
    """)
  sentLen?: SentenceBoundaries;
}

@removed(APIVersion.v2025_10_01_preview)
@doc("Alignment information object.")
model TranslatedTextAlignment {
  @doc("""
    Maps input text to translated text. The alignment information is only provided when the request 
    parameter includeAlignment is true. Alignment is returned as a string value of the following 
    format: [[SourceTextStartIndex]:[SourceTextEndIndex]–[TgtTextStartIndex]:[TgtTextEndIndex]]. 
    The colon separates start and end index, the dash separates the languages, and space separates the words. 
    One word may align with zero, one, or multiple words in the other language, and the aligned words may 
    be non-contiguous. When no alignment information is available, the alignment element will be empty.
    """)
  proj: string;
}

@removed(APIVersion.v2025_10_01_preview)
@doc("An object returning sentence boundaries in the input and output texts.")
model SentenceBoundaries {
  @doc("""
    An integer array representing the lengths of the sentences in the input text. 
    The length of the array is the number of sentences, and the values are the length of each sentence.
    """)
  srcSentLen: int32[];

  @doc("""
    An integer array representing the lengths of the sentences in the translated text. 
    The length of the array is the number of sentences, and the values are the length of each sentence.
    """)
  transSentLen: int32[];
}

@removed(APIVersion.v2025_10_01_preview)
@doc("Input text in the default script of the source language. ")
model SourceText {
  @doc("""
    Input text in the default script of the source language.
    """)
  text: string;
}
