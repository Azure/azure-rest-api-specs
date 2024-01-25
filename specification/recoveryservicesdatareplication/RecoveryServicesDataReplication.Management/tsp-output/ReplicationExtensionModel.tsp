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
/**
 * Replication extension model.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(VaultModel)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  ReplicationExtensionModelProperties
)
model ReplicationExtensionModel extends ProxyResourceBase {
  /**
   * The replication extension name.
   */
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("replicationExtensionName")
  @segment("replicationExtensions")
  @visibility("read")
  name: string;

  /**
   * Replication extension model properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: ReplicationExtensionModelProperties;
}

@armResourceOperations
interface ReplicationExtensionModels {
  /**
   * Gets the details of the replication extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ReplicationExtension_Get")
  get is ArmResourceRead<ReplicationExtensionModel>;

  /**
   * Creates the replication extension in the given vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ReplicationExtension_Create")
  create is ArmResourceCreateOrReplaceAsync<
    ReplicationExtensionModel,
    BaseParameters<ReplicationExtensionModel>,
    ArmLroLocationHeader
  >;

  /**
   * Deletes the replication extension in the given vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ReplicationExtension_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ReplicationExtensionModel,
    BaseParameters<ReplicationExtensionModel>,
    ArmLroLocationHeader
  >;

  /**
   * Gets the list of replication extensions in the given vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
