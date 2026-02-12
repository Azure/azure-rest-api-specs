import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "./models-shared.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace TextTranslation;

@doc("Request parameters for the transliterate API.")
model TransliterateParameters {
  ...CommonParameters;

  @query
  @doc("""
    Specifies the language of the text to convert from one script to another. 
    Possible languages are listed in the transliteration scope obtained by querying the service 
    for its supported languages.
    """)
  language: string;

  @query
  @doc("""
    Specifies the script used by the input text. Look up supported languages using the transliteration scope,
    to find input scripts available for the selected language.
    """)
  fromScript: string;

  @query
  @doc("""
    Specifies the output script. Look up supported languages using the transliteration scope, to find output 
    scripts available for the selected combination of input language and input script.
    """)
  toScript: string;
}

@doc("Request data for transliterate.")
@added(APIVersion.v2025_10_01_preview)
model TransliterateBody {
  @doc("Array of the input text elements to transliterate.")
  inputs: InputTextItem[];
}

@doc("Response for the transliteration API.")
@renamedFrom(APIVersion.v2025_10_01_preview, "TransliterateResult")
@removed(APIVersion.v2025_10_01_preview)
model TransliterateResultV3 {
  ...CommonResultHeaders;

  @bodyRoot
  @doc("Array of transliterated texts")
  result: TransliteratedText[];
}

@doc("Response for the transliteration API.")
@added(APIVersion.v2025_10_01_preview)
model TransliterateResult {
  ...CommonResultHeaders;

  @doc("Array of transliterated texts")
  @visibility(Lifecycle.Read)
  value: TransliteratedText[];
}

@doc("Transliterated text element.")
model TransliteratedText {
  @doc("A string which is the result of converting the input string to the output script.")
  text: string;

  @doc("A string specifying the script used in the output.")
  script: string;
}
