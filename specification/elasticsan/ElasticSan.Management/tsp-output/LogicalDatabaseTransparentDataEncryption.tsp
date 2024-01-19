import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("A logical database transparent data encryption state.")
@parentResource(Database)
model LogicalDatabaseTransparentDataEncryption
  is ProxyResource<TransparentDataEncryptionProperties> {
  @doc("The name of the transparent data encryption configuration.")
  @path
  @key("tdeName")
  @segment("transparentDataEncryption")
  name: TransparentDataEncryptionName;
}

@armResourceOperations
interface LogicalDatabaseTransparentDataEncryptions {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a logical database's transparent data encryption.")
  @operationId("TransparentDataEncryptions_Get")
  get is ArmResourceRead<LogicalDatabaseTransparentDataEncryption>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates a logical database's transparent data encryption configuration.")
  @operationId("TransparentDataEncryptions_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    LogicalDatabaseTransparentDataEncryption,
    BaseParameters<LogicalDatabaseTransparentDataEncryption>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a list of the logical database's transparent data encryption.")
  @operationId("TransparentDataEncryptions_ListByDatabase")
  listByDatabase is ArmResourceListByParent<LogicalDatabaseTransparentDataEncryption>;
}

@@projectedName(LogicalDatabaseTransparentDataEncryptions.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(LogicalDatabaseTransparentDataEncryptions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(LogicalDatabaseTransparentDataEncryptions.createOrUpdate::parameters.resource,
  "The database transparent data encryption."
);
