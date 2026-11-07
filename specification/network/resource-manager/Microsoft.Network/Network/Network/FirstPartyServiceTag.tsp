import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./shared-models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Microsoft.Network;

/**
 * First party service tag resource.
 */
@added(Versions.v2025_09_01)
@featureFile(Features.firstPartyServiceTag)
model FirstPartyServiceTag
  is ResourceInstance<FirstPartyServiceTagPropertiesFormat> {
  /**
   * The unique identifier of the resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The name of the first party service tag.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("firstPartyServiceTagName")
  @segment("firstPartyServiceTags")
  @maxLength(80)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]{0,79}$")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Etag is a standard read-only envelope property across all Network resources for backward compatibility"
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Properties of the first party service tag.
 */
@added(Versions.v2025_09_01)
@featureFile(Features.firstPartyServiceTag)
model FirstPartyServiceTagPropertiesFormat {
  /**
   * The value of the first party service tag.
   */
  value: string;

  /**
   * The reason for failure, if any.
   */
  @visibility(Lifecycle.Read)
  failedReason?: string;

  /**
   * The resource GUID property of the first party service tag resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;

  /**
   * The provisioning state of the first party service tag resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2025_09_01)
@featureFile(Features.firstPartyServiceTag)
@armResourceOperations
interface FirstPartyServiceTags {
  /**
   * Gets the specified first party service tag.
   */
  get is ArmResourceRead<FirstPartyServiceTag, Error = CloudError>;

  /**
   * Creates or updates a first party service tag.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FirstPartyServiceTag,
    Error = CloudError
  >;

  /**
   * Updates a first party service tag tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchAsync<
    FirstPartyServiceTag,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified first party service tag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Matching existing Network resource pattern (VirtualNetwork, LoadBalancer, etc.) that supports both sync (200) and async (202) delete"
  delete is ArmResourceDeleteWithoutOkAsync<
    FirstPartyServiceTag,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all the first party service tags in a resource group.
   */
  list is ArmResourceListByParent<FirstPartyServiceTag, Error = CloudError>;

  /**
   * Gets all the first party service tags in a subscription.
   */
  listAll is ArmListBySubscription<FirstPartyServiceTag, Error = CloudError>;
}

@@doc(FirstPartyServiceTag.name, "The name of the first party service tag.");
@@doc(
  FirstPartyServiceTag.properties,
  "Properties of the first party service tag."
);
@@doc(
  FirstPartyServiceTags.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update first party service tag operation."
);
@@doc(
  FirstPartyServiceTags.updateTags::parameters.properties,
  "Parameters supplied to update first party service tag tags."
);
@@clientName(
  FirstPartyServiceTags.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(
  FirstPartyServiceTags.updateTags::parameters.properties,
  "parameters"
);
