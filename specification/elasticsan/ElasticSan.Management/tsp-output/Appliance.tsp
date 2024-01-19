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

namespace Microsoft.ResourceConnector;
@doc("Appliances definition.")
model Appliance is TrackedResource<ApplianceProperties> {
  @doc("Appliances name.")
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
  @path
  @key("resourceName")
  @segment("appliances")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Appliances {
  @doc("Gets the details of an Appliance with a specified resource group and name.")
  get is ArmResourceRead<Appliance>;

  @doc("Creates or updates an Appliance in the specified Subscription and Resource Group.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Appliance,
    BaseParameters<Appliance>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates an Appliance with the specified Resource Name in the specified Resource Group and Subscription.")
  update is ArmCustomPatchSync<Appliance, PatchableAppliance>;

  @doc("Deletes an Appliance with the specified Resource Name, Resource Group, and Subscription Id.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Appliance,
    BaseParameters<Appliance>,
    ArmAsyncOperationHeader
  >;

  @doc("Gets a list of Appliances in the specified subscription and resource group. The operation returns properties of each Appliance.")
  listByResourceGroup is ArmResourceListByParent<Appliance>;

  @doc("Gets a list of Appliances in the specified subscription. The operation returns properties of each Appliance")
  listBySubscription is ArmListBySubscription<Appliance>;

  @doc("Returns the cluster user credentials for the dedicated appliance.")
  listClusterUserCredential is ArmResourceActionSync<
    Appliance,
    void,
    ApplianceListCredentialResults
  >;

  @doc("Returns the cluster customer credentials for the dedicated appliance.")
  listKeys is ArmResourceActionSync<
    Appliance,
    void,
    ApplianceListKeysResults,
    {
      ...BaseParameters<Appliance>;

      @doc("This sets the type of artifact being returned, when empty no artifact endpoint is returned.")
      @query("artifactType")
      artifactType?: string;
    }
  >;

  @summary("Gets an Appliance upgrade graph.")
  @doc("Gets the upgrade graph of an Appliance with a specified resource group and name and specific release train.")
  // FIXME: Appliances_GetUpgradeGraph could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ResourceConnector/appliances/{resourceName}/upgradeGraphs/{upgradeGraph}")
  @get
  getUpgradeGraph is Azure.Core.Foundations.Operation<
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

      @doc("Appliances name.")
      @maxLength(63)
      @minLength(1)
      @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
      @path
      resourceName: string;

      @doc("Upgrade graph version, ex - stable")
      @path
      upgradeGraph: string;
    },
    UpgradeGraph
  >;
}

@@projectedName(Appliances.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Appliances.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Appliances.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update an Appliance."
);
@@projectedName(Appliances.update::parameters.properties, "json", "parameters");
@@extension(Appliances.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Appliances.update::parameters.properties,
  "The updatable fields of an existing Appliance."
);
