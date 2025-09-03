import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./SaasResourceModels.tsp";
import "./SharedModels.tsp";

using Azure.ResourceManager;

namespace Microsoft.SaaSHub;
/**
 * A SaaSHub Saas resource.
 */
model SaasResource
  is Azure.ResourceManager.ProxyResource<Microsoft.SaaSHub.SaasResourceProperties> {
  ...ResourceNameParameter<
    Resource = SaasResource,
    KeyName = "saasResourceName",
    SegmentName = "saasResources",
    NamePattern = "^[-_0-9a-zA-Z]{3,50}$"
  >;
}

@armResourceOperations
interface SaasResources {
  /**
   * Gets a SaaSHub Saas resource by its ID. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
  get is ArmResourceRead<SaasResource, BaseParameters = ApiVersionParameter>;

  /**
   * Creates or updates a SaaSHub Saas resource.
   */
  create is ArmResourceCreateOrReplaceAsync<
    SaasResource,
    BaseParameters = ApiVersionParameter
  >;

  /**
   * Updates the properties of a SaaSHub Saas resource.
   */
  update is ArmCustomPatchAsync<
    SaasResource,
    SaasResource,
    BaseParameters = ApiVersionParameter
  >;

  /**
   * Deletes a SaaSHub Saas resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    SaasResource,
    BaseParameters = ApiVersionParameter
  >;

  /**
   * Lists the SaaSHub Saas resource under the tenant.
   */
  listByTenant is ArmResourceListByParent<
    SaasResource,
    BaseParameters = ApiVersionParameter
  >;

  /**
   * Evaluates whether an existing Saas resource can be cancelled.
   */
  canCancel is ArmResourceActionSync<
    SaasResource,
    void,
    Microsoft.SaaSHub.CanCancelResult,
    BaseParameters = ApiVersionParameter
  >;

  /**
   * Evaluates whether the source Saas resource can be merged to target Saas resource.
   */
  canMerge is ArmResourceActionSync<
    SaasResource,
    Microsoft.SaaSHub.MergeSaasResourcesRequest,
    Microsoft.SaaSHub.CanMergeResult,
    BaseParameters = ApiVersionParameter
  >;

  /**
   * Evaluates whether the request payload can update an existing Saas resource.
   */
  canUpdate is ArmResourceActionSync<
    SaasResource,
    SaasResource,
    Microsoft.SaaSHub.CanUpdateResult,
    BaseParameters = ApiVersionParameter
  >;

  /**
   * Cancels a SaaSHub Saas resource.
   */
  cancel is ArmResourceActionAsync<
    SaasResource,
    void,
    SaasResource,
    BaseParameters = ApiVersionParameter
  >;

  /**
   * Merges multiple Saas resources into one target Saas resource. The resource name in URL is the target, and the list of source Saas resource and quantity will be specified in request payload
   */
  merge is ArmResourceActionAsync<
    SaasResource,
    Microsoft.SaaSHub.MergeSaasResourcesRequest,
    SaasResource,
    BaseParameters = ApiVersionParameter
  >;

  /**
   * Gets the refundable quantity for a SaaSHub Saas resource.
   * Only available in API version 2025-07-01-preview.
   */
  refundableQuantity is ArmResourceActionSync<
    SaasResource,
    void,
    Microsoft.SaaSHub.GetRefundableQuantityResponse,
    BaseParameters = ApiVersionParameter
  >;
}

@@maxLength(SaasResource.name, 50);
@@minLength(SaasResource.name, 3);
@@doc(SaasResource.name,
  "The name that uniquely identifies a SaaSHub Saas resource."
);
@@doc(SaasResource.properties, "The properties of a SaaSHub Saas resource.");
@@doc(SaasResources.create::parameters.resource,
  "Request parameters that are provided to the create SaaSHub Saas resource operation."
);
@@doc(SaasResources.update::parameters.properties,
  "Request parameters that are provided to the update SaaSHub Saas resource operation."
);
@@doc(SaasResources.canMerge::parameters.body,
  "Request parameters that are provided to the merge SaaSHub Saas resource operation."
);
@@doc(SaasResources.canUpdate::parameters.body,
  "Request parameters that are provided to the update SaaSHub Saas resource operation."
);
@@doc(SaasResources.merge::parameters.body,
  "Request parameters that are provided to the merge SaaSHub Saas resource operation."
);
@@doc(SaasResources.refundableQuantity,
  "Gets the refundable quantity for a SaaSHub Saas resource."
);
