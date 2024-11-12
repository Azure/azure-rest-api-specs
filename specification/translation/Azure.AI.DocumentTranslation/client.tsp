/**
 * PLACEHOLDER
 * Add readme and sample
 */
import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@TypeSpec.Versioning.useDependency(DocumentTranslation.Versions.v2024_05_01)
namespace ClientCustomizations;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
@summary("Returns a list of batch requests submitted and the status for each request")
@doc("""
  Returns a list of batch requests submitted and the status for each
  request.
  This list only contains batch requests submitted by the user (based on
  the resource).
              
  If the number of requests exceeds our paging limit,
  server-side paging is used. Paginated responses indicate a partial result and
  include a continuation token in the response.
  The absence of a continuation
  token means that no additional pages are available.
              
  top, skip
  and maxpagesize query parameters can be used to specify a number of results to
  return and an offset for the collection.
              
  top indicates the total
  number of records the user wants to be returned across all pages.
  skip
  indicates the number of records to skip from the list of batches based on the
  sorting method specified.  By default, we sort by descending start
  time.
  maxpagesize is the maximum items returned in a page.  If more items are
  requested via top (or top is not specified and there are more items to be
  returned), @nextLink will contain the link to the next page.
              
  
  orderby query parameter can be used to sort the returned list (ex
  \"orderby=createdDateTimeUtc asc\" or \"orderby=createdDateTimeUtc
  desc\").
  The default sorting is descending by createdDateTimeUtc.
  Some query
  parameters can be used to filter the returned list (ex:
  \"status=Succeeded,Cancelled\") will only return succeeded and cancelled
  operations.
  createdDateTimeUtcStart and createdDateTimeUtcEnd can be used
  combined or separately to specify a range of datetime to filter the returned
  list by.
  The supported filtering query parameters are (status, ids,
  createdDateTimeUtcStart, createdDateTimeUtcEnd).
              
  The server honors
  the values specified by the client. However, clients must be prepared to handle
  responses that contain a different page size or contain a continuation token.
    
            
  When both top and skip are included, the server should first apply
  skip and then top on the collection.
  Note: If the server can't honor top
  and/or skip, the server must return an error to the client informing about it
  instead of just ignoring the query options.
  This reduces the risk of the client
  making assumptions about the data returned.
  """)
@route("/document/batches")
op getTranslationsStatus(options: DocumentTranslation.GetTranslationsStatusOptions): DocumentTranslation.TranslationsStatus;

@@override(DocumentTranslation.DocumentTranslationOperations.getTranslationsStatus, ClientCustomizations.DocumentTranslationClient.getTranslationsStatus, "java");

@client({
  name: "DocumentTranslationClient",
  service: DocumentTranslation,
})
interface DocumentTranslationClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  startTranslation is DocumentTranslation.DocumentTranslationOperations.startTranslation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
  getTranslationsStatus is DocumentTranslation.DocumentTranslationOperations.getTranslationsStatus;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getDocumentStatus is DocumentTranslation.DocumentTranslationOperations.getDocumentStatus;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  getTranslationStatus is DocumentTranslation.DocumentTranslationOperations.getTranslationStatus;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
  cancelTranslation is DocumentTranslation.DocumentTranslationOperations.cancelTranslation;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing name"
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

@@clientName(SingleDocumentTranslationClient.documentTranslate, "translate");

@@clientName(DocumentTranslation.StatusSummary, "translationStatusSummary");

@@clientName(DocumentTranslation.StorageSource, "translationStorageSource");

@@clientName(DocumentTranslation.DocumentTranslateBody.body,
  "documentTranslateContent",
  "csharp, java"
);

@@clientName(DocumentTranslation.StartTranslationDetails,
  "translationBatch",
  "csharp, java"
);

@@clientName(DocumentTranslation.SourceInput,
  "TranslationSource",
  "csharp, java"
);

@@clientName(DocumentTranslation.TargetInput,
  "TranslationTarget",
  "csharp, java"
);

@@clientName(DocumentTranslation.BatchRequest, "documentBatch", "python");

@@convenientAPI(DocumentTranslationClient.getSupportedFormats, false, "java");

@@access(DocumentTranslationClient.getSupportedFormats,
  Access.internal,
  "python"
);
@@access(DocumentTranslation.SupportedFileFormats, Access.internal, "java");
@@usage(DocumentTranslation.SupportedFileFormats, Usage.output, "java");

@@access(DocumentTranslation.FileFormat, Access.public, "java");
@@usage(DocumentTranslation.FileFormat, Usage.output, "java");

@@access(DocumentTranslation.FileFormatType, Access.public, "java");
@@usage(DocumentTranslation.FileFormatType, Usage.output, "java");

