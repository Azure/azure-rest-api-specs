import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetAppAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetApp;
@doc("Capacity pool resource")
@parentResource(NetAppAccount)
model CapacityPool is TrackedResource<PoolProperties> {
  @doc("The name of the capacity pool")
  @maxLength(64)
  @minLength(1)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$")
  @path
  @key("poolName")
  @segment("capacityPools")
  name: string;

  @doc("A unique read-only string that changes whenever the resource is updated.")
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface CapacityPools {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get details of the specified capacity pool")
  @operationId("Pools_Get")
  get is ArmResourceRead<CapacityPool>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or Update a capacity pool")
  @operationId("Pools_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    CapacityPool,
    BaseParameters<CapacityPool>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Patch the specified capacity pool")
  @operationId("Pools_Update")
  update is ArmCustomPatchAsync<
    CapacityPool,
    CapacityPoolPatch,
    BaseParameters<CapacityPool>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the specified capacity pool")
  @operationId("Pools_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    CapacityPool,
    BaseParameters<CapacityPool>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all capacity pools in the NetApp Account")
  @operationId("Pools_List")
  list is ArmResourceListByParent<CapacityPool>;
}

@@projectedName(CapacityPools.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(CapacityPools.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(CapacityPools.createOrUpdate::parameters.resource,
  "Capacity pool object supplied in the body of the operation."
);
@@projectedName(CapacityPools.update::parameters.properties, "json", "body");
@@extension(CapacityPools.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(CapacityPools.update::parameters.properties,
  "Capacity pool object supplied in the body of the operation."
);
