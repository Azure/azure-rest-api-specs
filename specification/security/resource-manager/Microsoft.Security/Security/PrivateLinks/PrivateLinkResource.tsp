import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * A private link resource that enables secure, private connectivity to Microsoft Defender for Cloud services. This resource manages the lifecycle of private endpoint connections and provides the necessary infrastructure for private connectivity.
 */
model PrivateLinkResource
  is Azure.ResourceManager.TrackedResource<PrivateLinkProperties, false> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResource,
    KeyName = "privateLinkName",
    SegmentName = "privateLinks",
    NamePattern = "^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$"
  >;
}

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Get a private link resource. Returns the configuration and status of private endpoint connectivity for Microsoft Defender for Cloud services in the specified region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinks_Get")
  get is ArmResourceRead<PrivateLinkResource>;

  /**
   * Checks whether private link exists.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinks_Head")
  head is ArmResourceCheckExistence<PrivateLinkResource, Response = OkResponse>;

  /**
   * Create a private link resource. This operation creates the necessary infrastructure to enable private endpoint connections to Microsoft Defender for Cloud services. For updates to existing resources, use the PATCH operation. The operation is asynchronous and may take several minutes to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinks_Create")
  create is ArmResourceCreateOrReplaceAsync<PrivateLinkResource>;

  /**
   * Update specific properties of a private link resource. Use this operation to update mutable properties like tags without affecting the entire resource configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinks_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    PrivateLinkResource,
    PatchModel = PrivateLinkUpdate
  >;

  /**
   * Delete a private link resource. This operation will remove the private link infrastructure and disconnect all associated private endpoints. This operation is asynchronous and may take several minutes to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  @operationId("PrivateLinks_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateLinkResource,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists all the private links in the specified resource group. private links enable secure, private connectivity to Microsoft Defender for Cloud services without exposing traffic to the public internet. Use the 'nextLink' property in the response to get the next page of private links for the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinks_List")
  list is ArmResourceListByParent<
    PrivateLinkResource,
    Response = ArmResponse<PrivateLinksList>
  >;

  /**
   * Lists all the private links in the specified subscription. private links enable secure, private connectivity to Microsoft Defender for Cloud services without exposing traffic to the public internet. Use the 'nextLink' property in the response to get the next page of private links for the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinks_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    PrivateLinkResource,
    Response = ArmResponse<PrivateLinksList>
  >;
}

@@maxLength(PrivateLinkResource.name, 63);
@@minLength(PrivateLinkResource.name, 3);
@@doc(PrivateLinkResource.name,
  "The name of the private link resource. Must be unique within the resource group and follow Azure naming conventions."
);
@@doc(PrivateLinkResource.properties,
  "Properties specific to the private link resource"
);
@@doc(PrivateLinkResources.create::parameters.resource,
  "Private link request payload containing the resource information for create operations."
);
@@doc(PrivateLinkResources.update::parameters.properties,
  "private link update payload containing only the properties to be updated."
);
