import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("A managed instance key.")
@parentResource(ManagedInstance)
model ManagedInstanceKey is ProxyResource<ManagedInstanceKeyProperties> {
  @doc("The name of the managed instance key to be retrieved.")
  @path
  @key("keyName")
  @segment("keys")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ManagedInstanceKeys {
  @doc("Gets a managed instance key.")
  get is ArmResourceRead<ManagedInstanceKey>;

  @doc("Creates or updates a managed instance key.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedInstanceKey>;

  @doc("Deletes the managed instance key with the given name.")
  delete is ArmResourceDeleteAsync<ManagedInstanceKey>;

  @doc("Gets a list of managed instance keys.")
  listByInstance is ArmResourceListByParent<
    ManagedInstanceKey,
    {
      ...BaseParameters<ManagedInstanceKey>;

      @doc("An OData filter expression that filters elements in the collection.")
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@projectedName(ManagedInstanceKeys.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedInstanceKeys.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedInstanceKeys.createOrUpdate::parameters.resource,
  "The requested managed instance key resource state."
);
