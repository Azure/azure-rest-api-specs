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

namespace Microsoft.ManagedNetworkFabric;
/**
 * The IP Community resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(IpCommunityProperties)
@includeInapplicableMetadataInPayload(false)
model IpCommunity extends TrackedResourceBase {
  /**
   * Name of the IP Community.
   */
  @path
  @key("ipCommunityName")
  @segment("ipCommunities")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: IpCommunityProperties;
}

@armResourceOperations
interface IpCommunities {
  /**
   * Implements an IP Community GET method.
   */
  get is ArmResourceRead<IpCommunity>;

  /**
   * Implements an IP Community PUT method.
   */
  create is ArmResourceCreateOrReplaceAsync<
    IpCommunity,
    BaseParameters<IpCommunity>,
    ArmAsyncOperationHeader
  >;

  /**
   * API to update certain properties of the IP Community resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    IpCommunity,
    IpCommunityPatch,
    BaseParameters<IpCommunity>,
    ArmLroLocationHeader
  >;

  /**
   * Implements IP Community DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    IpCommunity,
    BaseParameters<IpCommunity>,
    ArmLroLocationHeader
  >;

  /**
   * Implements IP Communities list by resource group GET method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IpCommunities_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<IpCommunity>;

  /**
   * Implements IP Communities list by subscription GET method.
   */
  listBySubscription is ArmListBySubscription<IpCommunity>;
}

@@projectedName(IpCommunities.create::parameters.resource, "json", "body");
@@extension(IpCommunities.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(IpCommunities.create::parameters.resource, "Request payload.");
@@projectedName(IpCommunities.update::parameters.properties, "json", "body");
@@extension(IpCommunities.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(IpCommunities.update::parameters.properties,
  "IP Community properties to update."
);
