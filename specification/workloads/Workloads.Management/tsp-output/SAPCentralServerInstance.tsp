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
 * Define the SAP Central Services Instance resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(SAPVirtualInstance)
@Azure.ResourceManager.Private.armResourceInternal(SAPCentralServerProperties)
@includeInapplicableMetadataInPayload(false)
model SAPCentralServerInstance extends TrackedResourceBase {
  /**
   * Central Services Instance resource name string modeled as parameter for auto generation to work correctly.
   */
  @path
  @key("centralInstanceName")
  @segment("centralInstances")
  name: string;

  /**
   * Defines the SAP Central Services Instance properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SAPCentralServerProperties;
}

@armResourceOperations
interface SAPCentralServerInstances {
  /**
   * Gets the SAP Central Services Instance resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPCentralInstances_Get")
  get is ArmResourceRead<SAPCentralServerInstance>;

  /**
   * Creates the SAP Central Services Instance resource. &lt;br&gt;&lt;br&gt;This will be used by service only. PUT operation on this resource by end user will return a Bad Request error.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPCentralInstances_Create")
  create is ArmResourceCreateOrReplaceAsync<
    SAPCentralServerInstance,
    BaseParameters<SAPCentralServerInstance>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates the SAP Central Services Instance resource. &lt;br&gt;&lt;br&gt;This can be used to update tags on the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("SAPCentralInstances_Update")
  update is ArmCustomPatchAsync<
    SAPCentralServerInstance,
    UpdateSAPCentralInstanceRequest,
    BaseParameters<SAPCentralServerInstance>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes the SAP Central Services Instance resource. &lt;br&gt;&lt;br&gt;This will be used by service only. Delete operation on this resource by end user will return a Bad Request error. You can delete the parent resource, which is the Virtual Instance for SAP solutions resource, using the delete operation on it.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPCentralInstances_Delete")
  delete is ArmResourceDeleteAsync<
    SAPCentralServerInstance,
    BaseParameters<SAPCentralServerInstance>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists the SAP Central Services Instance resource for the given Virtual Instance for SAP solutions resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPCentralInstances_List")
  list is ArmResourceListByParent<SAPCentralServerInstance>;

  /**
   * Starts the SAP Central Services Instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPCentralInstances_StartInstance")
  startInstance is ArmResourceActionAsync<
    SAPCentralServerInstance,
    void,
    OperationStatusResult,
    BaseParameters<SAPCentralServerInstance>,
    ArmAsyncOperationHeader
  >;

  /**
   * Stops the SAP Central Services Instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPCentralInstances_StopInstance")
  stopInstance is ArmResourceActionAsync<
    SAPCentralServerInstance,
    StopRequest,
    OperationStatusResult,
    BaseParameters<SAPCentralServerInstance>,
    ArmAsyncOperationHeader
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
@@doc(SAPCentralServerInstances.stopInstance::parameters.body,
  "SAP Central Services instance stop request body."
);
