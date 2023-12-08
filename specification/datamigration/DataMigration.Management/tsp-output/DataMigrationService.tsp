import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataMigration;
@doc("A Database Migration Service resource")
model DataMigrationService is TrackedResource<DataMigrationServiceProperties> {
  @doc("Name of the service")
  @path
  @key("serviceName")
  @segment("services")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DataMigrationServices {
  @doc("The services resource is the top-level resource that represents the Database Migration Service. The GET method retrieves information about a service instance.")
  get is ArmResourceRead<DataMigrationService>;
  @doc("The services resource is the top-level resource that represents the Database Migration Service. The PUT method creates a new service or updates an existing one. When a service is updated, existing child resources (i.e. tasks) are unaffected. Services currently support a single kind, \"vm\", which refers to a VM-based service, although other kinds may be added in the future. This method can change the kind, SKU, and network of the service, but if tasks are currently running (i.e. the service is busy), this will fail with 400 Bad Request (\"ServiceIsBusy\"). The provider will reply when successful with 200 OK or 201 Created. Long-running operations use the provisioningState property.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataMigrationService>;
  @doc("The services resource is the top-level resource that represents the Database Migration Service. The PATCH method updates an existing service. This method can change the kind, SKU, and network of the service, but if tasks are currently running (i.e. the service is busy), this will fail with 400 Bad Request (\"ServiceIsBusy\").")
  update is ArmResourcePatchAsync<
    DataMigrationService,
    DataMigrationServiceProperties
  >;
  @doc("The services resource is the top-level resource that represents the Database Migration Service. The DELETE method deletes a service. Any running tasks will be canceled.")
  delete is ArmResourceDeleteAsync<
    DataMigrationService,
    {
      ...BaseParameters<DataMigrationService>;

      @doc("Delete the resource even if it contains running tasks")
      @query("deleteRunningTasks")
      deleteRunningTasks?: boolean;
    }
  >;
  @doc("The Services resource is the top-level resource that represents the Database Migration Service. This method returns a list of service resources in a resource group.")
  listByResourceGroup is ArmResourceListByParent<DataMigrationService>;
  @doc("The services resource is the top-level resource that represents the Database Migration Service. This method returns a list of service resources in a subscription.")
  list is ArmListBySubscription<DataMigrationService>;
  @doc("The services resource is the top-level resource that represents the Database Migration Service. This action performs a health check and returns the status of the service and virtual machine size.")
  checkStatus is ArmResourceActionSync<
    DataMigrationService,
    {},
    DataMigrationServiceStatusResponse
  >;
  @doc("The services resource is the top-level resource that represents the Database Migration Service. This action starts the service and the service can be used for data migration.")
  start is ArmResourceActionAsync<DataMigrationService, {}, {}>;
  @doc("The services resource is the top-level resource that represents the Database Migration Service. This action stops the service and the service cannot be used for data migration. The service owner won't be billed when the service is stopped.")
  stop is ArmResourceActionAsync<DataMigrationService, {}, {}>;
  @doc("This method checks whether a proposed nested resource name is valid and available.")
  checkChildrenNameAvailability is ArmResourceActionSync<
    DataMigrationService,
    NameAvailabilityRequest,
    NameAvailabilityResponse
  >;
  @summary("Get compatible SKUs")
  @doc("The services resource is the top-level resource that represents the Database Migration Service. The skus action returns the list of SKUs that a service resource can be updated to.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/Microsoft.DataMigration/services/{serviceName}/skus")
  @get
  ListSkus is Azure.Core.Foundations.Operation<
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
