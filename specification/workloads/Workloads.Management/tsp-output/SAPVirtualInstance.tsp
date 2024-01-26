import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
/**
 * Define the Virtual Instance for SAP solutions resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(SAPVirtualInstanceProperties)
model SAPVirtualInstance extends TrackedResourceBase {
  /**
   * The name of the Virtual Instances for SAP solutions resource
   */
  @path
  @key("sapVirtualInstanceName")
  @segment("sapVirtualInstances")
  @visibility("read")
  name: string;

  /**
   * Defines the Virtual Instance for SAP solutions resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: SAPVirtualInstanceProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface SAPVirtualInstances {
  /**
   * Gets a Virtual Instance for SAP solutions resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPVirtualInstances_Get")
  get is ArmResourceRead<SAPVirtualInstance>;

  /**
   * Creates a Virtual Instance for SAP solutions (VIS) resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPVirtualInstances_Create")
  create is ArmResourceCreateOrReplaceAsync<
    SAPVirtualInstance,
    BaseParameters<SAPVirtualInstance>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates a Virtual Instance for SAP solutions resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("SAPVirtualInstances_Update")
  update is ArmCustomPatchSync<
    SAPVirtualInstance,
    UpdateSAPVirtualInstanceRequest
  >;

  /**
   * Deletes a Virtual Instance for SAP solutions resource and its child resources, that is the associated Central Services Instance, Application Server Instances and Database Instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPVirtualInstances_Delete")
  delete is ArmResourceDeleteAsync<
    SAPVirtualInstance,
    BaseParameters<SAPVirtualInstance>,
    ArmAsyncOperationHeader
  >;

  /**
   * Gets all Virtual Instances for SAP solutions resources in a Resource Group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPVirtualInstances_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<SAPVirtualInstance>;

  /**
   * Gets all Virtual Instances for SAP solutions resources in a Subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPVirtualInstances_ListBySubscription")
  listBySubscription is ArmListBySubscription<SAPVirtualInstance>;

  /**
   * Starts the SAP application, that is the Central Services instance and Application server instances.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPVirtualInstances_Start")
  start is ArmResourceActionAsync<
    SAPVirtualInstance,
    void,
    OperationStatusResult,
    BaseParameters<SAPVirtualInstance>,
    ArmAsyncOperationHeader
  >;

  /**
   * Stops the SAP Application, that is the Application server instances and Central Services instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SAPVirtualInstances_Stop")
  stop is ArmResourceActionAsync<
    SAPVirtualInstance,
    StopRequest,
    OperationStatusResult,
    BaseParameters<SAPVirtualInstance>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(SAPVirtualInstances.create::parameters.resource,
  "json",
  "body"
);
@@extension(SAPVirtualInstances.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(SAPVirtualInstances.create::parameters.resource,
  "Virtual Instance for SAP solutions resource request body."
);
@@projectedName(SAPVirtualInstances.update::parameters.properties,
  "json",
  "body"
);
@@extension(SAPVirtualInstances.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(SAPVirtualInstances.update::parameters.properties,
  "Request body to update a Virtual Instance for SAP solutions resource."
);
@@doc(SAPVirtualInstances.stop::parameters.body,
  "The Virtual Instance for SAP solutions resource stop request body."
);
