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
@doc("Define the Virtual Instance for SAP solutions resource.")
model SAPVirtualInstance is TrackedResource<SAPVirtualInstanceProperties> {
  @doc("The name of the Virtual Instances for SAP solutions resource")
  @pattern("^[a-zA-Z][a-zA-Z0-9]{2}$")
  @path
  @key("sapVirtualInstanceName")
  @segment("sapVirtualInstances")
  name: string;

  identity?: UserAssignedServiceIdentity;
}

@armResourceOperations
interface SAPVirtualInstances {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a Virtual Instance for SAP solutions resource")
  @operationId("SAPVirtualInstances_Get")
  get is ArmResourceRead<SAPVirtualInstance>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a Virtual Instance for SAP solutions (VIS) resource")
  @operationId("SAPVirtualInstances_Create")
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  create is ArmResourceCreateOrUpdateAsync<
    SAPVirtualInstance,
    BaseParameters<SAPVirtualInstance>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates a Virtual Instance for SAP solutions resource")
  @operationId("SAPVirtualInstances_Update")
  update is ArmCustomPatchAsync<
    SAPVirtualInstance,
    UpdateSAPVirtualInstanceRequest,
    BaseParameters<SAPVirtualInstance>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a Virtual Instance for SAP solutions resource and its child resources, that is the associated Central Services Instance, Application Server Instances and Database Instance.")
  @operationId("SAPVirtualInstances_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    SAPVirtualInstance,
    BaseParameters<SAPVirtualInstance>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all Virtual Instances for SAP solutions resources in a Resource Group.")
  @operationId("SAPVirtualInstances_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<SAPVirtualInstance>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all Virtual Instances for SAP solutions resources in a Subscription.")
  @operationId("SAPVirtualInstances_ListBySubscription")
  listBySubscription is ArmListBySubscription<SAPVirtualInstance>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Starts the SAP application, that is the Central Services instance and Application server instances.")
  @operationId("SAPVirtualInstances_Start")
  start is ArmResourceActionAsync<
    SAPVirtualInstance,
    StartRequest,
    OperationStatusResult,
    BaseParameters<SAPVirtualInstance>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Stops the SAP Application, that is the Application server instances and Central Services instance.")
  @operationId("SAPVirtualInstances_Stop")
  stop is ArmResourceActionAsync<
    SAPVirtualInstance,
    StopRequest,
    OperationStatusResult,
    BaseParameters<SAPVirtualInstance>,
    ArmLroLocationHeader
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
@@doc(SAPVirtualInstances.start::parameters.body,
  "The Virtual Instance for SAP solutions resource start request body."
);
@@doc(SAPVirtualInstances.stop::parameters.body,
  "The Virtual Instance for SAP solutions resource stop request body."
);
