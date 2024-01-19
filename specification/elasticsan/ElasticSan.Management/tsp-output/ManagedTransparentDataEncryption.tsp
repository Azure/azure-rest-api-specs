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
@doc("A managed database transparent data encryption state.")
@parentResource(ManagedDatabase)
model ManagedTransparentDataEncryption
  is ProxyResource<ManagedTransparentDataEncryptionProperties> {
  @doc("The name of the transparent data encryption configuration.")
  @path
  @key("tdeName")
  @segment("transparentDataEncryption")
  name: TransparentDataEncryptionName;
}

@armResourceOperations
interface ManagedTransparentDataEncryptions {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a managed database's transparent data encryption.")
  @operationId("ManagedDatabaseTransparentDataEncryption_Get")
  get is ArmResourceRead<ManagedTransparentDataEncryption>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates a database's transparent data encryption configuration.")
  @operationId("ManagedDatabaseTransparentDataEncryption_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ManagedTransparentDataEncryption>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a list of managed database's transparent data encryptions.")
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
