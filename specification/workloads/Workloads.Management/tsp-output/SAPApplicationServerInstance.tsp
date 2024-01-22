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
/**
 * Define the SAP Application Server Instance resource.
 */
@parentResource(SAPVirtualInstance)
model SAPApplicationServerInstance
  is TrackedResource<SAPApplicationServerProperties> {
  /**
   * The name of SAP Application Server instance resource.
   */
  @path
  @key("applicationInstanceName")
  @segment("applicationInstances")
  name: string;
}

@armResourceOperations
interface SAPApplicationServerInstances {
  /**
   * Gets the SAP Application Server Instance corresponding to the Virtual Instance for SAP solutions resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPApplicationServerInstances_Get")
  get is ArmResourceRead<SAPApplicationServerInstance>;

  /**
   * Puts the SAP Application Server Instance resource. &lt;br&gt;&lt;br&gt;This will be used by service only. PUT by end user will return a Bad Request error.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPApplicationServerInstances_Create")
  create is ArmResourceCreateOrReplaceAsync<
    SAPApplicationServerInstance,
    BaseParameters<SAPApplicationServerInstance>,
    ArmAsyncOperationHeader
  >;

  /**
   * Puts the SAP Application Server Instance resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("SAPApplicationServerInstances_Update")
  update is ArmCustomPatchAsync<
    SAPApplicationServerInstance,
    UpdateSAPApplicationInstanceRequest,
    BaseParameters<SAPApplicationServerInstance>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes the SAP Application Server Instance resource. &lt;br&gt;&lt;br&gt;This operation will be used by service only. Delete by end user will return a Bad Request error.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPApplicationServerInstances_Delete")
  delete is ArmResourceDeleteAsync<
    SAPApplicationServerInstance,
    BaseParameters<SAPApplicationServerInstance>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists the SAP Application Server Instance resources for a given Virtual Instance for SAP solutions resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPApplicationServerInstances_List")
  list is ArmResourceListByParent<SAPApplicationServerInstance>;

  /**
   * Starts the SAP Application Server Instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPApplicationServerInstances_StartInstance")
  startInstance is ArmResourceActionAsync<
    SAPApplicationServerInstance,
    void,
    OperationStatusResult,
    BaseParameters<SAPApplicationServerInstance>,
    ArmAsyncOperationHeader
  >;

  /**
   * Stops the SAP Application Server Instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPApplicationServerInstances_StopInstance")
  stopInstance is ArmResourceActionAsync<
    SAPApplicationServerInstance,
    StopRequest,
    OperationStatusResult,
    BaseParameters<SAPApplicationServerInstance>,
    ArmAsyncOperationHeader
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
@@doc(SAPApplicationServerInstances.stopInstance::parameters.body,
  "SAP Application server instance stop request body."
);
