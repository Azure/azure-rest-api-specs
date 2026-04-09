import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataMigration;
/**
 * A SQL Migration Service.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SqlMigrationService
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<SqlMigrationServiceProperties> {
  ...ResourceNameParameter<
    Resource = SqlMigrationService,
    KeyName = "sqlMigrationServiceName",
    SegmentName = "sqlMigrationServices",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SqlMigrationServices {
  /**
   * Retrieve the Database Migration Service
   */
  get is ArmResourceRead<SqlMigrationService>;

  /**
   * Create or Update Database Migration Service.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SqlMigrationService,
    LroHeaders = ArmLroLocationHeader<FinalResult = SqlMigrationService> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update Database Migration Service.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    SqlMigrationService,
    PatchModel = SqlMigrationServiceUpdate,
    Response = ArmResponse<SqlMigrationService> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = SqlMigrationService> &
      Azure.Core.Foundations.RetryAfterHeader> | ArmResourceCreatedResponse<SqlMigrationService>
  >;

  /**
   * Delete Database Migration Service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    SqlMigrationService,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Retrieve all SQL migration services in the resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    SqlMigrationService,
    Response = ArmResponse<SqlMigrationListResult>
  >;

  /**
   * Retrieve all SQL migration services in the subscriptions.
   */
  listBySubscription is ArmListBySubscription<
    SqlMigrationService,
    Response = ArmResponse<SqlMigrationListResult>
  >;

  /**
   * Retrieve the List of Authentication Keys for Self Hosted Integration Runtime.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SqlMigrationServices_listAuthKeys")
  listAuthKeys is ArmResourceActionSync<
    SqlMigrationService,
    void,
    ArmResponse<AuthenticationKeys>
  >;

  /**
   * Regenerate a new set of Authentication Keys for Self Hosted Integration Runtime.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SqlMigrationServices_regenerateAuthKeys")
  regenerateAuthKeys is ArmResourceActionSync<
    SqlMigrationService,
    RegenAuthKeys,
    ArmResponse<RegenAuthKeys>
  >;

  /**
   * Delete the integration runtime node.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SqlMigrationServices_deleteNode")
  deleteNode is ArmResourceActionSync<
    SqlMigrationService,
    deleteNode,
    ArmResponse<deleteNode>
  >;

  /**
   * Retrieve the List of database migrations attached to the service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SqlMigrationServices_listMigrations")
  @list
  @get
  listMigrations is ArmResourceActionSync<
    SqlMigrationService,
    void,
    ArmResponse<ResourceListResult<DatabaseMigration>>
  >;

  /**
   * Retrieve the registered Integration Runtime nodes and their monitoring data for a given Database Migration Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SqlMigrationServices_listMonitoringData")
  listMonitoringData is ArmResourceActionSync<
    SqlMigrationService,
    void,
    ArmResponse<IntegrationRuntimeMonitoringData>
  >;
}

@@doc(SqlMigrationService.name, "Name of the SQL Migration Service.");
@@doc(SqlMigrationService.properties, "The SQL Migration Service properties.");
@@doc(SqlMigrationServices.createOrUpdate::parameters.resource,
  "Details of SqlMigrationService resource."
);
@@doc(SqlMigrationServices.update::parameters.properties,
  "Details of SqlMigrationService resource."
);
@@doc(SqlMigrationServices.regenerateAuthKeys::parameters.body,
  "Details of SqlMigrationService resource."
);
@@doc(SqlMigrationServices.deleteNode::parameters.body,
  "Details of SqlMigrationService resource."
);
