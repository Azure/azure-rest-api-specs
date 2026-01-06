import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Genome;

/**
 * Type of case
 */
union CaseType {
  string,

  /**
   * UFLPA
   */
  UFLPA: "UFLPA",
}

/**
 * Current status of the case
 */
union CaseStatus {
  string,

  /**
   * New
   */
  New: "New",

  /**
   * Active
   */
  Active: "Active",

  /**
   * Investigation
   */
  Investigation: "Investigation",

  /**
   * Resolution
   */
  Resolution: "Resolution",

  /**
   * Closed
   */
  Closed: "Closed",
}

/**
 * Detailed workflow status within the case lifecycle
 */
union WorkflowStatus {
  string,

  /**
   * detentionReceived
   */
  detentionReceived: "detentionReceived",

  /**
   * initialAssessment
   */
  initialAssessment: "initialAssessment",

  /**
   * extensionRequest
   */
  extensionRequest: "extensionRequest",

  /**
   * applicabilityReview
   */
  applicabilityReview: "applicabilityReview",

  /**
   * submissionPreparation
   */
  submissionPreparation: "submissionPreparation",

  /**
   * cbpSubmission
   */
  cbpSubmission: "cbpSubmission",

  /**
   * cbpReview
   */
  cbpReview: "cbpReview",

  /**
   * additionalInfoRequested
   */
  additionalInfoRequested: "additionalInfoRequested",

  /**
   * clearanceReceived
   */
  clearanceReceived: "clearanceReceived",

  /**
   * denialReceived
   */
  denialReceived: "denialReceived",

  /**
   * exportElected
   */
  exportElected: "exportElected",
}

/**
 * Priority level of the case
 */
union CasePriority {
  string,

  /**
   * Low
   */
  Low: "Low",

  /**
   * Normal
   */
  Normal: "Normal",

  /**
   * High
   */
  High: "High",
}

/**
 * Complete case metadata response
 */
model CaseMetadataResponse {
  /**
   * Unique identifier for the case
   */
  caseId: string;

  /**
   * Type of case
   */
  type: CaseType;

  /**
   * Human-readable name for the case
   */
  caseName?: string;

  /**
   * Current status of the case
   */
  status: CaseStatus;

  /**
   * Detailed workflow status within the case lifecycle
   */
  workflowStatus?: WorkflowStatus;

  /**
   * ID of the associated workflow execution
   */
  workflowExecutionId: string;

  /**
   * User ID of the person who created the case
   */
  createdBy: string;

  /**
   * User ID of the person who last modified the case
   */
  modifiedBy?: string;

  /**
   * Timestamp when the case was created
   */
  createdOn?: utcDateTime;

  /**
   * Timestamp when the case was last modified
   */
  modifiedOn?: utcDateTime;

  /**
   * Detention-specific metadata
   */
  metadata?: DetentionMetadata;

  /**
   * Priority level of the case
   */
  priority: CasePriority;

  /**
   * Deadline for case resolution
   */
  deadline: utcDateTime;

  /**
   * Indicates if the case has been archived (soft deleted)
   */
  isArchived?: boolean;
}

/**
 * Detention-specific metadata
 */
model DetentionMetadata {
  /**
   * Detention number assigned by CBP
   */
  detentionNumber: string;

  /**
   * Port code where detention occurred
   */
  portCode: string;

  /**
   * Entry number for the shipment
   */
  entryNumber: string;

  /**
   * Description of the detained merchandise
   */
  merchandiseDescription?: string;

  /**
   * Value of the shipment
   */
  shipmentValue?: string;

  /**
   * Contact information
   */
  cbpContact: ContactInfo;
}

/**
 * Contact information
 */
model ContactInfo {
  /**
   * Name of the contact person
   */
  name: string;

  /**
   * Phone number of the contact
   */
  phoneNumber?: string;
}

/**
 * Standard error response format for authentication and authorization errors
 */
model CommonError {
  /** Error details */
  error?: CommonErrorError;
}

/** Detailed error information */
model CommonErrorError {
  /** Error code */
  code?: string;

  /** Error message */
  message?: string;
}

/** General error response */
model ErrorResponse {
  /** Error type or code */
  error?: string;

  /** Error message */
  message?: string;
}

/**
 * Request for creating or updating a case
 */
model CaseRequest {
  /**
   * Type of case
   */
  caseType: CaseType;

  /**
   * Human-readable name for the case
   */
  caseName?: string;

  /**
   * Current status of the case
   */
  status: CaseStatus;

  /**
   * Detailed workflow status within the case lifecycle
   */
  workflowStatus?: WorkflowStatus;

  /**
   * User ID of the person creating the case
   */
  createdBy: string;

  /**
   * Detention-specific metadata
   */
  metadata?: DetentionMetadata;

  /**
   * Priority level of the case
   */
  priority: CasePriority;

  /**
   * Deadline for case resolution
   */
  deadline: utcDateTime;
}

/**
 * Supplier information for a case
 */
model CaseSupplierResponse {
  /**
   * Unique identifier for this case supplier record
   */
  id: string;

  /**
   * Case ID this supplier is associated with
   */
  caseId: string;

  /**
   * Unique identifier for the supplier
   */
  supplierId: string;

  /**
   * Name of the supplier
   */
  supplierName: string;

  /**
   * Country code where supplier operates
   */
  jurisdiction?: string;

  /**
   * Supplier status in relation to the case
   */
  status?: string;

  /**
   * Contact information for the supplier
   */
  supplierContact?: string;

  /**
   * List of required document types
   */
  requiredDocumentTypes?: string[];

  /**
   * List of document categories already uploaded
   */
  uploadedDocuments?: string[];

  /**
   * List of document types still pending upload
   */
  pendingDocumentTypes?: string[];

  /**
   * Whether the supplier is active in the case
   */
  isActive?: boolean;

  /**
   * User ID who created this supplier association
   */
  createdBy?: string;

  /**
   * User ID who last updated this supplier association
   */
  updatedBy?: string;
}

/**
 * Request for adding or updating a supplier to a case
 */
model CaseSupplierRequest {
  /**
   * Unique identifier for the supplier
   */
  supplierId: string;

  /**
   * Name of the supplier
   */
  supplierName: string;

  /**
   * Country code where supplier operates
   */
  jurisdiction: string;

  /**
   * Supplier status in relation to the case
   */
  status?: string;

  /**
   * Contact information for the supplier
   */
  supplierContact?: string;

  /**
   * List of required document types
   */
  requiredDocumentTypes?: string[];

  /**
   * User ID who created this supplier association
   */
  createdBy?: string;

  /**
   * User ID who last updated this supplier association
   */
  updatedBy?: string;
}
