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
@@access(DocumentTranslation.DocumentTranslateResult,
  Access.internal,
  "python"
);
@@access(DocumentTranslation.FileFormatType, Access.internal, "python");
@@access(DocumentTranslation.StorageSource, Access.internal, "python");
@@access(DocumentTranslation.AdditionalOutputFileFormat,
  Access.internal,
  "python"
);
@@access(DocumentTranslation.StorageInputType, Access.internal, "python");
@@access(DocumentTranslation.TranslationErrorCode, Access.internal, "python");
@@access(DocumentTranslation.Status, Access.internal, "python");
@@access(DocumentTranslation.StartTranslationDetails,
  Access.internal,
  "python"
);
@@access(DocumentTranslation.BatchRequest, Access.internal, "python");
@@access(DocumentTranslation.SourceInput, Access.internal, "python");
@@access(DocumentTranslation.DocumentFilter, Access.internal, "python");
@@access(DocumentTranslation.TargetInput, Access.internal, "python");
@@access(DocumentTranslation.Glossary, Access.internal, "python");
@@access(DocumentTranslation.TranslationErrorResponse,
  Access.internal,
  "python"
);
@@access(DocumentTranslation.TranslationError, Access.internal, "python");
@@access(DocumentTranslation.InnerTranslationError, Access.internal, "python");
@@access(DocumentTranslation.TranslationsStatus, Access.internal, "python");
@@access(DocumentTranslation.TranslationStatus, Access.internal, "python");
@@access(DocumentTranslation.StatusSummary, Access.internal, "python");
@@access(DocumentTranslation.DocumentStatus, Access.internal, "python");
@@access(DocumentTranslation.DocumentsStatus, Access.internal, "python");
@@access(DocumentTranslation.SupportedFileFormats, Access.internal, "python");
@@access(DocumentTranslation.FileFormat, Access.internal, "python");

@@clientName(DocumentTranslation.DocumentTranslateBody.body,
  "documentTranslateContent",
  "csharp,java"
);

@@clientName(DocumentTranslation.StartTranslationBody.body,
  "startTranslationDetails",
  "csharp,java"
);
