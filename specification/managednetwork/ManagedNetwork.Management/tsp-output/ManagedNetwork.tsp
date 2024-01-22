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

namespace Microsoft.ManagedNetwork;
/**
 * The Managed Network resource
 */
model ManagedNetwork is TrackedResource<ManagedNetworkProperties> {
  /**
   * The name of the Managed Network.
   */
  @path
  @key("managedNetworkName")
  @segment("managedNetworks")
  name: string;
}

@armResourceOperations
interface ManagedNetworks {
  /**
   * The Get ManagedNetworks operation gets a Managed Network Resource, specified by the resource group and Managed Network name
   */
  get is ArmResourceRead<ManagedNetwork>;

  /**
   * The Put ManagedNetworks operation creates/updates a Managed Network Resource, specified by resource group and Managed Network name
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<ManagedNetwork>;

  /**
   * Updates the specified Managed Network resource tags.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    ManagedNetwork,
    ManagedNetworkUpdate,
    BaseParameters<ManagedNetwork>,
    ArmAsyncOperationHeader
  >;

  /**
   * The Delete ManagedNetworks operation deletes a Managed Network Resource, specified by the  resource group and Managed Network name
   */
  delete is ArmResourceDeleteAsync<
    ManagedNetwork,
    BaseParameters<ManagedNetwork>,
    ArmAsyncOperationHeader
  >;

  /**
   * The ListByResourceGroup ManagedNetwork operation retrieves all the Managed Network resources in a resource group in a paginated format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedNetworks_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    ManagedNetwork,
    {
      ...BaseParameters<ManagedNetwork>;

      /**
       * May be used to limit the number of results in a page for list queries.
       */
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;

  /**
   * The ListBySubscription  ManagedNetwork operation retrieves all the Managed Network Resources in the current subscription in a paginated format.
   */
  listBySubscription is ArmListBySubscription<ManagedNetwork>;
}

@@projectedName(ManagedNetworks.createOrUpdate::parameters.resource,
  "json",
  "managedNetwork"
);
@@extension(ManagedNetworks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "managedNetwork"
);
@@doc(ManagedNetworks.createOrUpdate::parameters.resource,
  "Parameters supplied to the create/update a Managed Network Resource"
);
@@projectedName(ManagedNetworks.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ManagedNetworks.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedNetworks.update::parameters.properties,
  "Parameters supplied to update application gateway tags and/or scope."
);
