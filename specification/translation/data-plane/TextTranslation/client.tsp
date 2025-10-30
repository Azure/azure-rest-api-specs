import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(TextTranslation.TranslationLanguage.dir, "Directionality");
@@clientName(TextTranslation.LanguageScript.dir, "Directionality");
