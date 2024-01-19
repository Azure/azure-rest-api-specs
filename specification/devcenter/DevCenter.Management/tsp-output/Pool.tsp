import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
@doc("A pool of Virtual Machines.")
@parentResource(Project)
model Pool is TrackedResource<PoolProperties> {
  @doc("Name of the pool.")
  @path
  @key("poolName")
  @segment("pools")
  name: string;
}

@armResourceOperations
interface Pools {
  @doc("Gets a machine pool")
  get is ArmResourceRead<Pool>;

  @doc("Creates or updates a machine pool")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    Pool,
    BaseParameters<Pool>,
    ArmAsyncOperationHeader
  >;

  @doc("Partially updates a machine pool")
  update is ArmCustomPatchAsync<
    Pool,
    PoolUpdate,
    BaseParameters<Pool>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes a machine pool")
  delete is ArmResourceDeleteAsync<
    Pool,
    BaseParameters<Pool>,
    ArmAsyncOperationHeader
  >;

  @doc("Lists pools for a project")
  listByProject is ArmResourceListByParent<
    Pool,
    {
      ...BaseParameters<Pool>;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    }
  >;

  @doc("Triggers a refresh of the pool status.")
  runHealthChecks is ArmResourceActionAsync<
    Pool,
    void,
    void,
    BaseParameters<Pool>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(Pools.createOrUpdate::parameters.resource, "json", "body");
@@extension(Pools.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(Pools.createOrUpdate::parameters.resource, "Represents a machine pool");
@@projectedName(Pools.update::parameters.properties, "json", "body");
@@extension(Pools.update::parameters.properties, "x-ms-client-name", "body");
@@doc(Pools.update::parameters.properties, "Represents a machine pool");
