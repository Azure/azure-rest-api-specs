/**
 * PLACEHOLDER
 * Add readme and sample
 */
import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
@TypeSpec.Versioning.useDependency(DocumentTranslation.Versions.v2024_05_01)
namespace ClientCustomizations;

@added(DocumentTranslation.Versions.v2024_05_01)
@client({
  name: "DocumentTranslationClient",
  service: DocumentTranslation,
})
interface DocumentTranslationClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  startTranslation is DocumentTranslation.DocumentTranslationOperations.startTranslation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getTranslationsStatus is DocumentTranslation.DocumentTranslationOperations.startTranslation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getDocumentStatus is DocumentTranslation.DocumentTranslationOperations.startTranslation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getTranslationStatus is DocumentTranslation.DocumentTranslationOperations.startTranslation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  cancelTranslation is DocumentTranslation.DocumentTranslationOperations.startTranslation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getDocumentsStatus is DocumentTranslation.DocumentTranslationOperations.startTranslation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getSupportedDocumentFormats is DocumentTranslation.DocumentTranslationOperations.startTranslation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getSupportedGlossaryFormats is DocumentTranslation.DocumentTranslationOperations.startTranslation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getSupportedStorageSources is DocumentTranslation.DocumentTranslationOperations.startTranslation;
}

@client({
  name: "SingleDocumentTranslationClient",
  service: DocumentTranslation,
})
interface SingleDocumentTranslationClient {
  #suppress "@azure-tools/typespec-azure-core/byos"
  documentTranslate is DocumentTranslation.documentTranslate;
}
