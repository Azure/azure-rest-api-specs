import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkManager.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Instance of Pool resource.
 */
@Http.Private.includeInapplicableMetadataInPayload(false)
@parentResource(NetworkManager)
model IpamPool extends CommonTrackedResource {
  /**
   * Properties of the Pool resource.
   */
  properties?: IpamPoolProperties;

  /** A unique read-only string that changes whenever the resource is updated. */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("poolName")
  @segment("ipamPools")
  @pattern("^[0-9a-zA-Z]([0-9a-zA-Z_.-]{0,62}[0-9a-zA-Z_])?$")
  name: string;
}

@@doc(IpamPool.name, "The name of the resource");

@armResourceOperations
interface IpamPools {
  /**
   * Gets the specific Pool resource.
   */
  get is ArmResourceRead<IpamPool, Error = CloudError>;

  /**
   * Creates/Updates the Pool resource.
   */
  create is ArmResourceCreateOrReplaceAsync<
    IpamPool,
    Parameters = {
      /**
       * The entity state (ETag) version of the pool to update. This value can be omitted or set to "*" to apply the operation unconditionally.
       */
      @header
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      `If-Match`?: string;
    },
    Error = CloudError
  >;

  /**
   * Updates the specific Pool resource.
   */
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    IpamPool,
    PatchModel = IpamPoolUpdate,
    Parameters = {
      /**
       * The entity state (ETag) version of the pool to update. This value can be omitted or set to "*" to apply the operation unconditionally.
       */
      @header
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      `If-Match`?: string;
    },
    OptionalRequestBody = true
  >;

  /**
   * Delete the Pool resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    IpamPool,
    Parameters = {
      /**
       * The entity state (ETag) version of the pool to update. This value can be omitted or set to "*" to apply the operation unconditionally.
       */
      @header
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      `If-Match`?: string;
    },
    Error = CloudError
  >;

  /**
   * Gets list of Pool resources at Network Manager level.
   */
  list is ArmResourceListByParent<
    IpamPool,
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
    Response = ArmResponse<IpamPoolList>
  >;

  /**
   * Get the Pool Usage.
   */
  getPoolUsage is ArmResourceActionSync<
    IpamPool,
    void,
    ArmResponse<PoolUsage>,
    Error = CloudError
  >;

  /**
   * List Associated Resource in the Pool.
   */
  @list
  listAssociatedResources is ArmResourceActionSync<
    IpamPool,
    void,
    ArmResponse<PoolAssociationList>,
    Error = CloudError
  >;
}

@@doc(IpamPool.name, "Pool resource name.");
@@doc(IpamPool.properties,
  "Properties of IpamPool resource properties which are specific to the Pool resource."
);
@@doc(IpamPools.create::parameters.resource,
  "Pool resource object to create/update."
);
@@doc(IpamPools.update::parameters.properties,
  "Pool resource object to update partially."
);
