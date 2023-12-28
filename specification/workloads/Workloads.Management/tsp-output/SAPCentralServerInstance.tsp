import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SAPVirtualInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Workloads;
@doc("Define the SAP Central Services Instance resource.")
@parentResource(SAPVirtualInstance)
model SAPCentralServerInstance is TrackedResource<SAPCentralServerProperties> {
  @doc("Central Services Instance resource name string modeled as parameter for auto generation to work correctly.")
  @key("centralInstanceName")
  @segment("centralInstances")
  name: string;
}

@armResourceOperations
interface SAPCentralInstances {
  @doc("Gets the SAP Central Services Instance resource.")
  get is ArmResourceRead<SAPCentralServerInstance>;
  @doc("Creates the SAP Central Services Instance resource. &lt;br&gt;&lt;br&gt;This will be used by service only. PUT operation on this resource by end user will return a Bad Request error.")
  create is ArmResourceCreateOrUpdateAsync<SAPCentralServerInstance>;
  @doc("Updates the SAP Central Services Instance resource. &lt;br&gt;&lt;br&gt;This can be used to update tags on the resource.")
  update is ArmCustomPatchAsync<
    SAPCentralServerInstance,
    UpdateSAPCentralInstanceRequest
  >;
  @doc("Deletes the SAP Central Services Instance resource. &lt;br&gt;&lt;br&gt;This will be used by service only. Delete operation on this resource by end user will return a Bad Request error. You can delete the parent resource, which is the Virtual Instance for SAP solutions resource, using the delete operation on it.")
  delete is ArmResourceDeleteAsync<SAPCentralServerInstance>;
  @doc("Lists the SAP Central Services Instance resource for the given Virtual Instance for SAP solutions resource.")
  list is ArmResourceListByParent<SAPCentralServerInstance>;
  @doc("Starts the SAP Central Services Instance.")
  startInstance is ArmResourceActionAsync<
    SAPCentralServerInstance,
    void,
    OperationStatusResult
  >;
  @doc("Stops the SAP Central Services Instance.")
  stopInstance is ArmResourceActionAsync<
    SAPCentralServerInstance,
    StopRequest,
    OperationStatusResult
  >;
}
