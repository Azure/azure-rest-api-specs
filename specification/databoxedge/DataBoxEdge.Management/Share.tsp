import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * Represents a share on the  Data Box Edge/Gateway device.
 */
@parentResource(DataBoxEdgeDevice)
model Share is Azure.ResourceManager.ProxyResource<ShareProperties, false> {
  ...ResourceNameParameter<
    Resource = Share,
    KeyName = "name",
    SegmentName = "shares",
    NamePattern = ""
  >;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Share,
    Response = ArmResourceUpdatedResponse<Share> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = Share> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the share on the Data Box Edge/Data Box Gateway device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Share,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the shares in a Data Box Edge/Data Box Gateway device.
   */
  listByDataBoxEdgeDevice is ArmResourceListByParent<
    Share,
    Response = ArmResponse<ShareList>
  >;

  /**
   * Refreshes the share metadata with the data from the cloud.
   */
  refresh is ArmResourceActionAsync<Share, void, OkResponse>;
}

@@doc(Share.name, "The share name.");
@@doc(Share.properties, "The share properties.");
@@doc(Shares.createOrUpdate::parameters.resource, "The share properties.");