@@access(DocumentTranslation.FileFormat, Access.public, "python");
@@usage(DocumentTranslation.FileFormat, Usage.output, "python");
@@access(DocumentTranslation.FileFormatType, Access.public, "python");
@@usage(DocumentTranslation.FileFormatType, Usage.output, "python");

@@clientName(DocumentTranslationClient.startTranslation,
  "_begin_translation",
  "python"
);

@@clientName(DocumentTranslationClient.getDocumentsStatus,
  "list_document_statuses",
  "python"
);

@@clientName(DocumentTranslationClient.getTranslationsStatus,
  "list_translation_statuses",
  "python"
);

@@clientName(DocumentTranslation.TranslationStatus.createdDateTimeUtc,
  "created_on",
  "python"
);

@@clientName(DocumentTranslation.TranslationStatus.lastActionDateTimeUtc,
  "last_updated_on",
  "python"
);

@@clientName(DocumentTranslation.Glossary.format, "file_format", "python");

@@clientName(DocumentTranslation.Glossary.version, "format_version", "python");

@@clientName(DocumentTranslation.Glossary,
  "TranslationGlossary",
  "python, java"
);

@@clientName(DocumentTranslation.DocumentStatus.createdDateTimeUtc,
  "created_on",
  "python"
);

@@clientName(DocumentTranslation.DocumentStatus.lastActionDateTimeUtc,
  "last_updated_on",
  "python"
);

@@clientName(DocumentTranslation.DocumentStatus.path,
  "translated_document_url",
  "python"
);

@@clientName(DocumentTranslation.DocumentStatus.sourcePath,
  "source_document_url",
  "python"
);

@@clientName(DocumentTranslation.DocumentStatus.to, "translated_to", "python");

@@clientName(DocumentTranslation.DocumentStatus.progress,
  "translation_progress",
  "python"
);

@@clientName(DocumentTranslation.DocumentStatus.characterCharged,
  "characters_charged",
  "python"
);

@@clientName(DocumentTranslation.StatusSummary.totalCharacterCharged,
  "total_characters_charged",
  "python"
);

@@clientName(DocumentTranslation.StatusSummary.cancelled, "canceled", "python");

@@clientName(DocumentTranslation.FileFormat.format, "file_format", "python");

@@clientName(DocumentTranslation.FileFormat.defaultVersion,
  "default_format_version",
  "python"
);

@@clientName(DocumentTranslation.FileFormat.versions,
  "format_versions",
  "python"
);

@@clientName(DocumentTranslation.FileFormat,
  "DocumentTranslationFileFormat",
  "python"
);

@@clientName(DocumentTranslation.TargetInput.category, "category_id", "python");

@@clientName(DocumentTranslation.TargetInput, "TranslationTarget", "python");

@@clientName(DocumentTranslation.TranslationError,
  "DocumentTranslationError",
  "python"
);

@@clientName(DocumentTranslation.Status.Cancelled, "canceled", "python");

@@clientName(DocumentTranslation.Status.Cancelling, "canceling", "python");

@@clientName(DocumentTranslation.BatchRequest,
  "documentTranslationInput",
  "java"
);

@@clientName(DocumentTranslationClient.startTranslation, "translation", "java");

@@clientName(DocumentTranslationClient.getDocumentsStatus,
  "listDocumentStatuses",
  "java"
);

@@clientName(DocumentTranslationClient.getTranslationsStatus,
  "listTranslationStatuses",
  "java"
);

@@clientName(DocumentTranslation.TranslationStatus,
  "translationStatusResult",
  "java"
);

@@clientName(DocumentTranslation.DocumentStatus,
  "documentStatusResult",
  "java"
);

@@clientName(DocumentTranslation.Status, "translationStatus", "java");

@@clientName(DocumentTranslation.TranslationStatus.createdDateTimeUtc,
  "createdOn",
  "java"
);

@@clientName(DocumentTranslation.TranslationStatus.lastActionDateTimeUtc,
  "lastUpdatedOn",
  "java"
);

@@clientName(DocumentTranslation.StatusSummary.cancelled,
  "cancelledCount",
  "java"
);

@@clientName(DocumentTranslation.StatusSummary.failed, "failedCount", "java");

@@clientName(DocumentTranslation.StatusSummary.inProgress,
  "inProgressCount",
  "java"
);

@@clientName(DocumentTranslation.StatusSummary.notYetStarted,
  "notYetStartedCount",
  "java"
);

@@clientName(DocumentTranslation.StatusSummary.success, "successCount", "java");

@@clientName(DocumentTranslation.StatusSummary.total, "totalCount", "java");

@@clientName(DocumentTranslation.StatusSummary.totalCharacterCharged,
  "totalCharactersChargedCount",
  "java"
);
