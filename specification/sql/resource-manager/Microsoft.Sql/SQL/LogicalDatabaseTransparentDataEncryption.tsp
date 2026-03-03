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

namespace Microsoft.Sql;
/**
 * A logical database transparent data encryption scan state.
 */
@parentResource(Database)
model LogicalDatabaseTransparentDataEncryption
  is Azure.ResourceManager.ProxyResource<TransparentDataEncryptionProperties> {
  ...ResourceNameParameter<
    Resource = LogicalDatabaseTransparentDataEncryption,
    KeyName = "tdeName",
    SegmentName = "transparentDataEncryption",
    NamePattern = "",
    Type = TransparentDataEncryptionName
  >;
}

@armResourceOperations
interface LogicalDatabaseTransparentDataEncryptions {
  /**
   * Gets a logical database's transparent data encryption.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TransparentDataEncryptions_Get")
  get is ArmResourceRead<LogicalDatabaseTransparentDataEncryption>;

  /**
   * Updates a logical database's transparent data encryption configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("TransparentDataEncryptions_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    LogicalDatabaseTransparentDataEncryption,
    Response = ArmResourceUpdatedResponse<LogicalDatabaseTransparentDataEncryption> | ArmResourceCreatedResponse<LogicalDatabaseTransparentDataEncryption> | ArmAcceptedLroResponse
  >;

  /**
   * Gets a list of the logical database's transparent data encryption.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TransparentDataEncryptions_ListByDatabase")
  listByDatabase is ArmResourceListByParent<LogicalDatabaseTransparentDataEncryption>;

  /**
   * Resume ongoing logical database's Transparent Data Encryption scan configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TransparentDataEncryptions_Resume")
  resume is ArmResourceActionAsync<
    LogicalDatabaseTransparentDataEncryption,
    void,
    ArmResponse<LogicalDatabaseTransparentDataEncryption>
  >;

  /**
   * Suspend ongoing logical database's Transparent Data Encryption scan configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TransparentDataEncryptions_Suspend")
  suspend is ArmResourceActionAsync<
    LogicalDatabaseTransparentDataEncryption,
    void,
    ArmResponse<LogicalDatabaseTransparentDataEncryption>
  >;
}

@@doc(LogicalDatabaseTransparentDataEncryption.name,
  "The name of the transparent data encryption configuration."
);
@@doc(LogicalDatabaseTransparentDataEncryption.properties,
  "Resource properties."
);
@@doc(LogicalDatabaseTransparentDataEncryptions.createOrUpdate::parameters.resource,
  "The database transparent data encryption."
);
