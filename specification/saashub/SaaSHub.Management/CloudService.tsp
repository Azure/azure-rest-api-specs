import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./CloudServiceModels.tsp";
import "./SharedModels.tsp";
import "./versions.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.SaaSHub;
/**
 * A SaaSHub cloud service.
 */
model CloudService
  is Azure.ResourceManager.TrackedResource<CloudServiceProperties> {
  ...ResourceNameParameter<
    Resource = CloudService,
    KeyName = "cloudServiceResourceName",
    SegmentName = "cloudServices",
    NamePattern = "^[-_0-9a-zA-Z]{3,50}$"
  >;
}

@armResourceOperations
interface CloudServices {
  /**
   * Gets a SaaSHub cloud service by its ID. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
  get is ArmResourceRead<CloudService>;

  /**
   * Creates or updates a SaaSHub cloud service.
   */
  create is ArmResourceCreateOrReplaceAsync<CloudService>;

  /**
   * Updates the properties of a SaaSHub cloud service.
   */
  update is ArmCustomPatchAsync<CloudService, CloudServiceUpdate>;

  /**
   * Deletes a SaaSHub cloud service.
   */
  delete is ArmResourceDeleteWithoutOkAsync<CloudService>;

  /**
   * Lists the SaaSHub cloud services under the subscription.
   */
  listBySubscription is ArmListBySubscription<CloudService>;

  /**
   * Lists the SaaSHub cloud services under the resource group.
   */
  listByResourceGroup is ArmResourceListByParent<CloudService>;

  /**
   * Evaluates whether an existing cloud service can be cancelled.
   */
  canCancel is ArmResourceActionSync<CloudService, void, CanCancelResult>;

  /**
   * Evaluates whether the source cloud service can be merged to target cloud service.
   */
  canMerge is ArmResourceActionSync<
    CloudService,
    MergeCloudServiceRequest,
    CloudServiceCanMergeResult
  >;

  /**
   * Evaluates whether the request payload can update an existing cloud service.
   */
  canUpdate is ArmResourceActionSync<
    CloudService,
    CloudServiceUpdate,
    CanUpdateResult
  >;

  /**
   * Cancels a SaaSHub cloud service.
   */
  cancel is ArmResourceActionAsync<CloudService, void, CloudService>;

  /**
   * Merges multiple cloud services into one target cloud service. The resource name in URL is the target, and the list of source cloud service and quantity will be specified in request payload
   */
  merge is ArmResourceActionAsync<
    CloudService,
    MergeCloudServiceRequest,
    CloudService
  >;

  /**
   * Gets the refundable quantity for a SaaSHub cloud service.
   * Only available in API version 2025-07-01-preview.
   */
  refundableQuantity is ArmResourceActionSync<
    CloudService,
    void,
    GetRefundableQuantityResponse
  >;
}

@@maxLength(CloudService.name, 50);
@@minLength(CloudService.name, 3);
@@doc(CloudService.name,
  "The name that uniquely identifies a SaaSHub cloud service."
);
@@doc(CloudService.properties, "The properties of a SaaSHub cloud service.");
@@doc(CloudServices.create::parameters.resource,
  "Request parameters that are provided to the create SaaSHub cloud service operation."
);
@@doc(CloudServices.update::parameters.properties,
  "Request parameters that are provided to the update SaaSHub cloud service operation."
);
@@doc(CloudServices.canMerge::parameters.body,
  "Request parameters that are provided to the merge SaaSHub cloud service operation."
);
@@doc(CloudServices.canUpdate::parameters.body,
  "Request parameters that are provided to the update SaaSHub cloud service operation."
);
@@doc(CloudServices.merge::parameters.body,
  "Request parameters that are provided to the merge SaaSHub cloud service operation."
);
@@doc(CloudServices.refundableQuantity,
  "Gets the refundable quantity for a SaaSHub cloud service."
);
