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
@doc("Define the SAP Central Services Instance resource.")
@parentResource(SapVirtualInstance)
model SapCentralServerInstance is TrackedResource<SAPCentralServerProperties> {
  @doc("Central Services Instance resource name string modeled as parameter for auto generation to work correctly.")
  @path
  @key("centralInstanceName")
  @segment("centralInstances")
  name: string;
}

@armResourceOperations
interface SapCentralServerInstances {
  @doc("Gets the SAP Central Services Instance resource.")
  get is ArmResourceRead<SapCentralServerInstance>;
  @doc("Creates the SAP Central Services Instance resource. &lt;br&gt;&lt;br&gt;This will be used by service only. PUT operation on this resource by end user will return a Bad Request error.")
  create is ArmResourceCreateOrUpdateAsync<SapCentralServerInstance>;
  @doc("Updates the SAP Central Services Instance resource. &lt;br&gt;&lt;br&gt;This can be used to update tags on the resource.")
  update is ArmTagsPatchAsync<SapCentralServerInstance>;
  @doc("Deletes the SAP Central Services Instance resource. &lt;br&gt;&lt;br&gt;This will be used by service only. Delete operation on this resource by end user will return a Bad Request error. You can delete the parent resource, which is the Virtual Instance for SAP solutions resource, using the delete operation on it.")
  delete is ArmResourceDeleteAsync<SapCentralServerInstance>;
  @doc("Lists the SAP Central Services Instance resource for the given Virtual Instance for SAP solutions resource.")
  list is ArmResourceListByParent<SapCentralServerInstance>;
  @doc("Starts the SAP Central Services Instance.")
  startInstance is ArmResourceActionAsync<
    SapCentralServerInstance,
    void,
    OperationStatusResult
  >;
  @doc("Stops the SAP Central Services Instance.")
  stopInstance is ArmResourceActionAsync<
    SapCentralServerInstance,
    StopRequest,
    OperationStatusResult
  >;
}
