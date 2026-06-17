import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A managed database transparent data encryption state.
 */
@parentResource(ManagedDatabase)
model ManagedTransparentDataEncryption
  is ProxyResource<ManagedTransparentDataEncryptionProperties> {
  /**
   * The name of the transparent data encryption configuration.
   */
  @path
  @key("tdeName")
  @segment("transparentDataEncryption")
  name: TransparentDataEncryptionName;
}

@armResourceOperations
interface ManagedTransparentDataEncryptions {
  /**
   * Gets a managed database's transparent data encryption.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseTransparentDataEncryption_Get")
  get is ArmResourceRead<ManagedTransparentDataEncryption>;

  /**
   * Updates a database's transparent data encryption configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseTransparentDataEncryption_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ManagedTransparentDataEncryption>;

  /**
   * Gets a list of managed database's transparent data encryptions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseTransparentDataEncryption_ListByDatabase")
  listByDatabase is ArmResourceListByParent<ManagedTransparentDataEncryption>;
}

@@projectedName(ManagedTransparentDataEncryptions.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedTransparentDataEncryptions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedTransparentDataEncryptions.createOrUpdate::parameters.resource,
  "The database transparent data encryption."
);
