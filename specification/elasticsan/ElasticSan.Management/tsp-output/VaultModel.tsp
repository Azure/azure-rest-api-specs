import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
@doc("Vault model.")
model VaultModel is TrackedResource<VaultModelProperties> {
  @doc("The vault name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("vaultName")
  @segment("replicationVaults")
  name: string;
}

@armResourceOperations
interface VaultModels {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the details of the vault.")
  @operationId("Vault_Get")
  get is ArmResourceRead<VaultModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates the vault.")
  @operationId("Vault_Create")
  create is ArmResourceCreateOrUpdateAsync<
    VaultModel,
    BaseParameters<VaultModel>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Performs update on the vault.")
  @operationId("Vault_Update")
  update is ArmCustomPatchAsync<
    VaultModel,
    VaultModelUpdate,
    BaseParameters<VaultModel>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Removes the vault.")
  @operationId("Vault_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    VaultModel,
    BaseParameters<VaultModel>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the list of vaults in the given subscription and resource group.")
  @operationId("Vault_List")
  list is ArmResourceListByParent<
    VaultModel,
    {
      ...BaseParameters<VaultModel>;

      @doc("Continuation token from the previous call.")
      @query("continuationToken")
      continuationToken?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the list of vaults in the given subscription.")
  @operationId("Vault_ListBySubscription")
  listBySubscription is ArmListBySubscription<VaultModel>;
}

@@projectedName(VaultModels.create::parameters.resource, "json", "body");
@@extension(VaultModels.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(VaultModels.create::parameters.resource, "Vault properties.");
@@projectedName(VaultModels.update::parameters.properties, "json", "body");
@@extension(VaultModels.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(VaultModels.update::parameters.properties, "Vault properties.");
