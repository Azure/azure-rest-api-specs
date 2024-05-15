/**
 * PLACEHOLDER
 * Add readme and sample
 */
import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@TypeSpec.Versioning.useDependency(DocumentTranslation.Versions.v2024_05_01)
namespace ClientCustomizations;

@client({
  name: "DocumentTranslationClient",
  service: DocumentTranslation,
})
interface DocumentTranslationClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  startTranslation is DocumentTranslation.DocumentTranslationOperations.startTranslation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getTranslationsStatus is DocumentTranslation.DocumentTranslationOperations.getTranslationsStatus;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getDocumentStatus is DocumentTranslation.DocumentTranslationOperations.getDocumentStatus;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getTranslationStatus is DocumentTranslation.DocumentTranslationOperations.getTranslationStatus;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  cancelTranslation is DocumentTranslation.DocumentTranslationOperations.cancelTranslation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getDocumentsStatus is DocumentTranslation.DocumentTranslationOperations.getDocumentsStatus;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getSupportedFormats is DocumentTranslation.DocumentTranslationOperations.getSupportedFormats;
}

@client({
  name: "SingleDocumentTranslationClient",
  service: DocumentTranslation,
})
interface SingleDocumentTranslationClient {
  #suppress "@azure-tools/typespec-azure-core/byos"
  documentTranslate is DocumentTranslation.DocumentTranslationOperations.documentTranslate;
}

// model overrides
@@access(DocumentTranslation.TranslationStatus, Access.internal, "python");
@@access(DocumentTranslation.DocumentStatus, Access.internal, "python");