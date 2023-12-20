import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SapVirtualInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Workloads;
@doc("Define the SAP Application Server Instance resource.")
@parentResource(SapVirtualInstance)
model SapApplicationServerInstance
  is TrackedResource<SAPApplicationServerProperties> {
  @doc("The name of SAP Application Server instance resource.")
  @path
  @key("applicationInstanceName")
  @segment("applicationInstances")
  name: string;
}

@armResourceOperations
interface SapApplicationServerInstances {
  @doc("Gets the SAP Application Server Instance corresponding to the Virtual Instance for SAP solutions resource.")
  get is ArmResourceRead<SapApplicationServerInstance>;
  @doc("Puts the SAP Application Server Instance resource. &lt;br&gt;&lt;br&gt;This will be used by service only. PUT by end user will return a Bad Request error.")
  create is ArmResourceCreateOrUpdateAsync<SapApplicationServerInstance>;
  @doc("Puts the SAP Application Server Instance resource.")
  update is ArmTagsPatchAsync<SapApplicationServerInstance>;
  @doc("Deletes the SAP Application Server Instance resource. &lt;br&gt;&lt;br&gt;This operation will be used by service only. Delete by end user will return a Bad Request error.")
  delete is ArmResourceDeleteAsync<SapApplicationServerInstance>;
  @doc("Lists the SAP Application Server Instance resources for a given Virtual Instance for SAP solutions resource.")
  list is ArmResourceListByParent<SapApplicationServerInstance>;
  @doc("Starts the SAP Application Server Instance.")
  startInstance is ArmResourceActionAsync<
    SapApplicationServerInstance,
    void,
    OperationStatusResult
  >;
  @doc("Stops the SAP Application Server Instance.")
  stopInstance is ArmResourceActionAsync<
    SapApplicationServerInstance,
    StopRequest,
    OperationStatusResult
  >;
}
