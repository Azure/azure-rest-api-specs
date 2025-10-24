import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;

@doc("A pool of Virtual Machines.")
@parentResource(Project)
model Pool is Azure.ResourceManager.TrackedResource<PoolProperties> {
  ...ResourceNameParameter<
    Resource = Pool,
    KeyName = "poolName",
    SegmentName = "pools",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$"
  >;
}

@armResourceOperations
interface Pools {
  @doc("Gets a machine pool.")
  get is ArmResourceRead<Pool>;

  @doc("Creates or updates a machine pool.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Pool>;

  @doc("Partially updates a machine pool.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Pool,
    PatchModel = PoolUpdate,
    LroHeaders = ArmLroLocationHeader,
    Response = Pool | ArmAcceptedLroResponse<
      "Resource update request accepted.",
      ArmLroLocationHeader<FinalResult = Pool>
    >
  >;

  @doc("Deletes a machine pool.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Pool,
    LroHeaders = ArmLroLocationHeader
  >;

  @doc("Lists pools for a project.")
  listByProject is ArmResourceListByParent<
    Pool,
    Parameters = {
      @doc("The maximum number of resources to return from the operation. Example: '$top=10'.")
      @query("$top")
      $top?: int32;
    },
    Response = PoolListResult
  >;

  @doc("Triggers a refresh of the pool status.")
  runHealthChecks is ArmResourceActionAsyncBase<
    Pool,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Pool>
  >;
}

@@maxLength(Pool.name, 63);
@@minLength(Pool.name, 3);
@@doc(Pool.name, "Name of the pool.");
@@doc(Pool.properties, "Pool properties");
@@doc(Pools.createOrUpdate::parameters.resource, "Represents a machine pool");
@@doc(Pools.update::parameters.properties, "Represents a machine pool");
