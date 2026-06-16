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
 * Protected item model.
 */
@parentResource(VaultModel)
model ProtectedItemModel
  is Azure.ResourceManager.ProxyResource<ProtectedItemModelProperties> {
  ...ResourceNameParameter<
    Resource = ProtectedItemModel,
    KeyName = "protectedItemName",
    SegmentName = "protectedItems",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi"
@@OpenAPI.extension(ProtectedItem.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi"
@@OpenAPI.extension(ProtectedItem.update::parameters.properties,
  "x-ms-client-name",
  "body"
);

@armResourceOperations
interface ProtectedItem {
  /**
   * Gets the details of the protected item.
   */
  get is ArmResourceRead<ProtectedItemModel>;

  /**
   * Creates the protected item.
   */
  create is ArmResourceCreateOrReplaceAsync<ProtectedItemModel>;

  /**
   * Performs update on the protected item.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<ProtectedItemModel, ProtectedItemModelUpdate>;

  /**
   * Removes the protected item.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ProtectedItemModel,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<ProtectedItemModel>;

      /**
       * A flag indicating whether to do force delete or not.
       */
      @query("forceDelete")
      forceDelete?: boolean;
    }
  >;

  /**
   * Gets the list of protected items in the given vault.
   */
  list is ArmResourceListByParent<
    ProtectedItemModel,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<ProtectedItemModel>;

      /**
       * OData options.
       */
      @query("odataOptions")
      odataOptions?: string;

      /**
       * Continuation token.
       */
      @query("continuationToken")
      continuationToken?: string;

      /**
       * Page size.
       */
      @query("pageSize")
      pageSize?: int32;
    }
  >;

  /**
   * Performs the planned failover on the protected item.
   */
  plannedFailover is ArmResourceActionAsync<
    ProtectedItemModel,
    PlannedFailoverModel,
    PlannedFailoverModel
  >;
}

@@doc(ProtectedItemModel.name, "The protected item name.");
@@doc(ProtectedItem.create::parameters.resource, "Protected item model.");
@@doc(ProtectedItem.update::parameters.properties, "Protected item model.");
@@doc(ProtectedItem.plannedFailover::parameters.body,
  "Planned failover model."
);
