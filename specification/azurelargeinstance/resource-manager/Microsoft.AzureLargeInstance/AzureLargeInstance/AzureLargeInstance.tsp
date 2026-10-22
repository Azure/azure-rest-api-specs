import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using Azure.ClientGenerator.Core;

namespace Microsoft.AzureLargeInstance;
@doc("""
  Azure Large Instance info on Azure (ARM properties and AzureLargeInstance
  properties)
  """)
model AzureLargeInstance is TrackedResource<AzureLargeInstanceProperties> {
  @doc("Name of the AzureLargeInstance.")
  @pattern(".*")
  @path
  @key("azureLargeInstanceName")
  @segment("azureLargeInstances")
  name: string;
}

@armResourceOperations
interface AzureLargeInstances {
  @doc("""
    Gets an Azure Large Instance for the specified subscription, resource group,
    and instance name.
    """)
  get is ArmResourceRead<AzureLargeInstance>;

  @added(Versions.v2024_08_01_preview)
  @doc("""
    Creates an Azure Large Instance for the specified subscription,
    resource group, and instance name.
    """)
  create is ArmResourceCreateOrReplaceSync<AzureLargeInstance>;

  @added(Versions.v2024_08_01_preview)
  @armResourceDelete(AzureLargeInstance)
  @doc("""
    Deletes an Azure Large Instance for the specified subscription, resource group,
    and instance name.
    """)
  delete is ArmResourceDeleteSync<AzureLargeInstance>;

  @doc("""
    Patches the Tags field of an Azure Large Instance for the specified
    subscription, resource group, and instance name.
    """)
  update is ArmCustomPatchSync<AzureLargeInstance>;

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

  @doc("The operation to start an Azure Large Instance (only for compute instances)")
  start is ArmResourceActionAsync<
    AzureLargeInstance,
    void,
    Foundations.OperationStatusResult
  >;

  @doc("The operation to restart an Azure Large Instance (only for compute instances)")
  restart is ArmResourceActionAsync<
    AzureLargeInstance,
    ForceState,
    Foundations.OperationStatusResult,
    OptionalRequestBody = true
  >;

  @doc("The operation to shutdown an Azure Large Instance (only for compute instances)")
  shutdown is ArmResourceActionAsync<
    AzureLargeInstance,
    void,
    Foundations.OperationStatusResult
  >;
}

@@doc(
  AzureLargeInstances.restart::parameters.body,
  "When set to 'active', this parameter empowers the server with the ability to forcefully terminate and halt any existing processes that may be running on the server"
);
