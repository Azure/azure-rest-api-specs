import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Bastion Host resource.
 */
model BastionHost
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<BastionHostPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = BastionHost,
    KeyName = "bastionHostName",
    SegmentName = "bastionHosts",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.AvailabilityZonesProperty;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;

  /**
   * The sku of this Bastion Host.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;
}

@armResourceOperations
interface BastionHosts {
  /**
   * Gets the specified Bastion Host.
   */
  get is ArmResourceRead<BastionHost, Error = CloudError>;

  /**
   * Creates or updates the specified Bastion Host.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BastionHost,
    Error = CloudError
  >;

  /**
   * Updates Tags for BastionHost resource
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchAsync<
    BastionHost,
    PatchModel = TagsObject,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = BastionHost> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Deletes the specified Bastion Host.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    BastionHost,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all Bastion Hosts in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    BastionHost,
    Error = CloudError
  >;

  /**
   * Lists all Bastion Hosts in a subscription.
   */
  list is ArmListBySubscription<BastionHost, Error = CloudError>;

  /**
   * Creates a Bastion Shareable Links for all the VMs specified in the request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PutBastionShareableLink")
  @list
  @action("createShareableLinks")
  putBastionShareableLink is ArmResourceActionAsync<
    BastionHost,
    BastionShareableLinkListRequest,
    ArmResponse<BastionShareableLinkListResult>,
    Error = CloudError
  >;

  /**
   * Deletes the Bastion Shareable Links for all the VMs specified in the request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeleteBastionShareableLink")
  @action("deleteShareableLinks")
  deleteBastionShareableLink is ArmResourceActionAsync<
    BastionHost,
    BastionShareableLinkListRequest,
    OkResponse,
    Error = CloudError
  >;

  /**
   * Deletes the Bastion Shareable Links for all the tokens specified in the request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeleteBastionShareableLinkByToken")
  @action("deleteShareableLinksByToken")
  deleteBastionShareableLinkByToken is ArmResourceActionAsyncBase<
    BastionHost,
    Request = BastionShareableLinkTokenListRequest,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BastionHost>,
    Error = CloudError
  >;

  /**
   * Return the Bastion Shareable Links for all the VMs specified in the request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GetBastionShareableLink")
  @list
  @action("getShareableLinks")
  getBastionShareableLink is ArmResourceActionSync<
    BastionHost,
    BastionShareableLinkListRequest,
    ArmResponse<BastionShareableLinkListResult>,
    Error = CloudError
  >;

  /**
   * Returns the list of currently active sessions on the Bastion.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GetActiveSessions")
  @list
  getActiveSessions is ArmResourceActionAsync<
    BastionHost,
    void,
    ArmResponse<BastionActiveSessionListResult>,
    Error = CloudError
  >;

  /**
   * Returns the list of currently active sessions on the Bastion.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DisconnectActiveSessions")
  @list
  disconnectActiveSessions is ArmResourceActionSync<
    BastionHost,
    SessionIds,
    ArmResponse<BastionSessionDeleteResult>,
    Error = CloudError
  >;
}

@@doc(BastionHost.name, "The name of the Bastion Host.");
@@doc(BastionHost.properties, "Represents the bastion host resource.");
@@doc(BastionHosts.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Bastion Host operation."
);
@@doc(BastionHosts.updateTags::parameters.properties,
  "Parameters supplied to update BastionHost tags."
);
@@doc(BastionHosts.putBastionShareableLink::parameters.body,
  "Post request for Create/Delete/Get Bastion Shareable Link endpoints."
);
@@doc(BastionHosts.deleteBastionShareableLink::parameters.body,
  "Post request for Create/Delete/Get Bastion Shareable Link endpoints."
);
@@doc(BastionHosts.deleteBastionShareableLinkByToken::parameters.body,
  "Post request for Delete Bastion Shareable Link By Token endpoint."
);
@@doc(BastionHosts.getBastionShareableLink::parameters.body,
  "Post request for Create/Delete/Get Bastion Shareable Link endpoints."
);
@@doc(BastionHosts.disconnectActiveSessions::parameters.body,
  "The list of sessionids to disconnect."
);
