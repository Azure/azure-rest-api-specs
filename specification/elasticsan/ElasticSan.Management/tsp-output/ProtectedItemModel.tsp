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
@doc("Protected item model.")
@parentResource(VaultModel)
model ProtectedItemModel is ProxyResource<ProtectedItemModelProperties> {
  @doc("The protected item name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("protectedItemName")
  @segment("protectedItems")
  name: string;
}

@armResourceOperations
interface ProtectedItemModels {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the details of the protected item.")
  @operationId("ProtectedItem_Get")
  get is ArmResourceRead<ProtectedItemModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates the protected item.")
  @operationId("ProtectedItem_Create")
  create is ArmResourceCreateOrUpdateAsync<
    ProtectedItemModel,
    BaseParameters<ProtectedItemModel>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Removes the protected item.")
  @operationId("ProtectedItem_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ProtectedItemModel,
    {
      ...BaseParameters<ProtectedItemModel>;

      @doc("A flag indicating whether to do force delete or not.")
      @query("forceDelete")
      forceDelete?: boolean;
    },
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the list of protected items in the given vault.")
  @operationId("ProtectedItem_List")
  list is ArmResourceListByParent<ProtectedItemModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Performs the planned failover on the protected item.")
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
