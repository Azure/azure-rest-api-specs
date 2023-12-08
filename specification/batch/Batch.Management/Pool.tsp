import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Batch;
@doc("Contains information about a pool.")
@parentResource(BatchAccount)
model Pool is ProxyResource<PoolProperties> {
  @doc("The pool name. This must be unique within the account.")
  @maxLength(64)
  @minLength(1)
  @pattern("^[a-zA-Z0-9_-]+$")
  @path
  @key("poolName")
  @segment("pools")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Pools {
  @doc("Gets information about the specified pool.")
  get is ArmResourceRead<Pool>;
  @doc("Creates a new pool inside the specified account.")
  create is ArmResourceCreateOrReplaceSync<
    Pool,
    {
      ...BaseParameters<Pool>;

      @doc("The entity state (ETag) version of the pool to update. A value of \"*\" can be used to apply the operation only if the pool already exists. If omitted, this operation will always be applied.")
      @header
      `If-Match`?: string;

      @doc("Set to '*' to allow a new pool to be created, but to prevent updating an existing pool. Other values will be ignored.")
      @header
      `If-None-Match`?: string;
    }
  >;
  @doc("Updates the properties of an existing pool.")
  update is ArmResourcePatchSync<
    Pool,
    PoolProperties,
    {
      ...BaseParameters<Pool>;

      @doc("The entity state (ETag) version of the pool to update. This value can be omitted or set to \"*\" to apply the operation unconditionally.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Deletes the specified pool.")
  delete is ArmResourceDeleteAsync<Pool>;
  @doc("Lists all of the pools in the specified account.")
  listByBatchAccount is ArmResourceListByParent<
    Pool,
    {
      ...BaseParameters<Pool>;

      @doc("The maximum number of items to return in the response.")
      @query("maxresults")
      maxresults?: int32;

      @doc("Comma separated list of properties that should be returned. e.g. \"properties/provisioningState\". Only top level properties under properties/ are valid for selection.")
      @query("$select")
      $select?: string;

      @doc("""
OData filter expression. Valid properties for filtering are:

 name
 properties/allocationState
 properties/allocationStateTransitionTime
 properties/creationTime
 properties/provisioningState
 properties/provisioningStateTransitionTime
 properties/lastModified
 properties/vmSize
 properties/interNodeCommunication
 properties/scaleSettings/autoScale
 properties/scaleSettings/fixedScale
""")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Disables automatic scaling for a pool.")
  disableAutoScale is ArmResourceActionSync<Pool, {}, Pool>;
  @doc("This does not restore the pool to its previous state before the resize operation: it only stops any further changes being made, and the pool maintains its current state. After stopping, the pool stabilizes at the number of nodes it was at when the stop operation was done. During the stop operation, the pool allocation state changes first to stopping and then to steady. A resize operation need not be an explicit resize pool request; this API can also be used to halt the initial sizing of the pool when it is created.")
  stopResize is ArmResourceActionSync<Pool, {}, Pool>;
}
