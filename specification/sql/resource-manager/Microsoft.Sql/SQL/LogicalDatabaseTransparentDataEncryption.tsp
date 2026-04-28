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

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface LogicalDatabaseTransparentDataEncryptions {
  /**
   * Gets a logical database's transparent data encryption.
   */
  @tag("TransparentDataEncryptions")
  get is ArmResourceRead<LogicalDatabaseTransparentDataEncryption>;

  /**
   * Updates a logical database's transparent data encryption configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("TransparentDataEncryptions")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    LogicalDatabaseTransparentDataEncryption,
    Response = ArmResourceUpdatedResponse<LogicalDatabaseTransparentDataEncryption> | ArmResourceCreatedResponse<
      LogicalDatabaseTransparentDataEncryption,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = LogicalDatabaseTransparentDataEncryption>
    > | ArmAcceptedLroResponse
  >;

  /**
   * Gets a list of the logical database's transparent data encryption.
   */
  @tag("TransparentDataEncryptions")
  listByDatabase is ArmResourceListByParent<LogicalDatabaseTransparentDataEncryption>;

  /**
   * Resume ongoing logical database's Transparent Data Encryption scan configuration.
   */
  @tag("TransparentDataEncryptions")
  resume is ArmResourceActionAsync<
    LogicalDatabaseTransparentDataEncryption,
    void,
    Response = LogicalDatabaseTransparentDataEncryption
  >;

  /**
   * Suspend ongoing logical database's Transparent Data Encryption scan configuration.
   */
  @tag("TransparentDataEncryptions")
  suspend is ArmResourceActionAsync<
    LogicalDatabaseTransparentDataEncryption,
    void,
    Response = LogicalDatabaseTransparentDataEncryption
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
