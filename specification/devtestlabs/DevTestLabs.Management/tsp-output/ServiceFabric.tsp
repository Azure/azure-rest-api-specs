import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./User.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
@doc("A Service Fabric.")
@parentResource(User)
model ServiceFabric is TrackedResource<ServiceFabricProperties> {
  @doc("The name of the service fabric.")
  @path
  @key("name")
  @segment("servicefabrics")
  name: string;
}

@armResourceOperations
interface ServiceFabrics {
  @doc("Get service fabric.")
  get is ArmResourceRead<
    ServiceFabric,
    {
      ...BaseParameters<ServiceFabric>;

      @doc("Specify the $expand query. Example: 'properties($expand=applicableSchedule)'")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("Create or replace an existing service fabric. This operation can take a while to complete.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServiceFabric>;

  @doc("Allows modifying tags of service fabrics. All other properties will be ignored.")
  update is ArmCustomPatchSync<ServiceFabric, ServiceFabricFragment>;

  @doc("Delete service fabric. This operation can take a while to complete.")
  delete is ArmResourceDeleteAsync<ServiceFabric>;

  @doc("List service fabrics in a given user profile.")
  list is ArmResourceListByParent<
    ServiceFabric,
    {
      ...BaseParameters<ServiceFabric>;

      @doc("Specify the $expand query. Example: 'properties($expand=applicableSchedule)'")
      @query("$expand")
      $expand?: string;

      @doc("The filter to apply to the operation. Example: '$filter=contains(name,'myName')")
      @query("$filter")
      $filter?: string;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'")
      @query("$top")
      $top?: int32;

      @doc("The ordering expression for the results, using OData notation. Example: '$orderby=name desc'")
      @query("$orderby")
      $orderby?: string;
    }
  >;

  @doc("Lists the applicable start/stop schedules, if any.")
  listApplicableSchedules is ArmResourceActionSync<
    ServiceFabric,
    void,
    ApplicableSchedule
  >;

  @doc("Start a service fabric. This operation can take a while to complete.")
  start is ArmResourceActionAsync<ServiceFabric, void, void>;

  @doc("Stop a service fabric This operation can take a while to complete.")
  stop is ArmResourceActionAsync<ServiceFabric, void, void>;
}

@@projectedName(ServiceFabrics.createOrUpdate::parameters.resource,
  "json",
  "serviceFabric"
);
@@extension(ServiceFabrics.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "serviceFabric"
);
@@doc(ServiceFabrics.createOrUpdate::parameters.resource, "A Service Fabric.");
@@projectedName(ServiceFabrics.update::parameters.properties,
  "json",
  "serviceFabric"
);
@@extension(ServiceFabrics.update::parameters.properties,
  "x-ms-client-name",
  "serviceFabric"
);
@@doc(ServiceFabrics.update::parameters.properties, "A Service Fabric.");
