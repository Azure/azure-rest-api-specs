import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * Represents a share on the  Data Box Edge/Gateway device.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(DataBoxEdgeDevice)
@Azure.ResourceManager.Private.armResourceInternal(ShareProperties)
@includeInapplicableMetadataInPayload(false)
model Share extends ProxyResourceBase {
  /**
   * The share name.
   */
  @path
  @key("name")
  @segment("shares")
  name: string;

  /**
   * The share properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: ShareProperties;
}

@armResourceOperations
interface Shares {
  /**
   * Gets a share by name.
   */
  get is ArmResourceRead<Share>;

  /**
   * Creates a new share or updates an existing share on the device.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Share>;

  /**
   * Deletes the share on the Data Box Edge/Data Box Gateway device.
   */
  delete is ArmResourceDeleteAsync<Share>;

  /**
   * Lists all the shares in a Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Shares_ListByDataBoxEdgeDevice")
  listByDataBoxEdgeDevice is ArmResourceListByParent<Share>;

  /**
   * Refreshes the share metadata with the data from the cloud.
   */
  refresh is ArmResourceActionAsync<Share, void, void>;
}

@@projectedName(Shares.createOrUpdate::parameters.resource, "json", "share");
@@extension(Shares.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "share"
);
@@doc(Shares.createOrUpdate::parameters.resource, "The share properties.");
