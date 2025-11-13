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
@parentResource(NetworkManager)
model IpamPool
  is Azure.ResourceManager.TrackedResource<IpamPoolProperties, false> {
  ...ResourceNameParameter<
    Resource = IpamPool,
    KeyName = "poolName",
    SegmentName = "ipamPools",
    NamePattern = "^[0-9a-zA-Z]([0-9a-zA-Z_.-]{0,62}[0-9a-zA-Z_])?$"
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface IpamPools {
  /**
   * Gets the specific Pool resource.
   */
  get is ArmResourceRead<IpamPool>;

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
      `If-Match`?: string;
    }
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
      `If-Match`?: string;
    }
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
  getPoolUsage is ArmResourceActionSync<IpamPool, void, ArmResponse<PoolUsage>>;

  /**
   * List Associated Resource in the Pool.
   */
  @list
  listAssociatedResources is ArmResourceActionSync<
    IpamPool,
    void,
    ArmResponse<PoolAssociationList>
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
