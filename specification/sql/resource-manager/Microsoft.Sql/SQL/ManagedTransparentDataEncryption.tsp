import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A managed database transparent data encryption state.
 */
@parentResource(ManagedDatabase)
model ManagedTransparentDataEncryption
  is Azure.ResourceManager.ProxyResource<ManagedTransparentDataEncryptionProperties> {
  ...ResourceNameParameter<
    Resource = ManagedTransparentDataEncryption,
    KeyName = "tdeName",
    SegmentName = "transparentDataEncryption",
    NamePattern = "",
    Type = TransparentDataEncryptionName
  >;
}

@armResourceOperations
interface ManagedTransparentDataEncryptions {
  /**
   * Gets a managed database's transparent data encryption.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedDatabaseTransparentDataEncryption_Get")
  get is ArmResourceRead<ManagedTransparentDataEncryption>;

  /**
   * Updates a database's transparent data encryption configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedDatabaseTransparentDataEncryption_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ManagedTransparentDataEncryption>;

  /**
   * Gets a list of managed database's transparent data encryptions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedDatabaseTransparentDataEncryption_ListByDatabase")
  listByDatabase is ArmResourceListByParent<ManagedTransparentDataEncryption>;
}

@@doc(ManagedTransparentDataEncryption.name,
  "The name of the transparent data encryption configuration."
);
@@doc(ManagedTransparentDataEncryption.properties, "Resource properties.");
@@doc(ManagedTransparentDataEncryptions.createOrUpdate::parameters.resource,
  "The database transparent data encryption."
);
