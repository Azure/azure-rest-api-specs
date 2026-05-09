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

namespace Microsoft.Kusto;
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
    NamePattern = "^.*$"
  >;
}

@armResourceOperations
interface DatabasePrincipalAssignments {
  /**
   * Gets a Kusto cluster database principalAssignment.
   */
  get is ArmResourceRead<DatabasePrincipalAssignment>;

  /**
   * Creates a Kusto cluster database principalAssignment.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DatabasePrincipalAssignment,
    LroHeaders = ArmLroLocationHeader<FinalResult = DatabasePrincipalAssignment> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a Kusto principalAssignment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    DatabasePrincipalAssignment,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader &
      ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all Kusto cluster database principalAssignments.
   */
  list is ArmResourceListByParent<
    DatabasePrincipalAssignment,
    Response = ArmResponse<DatabasePrincipalAssignmentListResult>
  >;
}

@@doc(DatabasePrincipalAssignment.name,
  "The name of the Kusto principalAssignment."
);
@@doc(DatabasePrincipalAssignment.properties, "The database principal.");
@@doc(DatabasePrincipalAssignments.createOrUpdate::parameters.resource,
  "The Kusto principalAssignments parameters supplied for the operation."
);
