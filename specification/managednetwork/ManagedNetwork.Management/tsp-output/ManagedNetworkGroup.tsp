import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetwork;
@doc("The Managed Network Group resource")
@parentResource(ManagedNetwork)
model ManagedNetworkGroup is ProxyResource<ManagedNetworkGroupProperties> {
  @doc("The name of the Managed Network Group.")
  @path
  @key("managedNetworkGroupName")
  @segment("managedNetworkGroups")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ManagedNetworkGroups {
  @doc("The Get ManagedNetworkGroups operation gets a Managed Network Group specified by the resource group, Managed Network name, and group name")
  get is ArmResourceRead<ManagedNetworkGroup>;

  @doc("The Put ManagedNetworkGroups operation creates or updates a Managed Network Group resource")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ManagedNetworkGroup,
    BaseParameters<ManagedNetworkGroup>,
    ArmAsyncOperationHeader
  >;

  @doc("The Delete ManagedNetworkGroups operation deletes a Managed Network Group specified by the resource group, Managed Network name, and group name")
  delete is ArmResourceDeleteAsync<
    ManagedNetworkGroup,
    BaseParameters<ManagedNetworkGroup>,
    ArmAsyncOperationHeader
  >;

  @doc("The ListByManagedNetwork ManagedNetworkGroup operation retrieves all the Managed Network Groups in a specified Managed Networks in a paginated format.")
  listByManagedNetwork is ArmResourceListByParent<
    ManagedNetworkGroup,
    {
      ...BaseParameters<ManagedNetworkGroup>;

      @doc("May be used to limit the number of results in a page for list queries.")
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;

      @doc("Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
}

@@projectedName(ManagedNetworkGroups.createOrUpdate::parameters.resource,
  "json",
  "managedNetworkGroup"
);
@@extension(ManagedNetworkGroups.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "managedNetworkGroup"
);
@@doc(ManagedNetworkGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create/update a Managed Network Group resource"
);
