import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * Class representing a database principal assignment.
 */
@parentResource(Database)
model DatabasePrincipalAssignment
  is Azure.ResourceManager.ProxyResource<DatabasePrincipalProperties> {
  ...ResourceNameParameter<
    Resource = DatabasePrincipalAssignment,
    KeyName = "principalAssignmentName",
    SegmentName = "principalAssignments",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DatabasePrincipalAssignments {
  /**
   * Gets a Kusto pool database principalAssignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolDatabasePrincipalAssignments_Get")
  get is ArmResourceRead<DatabasePrincipalAssignment>;

  /**
   * Creates a Kusto pool database principalAssignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolDatabasePrincipalAssignments_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DatabasePrincipalAssignment,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a Kusto pool principalAssignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("KustoPoolDatabasePrincipalAssignments_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    DatabasePrincipalAssignment,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Kusto pool database principalAssignments.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPoolDatabasePrincipalAssignments_List")
  list is ArmResourceListByParent<
    DatabasePrincipalAssignment,
    Response = ArmResponse<DatabasePrincipalAssignmentListResult>
  >;
}

@@doc(
  DatabasePrincipalAssignment.name,
  "The name of the Kusto principalAssignment."
);
@@doc(DatabasePrincipalAssignment.properties, "The database principal.");
@@doc(
  DatabasePrincipalAssignments.createOrUpdate::parameters.resource,
  "The Kusto principalAssignments parameters supplied for the operation."
);
