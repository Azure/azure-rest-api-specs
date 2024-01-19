import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VaultModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
@doc("Replication extension model.")
@parentResource(VaultModel)
model ReplicationExtensionModel
  is ProxyResource<ReplicationExtensionModelProperties> {
  @doc("The replication extension name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("replicationExtensionName")
  @segment("replicationExtensions")
  name: string;
}

@armResourceOperations
interface ReplicationExtensionModels {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the details of the replication extension.")
  @operationId("ReplicationExtension_Get")
  get is ArmResourceRead<ReplicationExtensionModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates the replication extension in the given vault.")
  @operationId("ReplicationExtension_Create")
  create is ArmResourceCreateOrUpdateAsync<
    ReplicationExtensionModel,
    BaseParameters<ReplicationExtensionModel>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the replication extension in the given vault.")
  @operationId("ReplicationExtension_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ReplicationExtensionModel,
    BaseParameters<ReplicationExtensionModel>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the list of replication extensions in the given vault.")
  @operationId("ReplicationExtension_List")
  list is ArmResourceListByParent<ReplicationExtensionModel>;
}

@@projectedName(ReplicationExtensionModels.create::parameters.resource,
  "json",
  "body"
);
@@extension(ReplicationExtensionModels.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(ReplicationExtensionModels.create::parameters.resource,
  "Replication extension model."
);
