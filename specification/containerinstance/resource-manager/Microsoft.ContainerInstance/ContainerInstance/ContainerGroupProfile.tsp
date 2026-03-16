import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerInstance;
/**
 * A container group profile object
 */
model ContainerGroupProfile
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ContainerGroupProfileProperties> {
  ...ResourceNameParameter<
    Resource = ContainerGroupProfile,
    KeyName = "containerGroupProfileName",
    SegmentName = "containerGroupProfiles",
    NamePattern = "^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$"
  >;
  ...Azure.ResourceManager.AvailabilityZonesProperty;
}

alias ContainerGroupProfileOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;
  },
  {
    /** ContainerGroupProfile name. */
    @path
    @segment("containerGroupProfiles")
    @key
    @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
    @minLength(1)
    @maxLength(63)
    containerGroupProfileName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface ContainerGroupProfiles {
  /**
   * Get the properties of the specified container group profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Display information about a specified ContainerGroupProfile.")
  @operationId("CGProfile_Get")
  get is ArmResourceRead<ContainerGroupProfile, Error = CloudError>;

  /**
   * Create a CGProfile if it doesn't exist or update an existing CGProfile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Create or Update a ContainerGroupProfile")
  @operationId("CGProfile_CreateOrUpdate")
  createOrUpdate is ContainerGroupProfileOps.CreateOrUpdateSync<
    ContainerGroupProfile,
    Response = (ArmResourceUpdatedResponse<ContainerGroupProfile> & {
      @header("x-ms-correlation-request-id")
      `x-ms-correlation-request-id`: string;
    }) | (ArmResourceCreatedSyncResponse<ContainerGroupProfile> & {
      @header("x-ms-correlation-request-id")
      `x-ms-correlation-request-id`: string;
    })
  >;

  /**
   * Update a specified container group profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Container group profile PATCH REST API.")
  @operationId("CGProfile_Update")
  @patch(#{ implicitOptionality: false })
  update is ContainerGroupProfileOps.CustomPatchSync<
    ContainerGroupProfile,
    PatchModel = ContainerGroupProfilePatch,
    Response = ArmResponse<ContainerGroupProfile> & {
      @header("x-ms-correlation-request-id")
      `x-ms-correlation-request-id`: string;
    }
  >;

  /**
   * Deletes a container group profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Container group profile DELETE REST API.")
  @operationId("CGProfile_Delete")
  delete is ContainerGroupProfileOps.DeleteSync<ContainerGroupProfile>;

  /**
   * Gets a list of all container group profiles under a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List container group profiles in a subscription.")
  @operationId("CGProfiles_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    ContainerGroupProfile,
    Error = CloudError
  >;

  /**
   * Gets a list of all container group profiles under a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List container group profiles in a resource group.")
  @operationId("CGProfiles_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    ContainerGroupProfile,
    Error = CloudError
  >;
}
alias CGProfileOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** ContainerGroupProfile name. */
    @path
    @segment("containerGroupProfiles")
    @key
    @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
    @minLength(1)
    @maxLength(63)
    containerGroupProfileName: string;
  },
  {
    /** The revision number of the container group profile. */
    @path
    @segment("revisions")
    @key
    revisionNumber: string;
  },
  CloudError
>;

@armResourceOperations(#{ omitTags: true })
interface CGProfile {
  /**
   * Gets the properties of the specified revision of the container group profile in the given subscription and resource group. The operation returns the properties of container group profile including containers, image registry credentials, restart policy, IP address type, OS type, volumes, current revision number, etc.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get the properties of the specified revision of the container group profile.")
  @operationId("CGProfile_GetByRevisionNumber")
  getByRevisionNumber is CGProfileOps.Read<ContainerGroupProfile>;

  /**
   * Get a list of all the revisions of the specified container group profile in the given subscription and resource group. This operation returns properties of each revision of the specified container group profile including containers, image registry credentials, restart policy, IP address type, OS type volumes, revision number, etc.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get a list of all the revisions of the specified container group profile in the given subscription and resource group.")
  @operationId("CGProfile_ListAllRevisions")
  listAllRevisions is CGProfileOps.List<ContainerGroupProfile>;
}

@@maxLength(ContainerGroupProfile.name, 63);
@@minLength(ContainerGroupProfile.name, 1);
@@doc(ContainerGroupProfile.name, "ContainerGroupProfile name.");
@@doc(ContainerGroupProfile.properties,
  "The container group profile properties"
);
@@doc(ContainerGroupProfiles.createOrUpdate::parameters.resource,
  "The ContainerGroupProfile object."
);
@@doc(ContainerGroupProfiles.update::parameters.properties,
  "The container group profile properties that need to be updated."
);
