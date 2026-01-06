import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Genome;

/**
 * Retrieves a list of all cases with optional filtering by case type and status.
 * Returns comprehensive case metadata including workflow status, priority, and
 * deadlines.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom case retrieval operation with filtering support"
@summary("Get all cases")
@route("/v1/cases")
@get
op getCases is Azure.Core.Foundations.Operation<
  {
    /**
     * Filter cases by case type
     */
    @query("caseType")
    caseType?: CaseType;

    /**
     * Filter cases by status
     */
    @query("status")
    status?: string;
  },
  CaseMetadataResponse[]
>;

/**
 * Creates a new case with specified metadata, priority, and deadline. Requires
 * case type, status, created by user, metadata with CBP contact information,
 * priority, and deadline.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom case creation operation"
@summary("Create a new case")
@route("/v1/cases")
@put
op createOrReplaceCase is Azure.Core.Foundations.Operation<
  CaseRequest,
  CaseMetadataResponse
>;

/**
 * Retrieves detailed information about a specific case using its unique
 * identifier.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom case retrieval by ID operation"
@summary("Get case by ID")
@route("/v1/cases/{caseId}")
@get
op getCaseById is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique identifier of the case
     */
    @path
    caseId: string;
  },
  CaseMetadataResponse
>;

/**
 * Updates an existing case with new information. All fields in the request body
 * will be updated.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom case replacement operation"
@summary("Update a case")
@route("/v1/cases/{caseId}")
@put
op replaceCase is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique identifier of the case to update
     */
    @path
    caseId: string;

    /** Request body for updating case */
    @body
    body: CaseRequest;
  },
  CaseMetadataResponse
>;

/**
 * Archives (soft deletes) a case. The case is not permanently deleted but marked
 * as archived and will not appear in regular case listings.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom case archival operation"
@summary("Archive a case")
@route("/v1/cases/{caseId}")
@delete
op deleteCase is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique identifier of the case to archive
     */
    @path
    caseId: string;
  },
  string
>;

/**
 * Retrieves a list of all suppliers associated with a specific case, including
 * their contact information, required documents, and upload status.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom case suppliers retrieval operation"
@summary("Get suppliers for a case")
@route("/v1/cases/{caseId}/suppliers")
@get
op getCaseSuppliers is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique identifier of the case
     */
    @path
    caseId: string;
  },
  CaseSupplierResponse[]
>;

/**
 * Associates a new supplier with a case. Requires supplier ID, name,
 * jurisdiction, and created by user.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom supplier addition operation"
@summary("Add supplier to case")
@route("/v1/cases/{caseId}/suppliers")
@put
op createOrReplaceSupplierInCase is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique identifier of the case
     */
    @path
    caseId: string;

    /** Request body for adding supplier to case */
    @body
    body: CaseSupplierRequest;
  },
  CaseSupplierResponse
>;

/**
 * Retrieves detailed information about a specific supplier associated with a case.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom case supplier retrieval by ID operation"
@summary("Get specific supplier for a case")
@route("/v1/cases/{caseId}/suppliers/{supplierId}")
@get
op getCaseSupplier is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique identifier of the case
     */
    @path
    caseId: string;

    /**
     * Unique identifier of the supplier
     */
    @path
    supplierId: string;
  },
  CaseSupplierResponse
>;

/**
 * Updates supplier information such as name, contact details, status, and
 * required documents.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom case supplier replacement operation"
@summary("Update supplier information for a case")
@route("/v1/cases/{caseId}/suppliers/{supplierId}")
@put
op replaceCaseSupplier is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique identifier of the case
     */
    @path
    caseId: string;

    /**
     * Unique identifier of the supplier
     */
    @path
    supplierId: string;

    /** Request body for updating case supplier */
    @body
    body: CaseSupplierRequest;
  },
  CaseSupplierResponse
>;

/**
 * Removes the association between a supplier and a case. The supplier record is
 * deleted from the case but the supplier itself remains in the system.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Custom supplier removal operation"
@summary("Remove supplier from case")
@route("/v1/cases/{caseId}/suppliers/{supplierId}")
@delete
op deleteSupplierFromCase is Azure.Core.Foundations.Operation<
  {
    /**
     * Unique identifier of the case
     */
    @path
    caseId: string;

    /**
     * Unique identifier of the supplier
     */
    @path
    supplierId: string;
  },
  string
>;
