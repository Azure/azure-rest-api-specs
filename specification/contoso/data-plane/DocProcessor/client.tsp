import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// ============================================================================
// Python-specific client customizations for azure-contoso-docprocessor
// APIView: https://spa.apiview.dev/review/3e8f8033385347aeb5771f5c360b4ef8?activeApiRevisionId=91da776d0caa41648d243ea242a08d80
// ============================================================================

// LineNo 99: Rename get_document to get_doc for consistent abbreviation style
@@clientName(Contoso.DocProcessor.Documents.getDocument, "getDoc", "python");

// LineNo 294: Rename process_doc to begin_process_doc to reflect LRO pattern
@@clientName(Contoso.DocProcessor.Documents.processDoc, "beginProcessDoc", "python");

// LineNo 250: Rename create_doc to create_or_update_doc to clarify upsert semantics
@@clientName(Contoso.DocProcessor.Documents.createDoc, "createOrUpdateDoc", "python");

// LineNo 221: Rename ProcessingResult.data to a more descriptive name
@@clientName(Contoso.DocProcessor.ProcessingResult.data, "processingData", "python");
