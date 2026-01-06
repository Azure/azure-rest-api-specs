import "@typespec/rest";
import "@typespec/http";

namespace Genome;

/**
 * Upload type indicating whether the upload is internal or external
 */
union UploadType {
  string,

  /**
   * Internal
   */
  Internal: "Internal",

  /**
   * External
   */
  External: "External",
}

/**
 * Categories of documents that can be associated with trade, logistics,
 * compliance, auditing, and facility operations
 */
union DocumentCategory {
  string,

  /**
   * CommercialInvoice
   */
  CommercialInvoice: "CommercialInvoice",

  /**
   * Receipt
   */
  Receipt: "Receipt",

  /**
   * Report
   */
  Report: "Report",

  /**
   * Other
   */
  Other: "Other",

  /**
   * BillOfLading
   */
  BillOfLading: "BillOfLading",

  /**
   * PackingList
   */
  PackingList: "PackingList",

  /**
   * CertificateOfOrigin
   */
  CertificateOfOrigin: "CertificateOfOrigin",

  /**
   * CBPForm7501
   */
  CBPForm7501: "CBPForm7501",

  /**
   * ThirdPartyAuditReport
   */
  ThirdPartyAuditReport: "ThirdPartyAuditReport",

  /**
   * FacilityDocumentation
   */
  FacilityDocumentation: "FacilityDocumentation",
}

/**
 * Document state indicating the current processing state of documents
 */
union DocumentState {
  string,

  /**
   * Uploaded
   */
  Uploaded: "Uploaded",

  /**
   * AllDuplicates
   */
  AllDuplicates: "AllDuplicates",

  /**
   * NoFiles
   */
  NoFiles: "NoFiles",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Processing
   */
  Processing: "Processing",

  /**
   * Failed
   */
  Failed: "Failed",
}

/** Request body for uploading documents */
model UploadDocumentsRequest {
  /**
   * Case ID associated with the documents. Can come from URL parameters or form
   * body.
   */
  caseId: string;

  /**
   * User ID. For internal uploads, this will be auto-generated if not provided.
   */
  userId?: string;

  /**
   * Supplier ID. Required for external uploads.
   */
  supplierId: string;

  /**
   * List of files to upload
   */
  files: bytes[];

  /** Upload type indicating whether this is internal or external */
  uploadType: UploadType;

  /**
   * List of document categories for the uploaded files
   */
  documentCategory: DocumentCategory[];
}

/** Response containing the result of document upload operation */
model UploadResponse {
  /**
   * Case ID associated with the uploaded documents
   */
  caseId?: string;

  /**
   * User ID who uploaded the documents
   */
  userId?: string;

  /**
   * List of successfully uploaded file names
   */
  fileName?: string[];

  /**
   * Document state indicating the current processing state of documents
   */
  documentState?: DocumentState;

  /**
   * List of files that were skipped due to duplicates
   */
  skippedFiles?: string[];

  /**
   * Total number of files processed in the upload request
   */
  totalFilesProcessed?: int32;

  /**
   * Number of files successfully uploaded
   */
  filesUploaded?: int32;

  /**
   * Number of files skipped (duplicates)
   */
  filesSkipped?: int32;

  /**
   * Summary message describing the upload result
   */
  summary?: string;

  /**
   * Upload type indicating whether the upload is internal or external
   */
  uploadType?: UploadType;

  /**
   * List of document categories for the uploaded files
   */
  documentCategory?: DocumentCategory[];
}

/** Common error response structure */
model CommonError {
  /** Error details */
  error?: CommonErrorDetails;
}

/** Detailed error information */
model CommonErrorDetails {
  /**
   * Error code
   */
  code?: string;

  /**
   * Error message
   */
  message?: string;

  /**
   * Additional error details
   */
  details?: CommonErrorDetails[];
}

/** Request model for document upload operations */
model UploadRequest {
  /**
   * Case ID associated with the documents. Can come from URL parameters or form
   * body.
   */
  caseId: string;

  /**
   * User ID. For internal uploads, this will be auto-generated if not provided.
   */
  userId?: string;

  /**
   * Supplier ID. Required for external uploads.
   */
  supplierId: string;

  /**
   * List of files to upload
   */
  files: bytes[];

  /**
   * Upload type indicating whether the upload is internal or external
   */
  uploadType: UploadType;

  /**
   * List of document categories for the uploaded files
   */
  documentCategory: DocumentCategory[];
}
