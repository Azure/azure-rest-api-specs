import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AzureLargeInstance;
@doc("""
Azure Large Instance info on Azure (ARM properties and AzureLargeInstance
properties)
""")
model AzureLargeInstance is ProxyResource<AzureLargeInstanceProperties> {
  @doc("Name of the AzureLargeInstance.")
  @pattern(".*")
  @path
  @key("azureLargeInstanceName")
  @segment("azureLargeInstances")
  name: string;
}

@armResourceOperations
@friendlyName("AzureLargeInstance")
interface AzureLargeInstances {
  @doc("""
Gets an Azure Large Instance for the specified subscription, resource group,
and instance name.
""")
  get is ArmResourceRead<AzureLargeInstance>;
  @doc("""
Patches the Tags field of an Azure Large Instance for the specified
subscription, resource group, and instance name.
""")
  update is ArmTagsPatchSync<AzureLargeInstance>;
  @doc("""
Gets a list of Azure Large Instances in the specified subscription and resource
group. The operations returns various properties of each Azure Large Instance.
""")
  listByResourceGroup is ArmResourceListByParent<AzureLargeInstance>;
  @doc("""
Gets a list of Azure Large Instances in the specified subscription. The
operations returns various properties of each Azure Large Instance.
""")
  listBySubscription is ArmListBySubscription<AzureLargeInstance>;
  // FIXME: (ArmResourceAction): ArmResourceActionSync/ArmResourceActionAsync should have a body parameter
  @doc("The operation to start an Azure Large Instance (only for compute instances)")
  start is ArmResourceActionAsync<
    AzureLargeInstance,
    {},
    OperationStatusResult
  >;
  @doc("The operation to restart an Azure Large Instance (only for compute instances)")
  restart is ArmResourceActionAsync<
    AzureLargeInstance,
    ForceState,
    OperationStatusResult
  >;
  // FIXME: (ArmResourceAction): ArmResourceActionSync/ArmResourceActionAsync should have a body parameter
  @doc("The operation to shutdown an Azure Large Instance (only for compute instances)")
  shutdown is ArmResourceActionAsync<
    AzureLargeInstance,
    {},
    OperationStatusResult
  >;
}

@@TypeSpec.OpenAPI.extension(AzureLargeInstances.restart::parameters.body,
  "x-ms-client-name",
  "forceParameter"
);
@@projectedName(AzureLargeInstances.restart::parameters.body, "json", "forceParameter");