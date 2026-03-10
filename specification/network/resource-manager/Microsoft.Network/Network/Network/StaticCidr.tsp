import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IpamPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Instance of StaticCidr resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@parentResource(IpamPool)
model StaticCidr extends CommonProxyResource {
  /**
   * Properties of the static CIDR.
   */
  properties?: StaticCidrProperties;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("staticCidrName")
  @segment("staticCidrs")
  @pattern("^[0-9a-zA-Z]([0-9a-zA-Z_.-]{0,62}[0-9a-zA-Z_])?$")
  name: string;
}

@@doc(StaticCidr.name, "The name of the resource");

alias StaticCidrOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @segment("networkManagers")
    @key
    @pattern("^[0-9a-zA-Z]([0-9a-zA-Z_.-]{0,62}[0-9a-zA-Z_])?$")
    networkManagerName: string;

    /** The name of the IPAM pool. */
    @path
    @segment("ipamPools")
    @key
    @pattern("^[0-9a-zA-Z]([0-9a-zA-Z_.-]{0,62}[0-9a-zA-Z_])?$")
    poolName: string;
  },
  {
    /** Name for the static CIDR. */
    @path
    @segment("staticCidrs")
    @key
    @pattern("^[0-9a-zA-Z]([0-9a-zA-Z_.-]{0,62}[0-9a-zA-Z_])?$")
    staticCidrName: string;
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations
interface StaticCidrs {
  /**
   * Gets the specific Static CIDR resource.
   */
  @summary("Gets the specific Static CIDR resource.")
  get is ArmResourceRead<StaticCidr, Error = CommonErrorResponse>;

  /**
   * Creates/Updates the Static CIDR resource.
   */
  @summary("Creates/Updates the Static CIDR resource.")
  create is StaticCidrOps.CreateOrUpdateSync<
    StaticCidr,
    OptionalRequestBody = true,
    OverrideErrorType = CommonErrorResponse
  >;

  /**
   * Delete the Static CIDR resource.
   */
  @summary("Delete the Static CIDR resource.")
  delete is ArmResourceDeleteWithoutOkAsync<
    StaticCidr,
    Error = CommonErrorResponse
  >;

  /**
   * Gets list of Static CIDR resources at Network Manager level.
   */
  @summary("Gets list of Static CIDR resources at Network Manager level.")
  list is ArmResourceListByParent<
    StaticCidr,
    Parameters = {
      /**
       * Optional skip token.
       */
      @query("skipToken")
      skipToken?: string;

      /**
       * Optional num entries to skip.
       */
      @query("skip")
      skip?: int32 = 0;

      /**
       * Optional num entries to show.
       */
      @query("top")
      top?: int32 = 50;

      /**
       * Optional key by which to sort.
       */
      @query("sortKey")
      sortKey?: string;

      /**
       * Optional sort value for pagination.
       */
      @query("sortValue")
      sortValue?: string;
    },
    Response = ArmResponse<StaticCidrList>,
    Error = CommonErrorResponse
  >;
}

@@doc(StaticCidr.name, "StaticCidr resource name to retrieve.");
@@doc(StaticCidr.properties, "Properties of static CIDR resource.");
@@doc(StaticCidrs.create::parameters.resource,
  "StaticCidr resource object to create/update."
);
