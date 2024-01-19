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

namespace Microsoft.DataMigration;
@doc("A Database Migration Service resource")
model DataMigrationService is TrackedResource<DataMigrationServiceProperties> {
  @doc("Name of the service")
  @path
  @key("serviceName")
  @segment("services")
  name: string;

  @doc("HTTP strong entity tag value. Ignored if submitted")
  etag?: string;

  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DataMigrationServices {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("The services resource is the top-level resource that represents the Database Migration Service. The GET method retrieves information about a service instance.")
  @operationId("Services_Get")
  get is ArmResourceRead<DataMigrationService>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("The services resource is the top-level resource that represents the Database Migration Service. The PUT method creates a new service or updates an existing one. When a service is updated, existing child resources (i.e. tasks) are unaffected. Services currently support a single kind, \"vm\", which refers to a VM-based service, although other kinds may be added in the future. This method can change the kind, SKU, and network of the service, but if tasks are currently running (i.e. the service is busy), this will fail with 400 Bad Request (\"ServiceIsBusy\"). The provider will reply when successful with 200 OK or 201 Created. Long-running operations use the provisioningState property.")
  @operationId("Services_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataMigrationService>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("The services resource is the top-level resource that represents the Database Migration Service. The PATCH method updates an existing service. This method can change the kind, SKU, and network of the service, but if tasks are currently running (i.e. the service is busy), this will fail with 400 Bad Request (\"ServiceIsBusy\").")
  @operationId("Services_Update")
  update is ArmCustomPatchAsync<DataMigrationService, DataMigrationService>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("The services resource is the top-level resource that represents the Database Migration Service. The DELETE method deletes a service. Any running tasks will be canceled.")
  @operationId("Services_Delete")
  delete is ArmResourceDeleteAsync<
    DataMigrationService,
    {
      ...BaseParameters<DataMigrationService>;

      @doc("Delete the resource even if it contains running tasks")
      @query("deleteRunningTasks")
      deleteRunningTasks?: boolean;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("The Services resource is the top-level resource that represents the Database Migration Service. This method returns a list of service resources in a resource group.")
  @operationId("Services_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<DataMigrationService>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("The services resource is the top-level resource that represents the Database Migration Service. This method returns a list of service resources in a subscription.")
  @operationId("Services_List")
  list is ArmListBySubscription<DataMigrationService>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("The services resource is the top-level resource that represents the Database Migration Service. This action performs a health check and returns the status of the service and virtual machine size.")
  @operationId("Services_CheckStatus")
  checkStatus is ArmResourceActionSync<
    DataMigrationService,
    void,
    DataMigrationServiceStatusResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("The services resource is the top-level resource that represents the Database Migration Service. This action starts the service and the service can be used for data migration.")
  @operationId("Services_Start")
  start is ArmResourceActionAsync<DataMigrationService, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("The services resource is the top-level resource that represents the Database Migration Service. This action stops the service and the service cannot be used for data migration. The service owner won't be billed when the service is stopped.")
  @operationId("Services_Stop")
  stop is ArmResourceActionAsync<DataMigrationService, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("This method checks whether a proposed nested resource name is valid and available.")
  @operationId("Services_CheckChildrenNameAvailability")
  checkChildrenNameAvailability is ArmResourceActionSync<
    DataMigrationService,
    NameAvailabilityRequest,
    NameAvailabilityResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("This method checks whether a proposed top-level resource name is valid and available.")
  @operationId("Services_CheckNameAvailability")
  checkNameAvailability is checkLocalNameAvailability<
    NameAvailabilityRequest,
    NameAvailabilityResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_ListSkus")
  @summary("Get compatible SKUs")
  @doc("The services resource is the top-level resource that represents the Database Migration Service. The skus action returns the list of SKUs that a service resource can be updated to.")
  // FIXME: Services_ListSkus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/Microsoft.DataMigration/services/{serviceName}/skus")
  @get
  listSkus is Azure.Core.Foundations.Operation<
    {
      @doc("Subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("Name of the resource group")
      @path
      groupName: string;

      @doc("Name of the service")
      @path
      serviceName: string;
    },
    ServiceSkuList
  >;
}

@@projectedName(DataMigrationServices.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(DataMigrationServices.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DataMigrationServices.createOrUpdate::parameters.resource,
  "Information about the service"
);
@@projectedName(DataMigrationServices.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(DataMigrationServices.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(DataMigrationServices.update::parameters.properties,
  "Information about the service"
);
@@projectedName(DataMigrationServices.checkChildrenNameAvailability::parameters.body,
  "json",
  "parameters"
);
@@extension(DataMigrationServices.checkChildrenNameAvailability::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(DataMigrationServices.checkChildrenNameAvailability::parameters.body,
  "Requested name to validate"
);
