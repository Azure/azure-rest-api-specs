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

namespace Microsoft.AzureStackHCI;
/**
 * The logical network resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(LogicalNetworkProperties)
model LogicalNetworks extends TrackedResourceBase {
  /**
   * Name of the logical network
   */
  @maxLength(64)
  @minLength(2)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[_a-zA-Z0-9]$")
  @path
  @key("logicalNetworkName")
  @segment("logicalNetworks")
  @visibility("read")
  name: string;

  /**
   * The extendedLocation of the resource.
   */
  extendedLocation?: ExtendedLocation;

  /**
   * Properties under the logical network resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: LogicalNetworkProperties;
}

@armResourceOperations
@projectedName("client", "LogicalNetworks")
interface LogicalNetworksOperationGroup {
  get is ArmResourceRead<LogicalNetworks>;

  /**
   * The operation to create or update a logical network. Please note some properties can be set only during logical network creation.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    LogicalNetworks,
    BaseParameters<LogicalNetworks>,
    ArmAsyncOperationHeader
  >;

  /**
   * The operation to update a logical network.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    LogicalNetworks,
    LogicalNetworksUpdateRequest,
    BaseParameters<LogicalNetworks>,
    ArmAsyncOperationHeader
  >;

  /**
   * The operation to delete a logical network.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    LogicalNetworks,
    BaseParameters<LogicalNetworks>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists all of the logical networks in the specified resource group. Use the nextLink property in the response to get the next page of logical networks.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LogicalNetworks_List")
  list is ArmResourceListByParent<LogicalNetworks>;

  /**
   * Lists all of the logical networks in the specified subscription. Use the nextLink property in the response to get the next page of logical networks.
   */
  listAll is ArmListBySubscription<LogicalNetworks>;
}

@@projectedName(LogicalNetworksOperationGroup.createOrUpdate::parameters.resource,
  "json",
  "logicalNetworks"
);
@@extension(LogicalNetworksOperationGroup.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "logicalNetworks"
);
@@doc(LogicalNetworksOperationGroup.createOrUpdate::parameters.resource, "");
@@projectedName(LogicalNetworksOperationGroup.update::parameters.properties,
  "json",
  "logicalNetworks"
);
@@extension(LogicalNetworksOperationGroup.update::parameters.properties,
  "x-ms-client-name",
  "logicalNetworks"
);
@@doc(LogicalNetworksOperationGroup.update::parameters.properties, "");
