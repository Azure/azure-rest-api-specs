import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Workloads;
@doc("Define the Virtual Instance for SAP solutions resource.")
model SAPVirtualInstance is TrackedResource<SAPVirtualInstanceProperties> {
  @doc("The name of the Virtual Instances for SAP solutions resource")
  @key("sapVirtualInstanceName")
  @segment("sapVirtualInstances")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface SAPVirtualInstances {
  @doc("Gets a Virtual Instance for SAP solutions resource")
  get is ArmResourceRead<SAPVirtualInstance>;

  @doc("Creates a Virtual Instance for SAP solutions (VIS) resource")
  create is ArmResourceCreateOrUpdateAsync<SAPVirtualInstance>;

  @doc("Updates a Virtual Instance for SAP solutions resource")
  update is ArmCustomPatchSync<
    SAPVirtualInstance,
    UpdateSAPVirtualInstanceRequest
  >;

  @doc("Deletes a Virtual Instance for SAP solutions resource and its child resources, that is the associated Central Services Instance, Application Server Instances and Database Instance.")
  delete is ArmResourceDeleteAsync<SAPVirtualInstance>;

  @doc("Gets all Virtual Instances for SAP solutions resources in a Resource Group.")
  listByResourceGroup is ArmResourceListByParent<SAPVirtualInstance>;

  @doc("Gets all Virtual Instances for SAP solutions resources in a Subscription.")
  listBySubscription is ArmListBySubscription<SAPVirtualInstance>;

  @doc("Starts the SAP application, that is the Central Services instance and Application server instances.")
  start is ArmResourceActionAsync<
    SAPVirtualInstance,
    void,
    OperationStatusResult
  >;

  @doc("Stops the SAP Application, that is the Application server instances and Central Services instance.")
  stop is ArmResourceActionAsync<
    SAPVirtualInstance,
    StopRequest,
    OperationStatusResult
  >;
}
