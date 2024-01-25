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
 * The IP Extended Community resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  IpExtendedCommunityProperties
)
model IpExtendedCommunity extends TrackedResourceBase {
  /**
   * Name of the IP Extended Community.
   */
  @path
  @key("ipExtendedCommunityName")
  @segment("ipExtendedCommunities")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: IpExtendedCommunityProperties;
}

@armResourceOperations
interface IpExtendedCommunities {
  /**
   * Implements IP Extended Community GET method.
   */
  get is ArmResourceRead<IpExtendedCommunity>;

  /**
   * Implements IP Extended Community PUT method.
   */
  create is ArmResourceCreateOrReplaceAsync<
    IpExtendedCommunity,
    BaseParameters<IpExtendedCommunity>,
    ArmAsyncOperationHeader
  >;

  /**
   * API to update certain properties of the IP Extended Community resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    IpExtendedCommunity,
    IpExtendedCommunityPatch,
    BaseParameters<IpExtendedCommunity>,
    ArmLroLocationHeader
  >;

  /**
   * Implements IP Extended Community DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    IpExtendedCommunity,
    BaseParameters<IpExtendedCommunity>,
    ArmLroLocationHeader
  >;

  /**
   * Implements IpExtendedCommunities list by resource group GET method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IpExtendedCommunities_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<IpExtendedCommunity>;

  /**
   * Implements IpExtendedCommunities list by subscription GET method.
   */
  listBySubscription is ArmListBySubscription<IpExtendedCommunity>;
}

@@projectedName(IpExtendedCommunities.create::parameters.resource,
  "json",
  "body"
);
@@extension(IpExtendedCommunities.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(IpExtendedCommunities.create::parameters.resource, "Request payload.");
@@projectedName(IpExtendedCommunities.update::parameters.properties,
  "json",
  "body"
);
@@extension(IpExtendedCommunities.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(IpExtendedCommunities.update::parameters.properties,
  "IP Extended Community properties to update."
);
