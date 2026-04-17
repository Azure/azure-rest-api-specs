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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
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
  @summary("Display information about a specified ContainerGroupProfile.")
  get is ArmResourceRead<ContainerGroupProfile, Error = CloudError>;

  /**
   * Create a CGProfile if it doesn't exist or update an existing CGProfile.
   */
  @summary("Create or Update a ContainerGroupProfile")
  createOrUpdate is ContainerGroupProfileOps.CreateOrUpdateSync<
    ContainerGroupProfile,
    Response = (ArmResourceUpdatedResponse<ContainerGroupProfile> & {
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      @header("x-ms-correlation-request-id")
      `x-ms-correlation-request-id`: string;
    }) | (ArmResourceCreatedSyncResponse<ContainerGroupProfile> & {
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      @header("x-ms-correlation-request-id")
      `x-ms-correlation-request-id`: string;
    })
  >;

  /**
   * Update a specified container group profile.
   */
  @summary("Container group profile PATCH REST API.")
  @patch(#{ implicitOptionality: false })
  update is ContainerGroupProfileOps.CustomPatchSync<
    ContainerGroupProfile,
    PatchModel = ContainerGroupProfilePatch,
    Response = ArmResponse<ContainerGroupProfile> & {
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      @header("x-ms-correlation-request-id")
      `x-ms-correlation-request-id`: string;
    }
  >;

  /**
   * Deletes a container group profile.
   */
  @summary("Container group profile DELETE REST API.")
  delete is ContainerGroupProfileOps.DeleteSync<ContainerGroupProfile>;

  /**
   * Gets a list of all container group profiles under a subscription.
   */
  @summary("List container group profiles in a subscription.")
  listBySubscription is ArmListBySubscription<
    ContainerGroupProfile,
    Error = CloudError
  >;

  /**
   * Gets a list of all container group profiles under a resource group.
   */
  @summary("List container group profiles in a resource group.")
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
  CloudError,
  "ContainerGroupProfileRevision"
>;

#suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
@armResourceOperations(#{ omitTags: true })
interface CGProfile {
  /**
   * Gets the properties of the specified revision of the container group profile in the given subscription and resource group. The operation returns the properties of container group profile including containers, image registry credentials, restart policy, IP address type, OS type, volumes, current revision number, etc.
   */
  @summary("Get the properties of the specified revision of the container group profile.")
  getByRevisionNumber is CGProfileOps.Read<ContainerGroupProfile>;

  /**
   * Get a list of all the revisions of the specified container group profile in the given subscription and resource group. This operation returns properties of each revision of the specified container group profile including containers, image registry credentials, restart policy, IP address type, OS type volumes, revision number, etc.
   */
  @summary("Get a list of all the revisions of the specified container group profile in the given subscription and resource group.")
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
