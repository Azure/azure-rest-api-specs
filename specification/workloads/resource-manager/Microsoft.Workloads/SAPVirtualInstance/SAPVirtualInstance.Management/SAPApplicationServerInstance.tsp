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
@doc("Define the SAP Application Server Instance resource.")
@parentResource(SAPVirtualInstance)
model SAPApplicationServerInstance
  is TrackedResource<SAPApplicationServerProperties> {
  @doc("The name of SAP Application Server instance resource.")
  @pattern("^.*")
  @path
  @key("applicationInstanceName")
  @segment("applicationInstances")
  name: string;
}

@armResourceOperations
interface SAPApplicationServerInstances {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the SAP Application Server Instance corresponding to the Virtual Instance for SAP solutions resource.")
  @operationId("SAPApplicationServerInstances_Get")
  get is ArmResourceRead<SAPApplicationServerInstance>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Puts the SAP Application Server Instance resource. &lt;br&gt;&lt;br&gt;This will be used by service only. PUT by end user will return a Bad Request error.")
  @operationId("SAPApplicationServerInstances_Create")
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  create is ArmResourceCreateOrUpdateAsync<
    SAPApplicationServerInstance,
    BaseParameters<SAPApplicationServerInstance>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the SAP Application server instance resource. This can be used to update tags on the resource.")
  @operationId("SAPApplicationServerInstances_Update")
  update is ArmCustomPatchSync<
    SAPApplicationServerInstance,
    UpdateSAPApplicationInstanceRequest
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the SAP Application Server Instance resource. &lt;br&gt;&lt;br&gt;This operation will be used by service only. Delete by end user will return a Bad Request error.")
  @operationId("SAPApplicationServerInstances_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    SAPApplicationServerInstance,
    BaseParameters<SAPApplicationServerInstance>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the SAP Application Server Instance resources for a given Virtual Instance for SAP solutions resource.")
  @operationId("SAPApplicationServerInstances_List")
  list is ArmResourceListByParent<SAPApplicationServerInstance>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Starts the SAP Application Server Instance.")
  @operationId("SAPApplicationServerInstances_StartInstance")
  @action("start")
  startInstance is ArmResourceActionAsync<
    SAPApplicationServerInstance,
    StartRequest,
    OperationStatusResult,
    BaseParameters<SAPApplicationServerInstance>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Stops the SAP Application Server Instance.")
  @operationId("SAPApplicationServerInstances_StopInstance")
  @action("stop")
  stopInstance is ArmResourceActionAsync<
    SAPApplicationServerInstance,
    StopRequest,
    OperationStatusResult,
    BaseParameters<SAPApplicationServerInstance>,
    ArmLroLocationHeader
  >;
}

@@projectedName(SAPApplicationServerInstances.create::parameters.resource,
  "json",
  "body"
);
@@extension(SAPApplicationServerInstances.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(SAPApplicationServerInstances.create::parameters.resource,
  "The SAP Application Server Instance resource request body."
);
@@projectedName(SAPApplicationServerInstances.update::parameters.properties,
  "json",
  "body"
);
@@extension(SAPApplicationServerInstances.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(SAPApplicationServerInstances.update::parameters.properties,
  "The SAP Application Server Instance resource request body."
);
@@doc(SAPApplicationServerInstances.startInstance::parameters.body,
  "SAP Application server instance start request body."
);
@@doc(SAPApplicationServerInstances.stopInstance::parameters.body,
  "SAP Application server instance stop request body."
);
