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
 * Protected item model.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(VaultModel)
@Azure.ResourceManager.Private.armResourceInternal(ProtectedItemModelProperties)
@includeInapplicableMetadataInPayload(false)
model ProtectedItemModel extends ProxyResourceBase {
  /**
   * The protected item name.
   */
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("protectedItemName")
  @segment("protectedItems")
  name: string;

  /**
   * Protected item model properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: ProtectedItemModelProperties;
}

@armResourceOperations
interface ProtectedItemModels {
  /**
   * Gets the details of the protected item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ProtectedItem_Get")
  get is ArmResourceRead<ProtectedItemModel>;

  /**
   * Creates the protected item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ProtectedItem_Create")
  create is ArmResourceCreateOrReplaceAsync<
    ProtectedItemModel,
    BaseParameters<ProtectedItemModel>,
    ArmLroLocationHeader
  >;

  /**
   * Removes the protected item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ProtectedItem_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ProtectedItemModel,
    {
      ...BaseParameters<ProtectedItemModel>;

      /**
       * A flag indicating whether to do force delete or not.
       */
      @query("forceDelete")
      forceDelete?: boolean;
    },
    ArmLroLocationHeader
  >;

  /**
   * Gets the list of protected items in the given vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ProtectedItem_List")
  list is ArmResourceListByParent<ProtectedItemModel>;

  /**
   * Performs the planned failover on the protected item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ProtectedItem_PlannedFailover")
  plannedFailover is ArmResourceActionAsync<
    ProtectedItemModel,
    PlannedFailoverModel,
    PlannedFailoverModel,
    BaseParameters<ProtectedItemModel>,
    ArmLroLocationHeader
  >;
}

@@projectedName(ProtectedItemModels.create::parameters.resource,
  "json",
  "body"
);
@@extension(ProtectedItemModels.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(ProtectedItemModels.create::parameters.resource, "Protected item model.");
@@doc(ProtectedItemModels.plannedFailover::parameters.body,
  "Planned failover model."
);
