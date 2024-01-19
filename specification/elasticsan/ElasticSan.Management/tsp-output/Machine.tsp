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

namespace Microsoft.HybridCompute;
@doc("Describes a hybrid machine.")
model Machine is TrackedResource<MachineProperties> {
  @doc("The name of the hybrid machine.")
  @maxLength(54)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-_\\.]{1,54}$")
  @path
  @key("machineName")
  @segment("machines")
  name: string;

  @doc("The list of extensions affiliated to the machine")
  @visibility("read")
  resources?: MachineExtension[];

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface Machines {
  @doc("Retrieves information about the model view or the instance view of a hybrid machine.")
  get is ArmResourceRead<
    Machine,
    {
      ...BaseParameters<Machine>;

      @doc("The expand expression to apply on the operation.")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("The operation to update a hybrid machine.")
  update is ArmCustomPatchSync<Machine, MachineUpdate>;

  @doc("The operation to delete a hybrid machine.")
  delete is ArmResourceDeleteSync<Machine>;

  @doc("Lists all the hybrid machines in the specified resource group. Use the nextLink property in the response to get the next page of hybrid machines.")
  listByResourceGroup is ArmResourceListByParent<
    Machine,
    {
      ...BaseParameters<Machine>;

      @doc("Expands referenced resources.")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("Lists all the hybrid machines in the specified subscription. Use the nextLink property in the response to get the next page of hybrid machines.")
  listBySubscription is ArmListBySubscription<Machine>;

  @doc("The operation to assess patches on a hybrid machine identity in Azure.")
  assessPatches is ArmResourceActionAsync<
    Machine,
    void,
    MachineAssessPatchesResult,
    {
      ...BaseParameters<Machine>;

      @doc("The name of the hybrid machine.")
      @path
      name: string;
    },
    ArmLroLocationHeader
  >;

  @doc("The operation to install patches on a hybrid machine identity in Azure.")
  installPatches is ArmResourceActionAsync<
    Machine,
    MachineInstallPatchesParameters,
    MachineInstallPatchesResult,
    {
      ...BaseParameters<Machine>;

      @doc("The name of the hybrid machine.")
      @path
      name: string;
    },
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("The operation to Upgrade Machine Extensions.")
  @operationId("UpgradeExtensions")
  upgradeExtensions is ArmResourceActionAsync<
    Machine,
    MachineExtensionUpgrade,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkProfile_Get")
  @doc("The operation to get network information of hybrid machine")
  // FIXME: NetworkProfile_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/networkProfile")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the hybrid machine.")
      @maxLength(54)
      @minLength(1)
      @pattern("^[a-zA-Z0-9-_\\.]{1,54}$")
      @path
      machineName: string;
    },
    NetworkProfile
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkScopes_GetValidationDetailsForMachine")
  @doc("Returns a Azure Arc PrivateLinkScope's validation details for a given machine.")
  // FIXME: PrivateLinkScopes_GetValidationDetailsForMachine could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.HybridCompute/machines/{machineName}/privateLinkScopes/current")
  @get
  getValidationDetailsForMachine is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the target machine to get the private link scope validation details for.")
      @minLength(1)
      @path
      machineName: string;
    },
    PrivateLinkScopeValidationDetails
  >;
}

@@projectedName(Machines.update::parameters.properties, "json", "parameters");
@@extension(Machines.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Machines.update::parameters.properties,
  "Parameters supplied to the Update hybrid machine operation."
);
@@projectedName(Machines.installPatches::parameters.body,
  "json",
  "installPatchesInput"
);
@@extension(Machines.installPatches::parameters.body,
  "x-ms-client-name",
  "installPatchesInput"
);
@@doc(Machines.installPatches::parameters.body,
  "Input for InstallPatches as directly received by the API"
);
@@projectedName(Machines.upgradeExtensions::parameters.body,
  "json",
  "extensionUpgradeParameters"
);
@@extension(Machines.upgradeExtensions::parameters.body,
  "x-ms-client-name",
  "extensionUpgradeParameters"
);
@@doc(Machines.upgradeExtensions::parameters.body,
  "Parameters supplied to the Upgrade Extensions operation."
);
