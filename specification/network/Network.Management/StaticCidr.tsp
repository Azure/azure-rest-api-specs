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

@armResourceOperations
interface StaticCidrs {
  /**
   * Gets the specific Static CIDR resource.
   */
  get is ArmResourceRead<StaticCidr>;

  /**
   * Creates/Updates the Static CIDR resource.
   */
  create is ArmResourceCreateOrReplaceSync<StaticCidr>;

  /**
   * Delete the Static CIDR resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<StaticCidr>;

  /**
   * Gets list of Static CIDR resources at Network Manager level.
   */
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
      skip?: int32;

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
    Response = ArmResponse<StaticCidrList>
  >;
}

@@doc(StaticCidr.name, "StaticCidr resource name to retrieve.");
@@doc(StaticCidr.properties, "Properties of static CIDR resource.");
@@doc(StaticCidrs.create::parameters.resource,
  "StaticCidr resource object to create/update."
);
