import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Genome;

// Operation names
@@clientName(getCases, "getCases");
@@clientName(createOrReplaceCase, "createCase");
@@clientName(getCaseById, "getCaseById");
@@clientName(replaceCase, "updateCase");
@@clientName(deleteCase, "archiveCase");
@@clientName(getCaseSuppliers, "getCaseSuppliers");
@@clientName(createOrReplaceSupplierInCase, "addSupplierToCase");
@@clientName(getCaseSupplier, "getCaseSupplier");
@@clientName(replaceCaseSupplier, "updateCaseSupplier");
@@clientName(deleteSupplierFromCase, "removeSupplierFromCase");

// Model renames for .NET SDK naming conventions (AZC0030, AZC0034)
@@clientName(CaseMetadataResponse, "CaseMetadata", "csharp");
@@clientName(CaseRequest, "CaseContent", "csharp");
@@clientName(CaseSupplierResponse, "CaseSupplier", "csharp");
@@clientName(CaseSupplierRequest, "CaseSupplierContent", "csharp");
@@clientName(ErrorResponse, "GenomeError", "csharp");
