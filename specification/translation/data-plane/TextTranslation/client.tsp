import "./main.tsp";
import "./models-breaksentence.tsp";
import "./models-dictionary.tsp";
import "./models-languages.tsp";
import "./models-translate.tsp";
import "./models-transliterate.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(TextTranslation.TranslationLanguage.dir, "Directionality");
@@clientName(TextTranslation.LanguageScript.dir, "Directionality");

@@clientName(TextTranslation.TranslateBody, "TranslateInputs");
@@clientName(TextTranslation.TransliterateBody, "TransliterateInputs");
