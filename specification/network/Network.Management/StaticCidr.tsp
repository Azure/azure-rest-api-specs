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
@parentResource(IpamPool)
model StaticCidr is Azure.ResourceManager.ProxyResource<StaticCidrProperties> {
  ...ResourceNameParameter<
    Resource = StaticCidr,
    KeyName = "staticCidrName",
    SegmentName = "staticCidrs",
    NamePattern = "^[0-9a-zA-Z]([0-9a-zA-Z_.-]{0,62}[0-9a-zA-Z_])?$"
  >;
}

alias StaticCidrOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

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
