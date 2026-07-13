import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SAPVirtualInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
@doc("Define the SAP Central Services Instance resource.")
@parentResource(SAPVirtualInstance)
model SAPCentralServerInstance is TrackedResource<SAPCentralServerProperties> {
  @doc("Central Services Instance resource name string modeled as parameter for auto generation to work correctly.")
  @pattern("^.*")
  @path
  @key("centralInstanceName")
  @segment("centralInstances")
  name: string;
}

@armResourceOperations
interface SAPCentralServerInstances {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the SAP Central Services Instance resource.")
  @operationId("SAPCentralInstances_Get")
  get is ArmResourceRead<SAPCentralServerInstance>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates the SAP Central Services Instance resource. &lt;br&gt;&lt;br&gt;This will be used by service only. PUT operation on this resource by end user will return a Bad Request error.")
  @operationId("SAPCentralInstances_Create")
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  create is ArmResourceCreateOrUpdateAsync<
    SAPCentralServerInstance,
    BaseParameters<SAPCentralServerInstance>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the SAP Central Services Instance resource. &lt;br&gt;&lt;br&gt;This can be used to update tags on the resource.")
  @operationId("SAPCentralInstances_Update")
  update is ArmCustomPatchSync<
    SAPCentralServerInstance,
    UpdateSAPCentralInstanceRequest
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the SAP Central Services Instance resource. &lt;br&gt;&lt;br&gt;This will be used by service only. Delete operation on this resource by end user will return a Bad Request error. You can delete the parent resource, which is the Virtual Instance for SAP solutions resource, using the delete operation on it.")
  @operationId("SAPCentralInstances_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    SAPCentralServerInstance,
    BaseParameters<SAPCentralServerInstance>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the SAP Central Services Instance resource for the given Virtual Instance for SAP solutions resource.")
  @operationId("SAPCentralInstances_List")
  list is ArmResourceListByParent<SAPCentralServerInstance>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Starts the SAP Central Services Instance.")
  @operationId("SAPCentralInstances_StartInstance")
  @action("start")
  startInstance is ArmResourceActionAsync<
    SAPCentralServerInstance,
    StartRequest,
    OperationStatusResult,
    BaseParameters<SAPCentralServerInstance>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Stops the SAP Central Services Instance.")
  @operationId("SAPCentralInstances_StopInstance")
  @action("stop")
  stopInstance is ArmResourceActionAsync<
    SAPCentralServerInstance,
    StopRequest,
    OperationStatusResult,
    BaseParameters<SAPCentralServerInstance>,
    ArmLroLocationHeader
  >;
}

@@projectedName(SAPCentralServerInstances.create::parameters.resource,
  "json",
  "body"
);
@@extension(SAPCentralServerInstances.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(SAPCentralServerInstances.create::parameters.resource,
  "The SAP Central Services Instance request body."
);
@@projectedName(SAPCentralServerInstances.update::parameters.properties,
  "json",
  "body"
);
@@extension(SAPCentralServerInstances.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(SAPCentralServerInstances.update::parameters.properties,
  "The SAP Central Services Instance resource request body."
);
@@doc(SAPCentralServerInstances.startInstance::parameters.body,
  "SAP Central Services instance start request body."
);
@@doc(SAPCentralServerInstances.stopInstance::parameters.body,
  "SAP Central Services instance stop request body."
);
