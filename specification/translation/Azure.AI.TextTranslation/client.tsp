import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@protocolAPI(TextTranslation.translate, false);
@@protocolAPI(TextTranslation.transliterate, false);
@@protocolAPI(TextTranslation.findSentenceBoundaries, false);
@@protocolAPI(TextTranslation.lookupDictionaryEntries, false);
@@protocolAPI(TextTranslation.lookupDictionaryExamples, false);

@@internal(TextTranslation.translate);
@@internal(TextTranslation.transliterate);
@@internal(TextTranslation.findSentenceBoundaries);
@@internal(TextTranslation.lookupDictionaryEntries);
@@internal(TextTranslation.lookupDictionaryExamples);
