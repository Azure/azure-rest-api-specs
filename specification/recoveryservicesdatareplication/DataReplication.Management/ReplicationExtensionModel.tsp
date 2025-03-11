import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VaultModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
/**
 * Replication extension model.
 */
@parentResource(VaultModel)
model ReplicationExtensionModel
  is Azure.ResourceManager.ProxyResource<ReplicationExtensionModelProperties> {
  ...ResourceNameParameter<
    Resource = ReplicationExtensionModel,
    KeyName = "replicationExtensionName",
    SegmentName = "replicationExtensions",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi"
@@OpenAPI.extension(ReplicationExtension.create::parameters.resource,
  "x-ms-client-name",
  "body"
);

@armResourceOperations
interface ReplicationExtension {
  /**
   * Gets the details of the replication extension.
   */
  get is ArmResourceRead<ReplicationExtensionModel>;

  /**
   * Creates the replication extension in the given vault.
   */
  create is ArmResourceCreateOrReplaceAsync<ReplicationExtensionModel>;

  /**
   * Deletes the replication extension in the given vault.
   */
  delete is ArmResourceDeleteWithoutOkAsync<ReplicationExtensionModel>;

  /**
   * Gets the list of replication extensions in the given vault.
   */
  list is ArmResourceListByParent<ReplicationExtensionModel>;
}

@@doc(ReplicationExtensionModel.name, "The replication extension name.");
@@doc(ReplicationExtension.create::parameters.resource,
  "Replication extension model."
);
