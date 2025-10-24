import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Pipeline.tsp";
import "./models.flowprofile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

@versioned(Versions)
namespace Microsoft.AzureDataTransfer;

/**
 * Represents a FlowProfile Azure resource, which defines a data replication scenario with a specific data classification and a set of configurable policy rules.
 */
@added(Versions.v2025_05_30_preview)
@parentResource(Pipeline)
model FlowProfile
  is Azure.ResourceManager.TrackedResource<FlowProfileProperties> {
  ...ResourceNameParameter<
    Resource = FlowProfile,
    KeyName = "flowProfileName",
    SegmentName = "flowProfiles",
    NamePattern = "^[a-zA-Z0-9-]{3,64}$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

/**
 * Defines the set of operations available for managing FlowProfile resources.
 */
@added(Versions.v2025_05_30_preview)
@armResourceOperations
interface FlowProfiles {
  /**
   * Retrieves the specified FlowProfile resource.
   */
  get is ArmResourceRead<FlowProfile>;

  /**
   * Creates a new FlowProfile or updates an existing one.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FlowProfile>;

  /**
   * Applies partial updates to an existing FlowProfile resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<FlowProfile, PatchModel = FlowProfilePatch>;

  /**
   * Deletes the specified FlowProfile resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<FlowProfile>;

  /**
   * Lists all FlowProfiles under a given Pipeline.
   */
  listByPipeline is ArmResourceListByParent<FlowProfile>;
}

@@maxLength(FlowProfile.name, 64);
@@minLength(FlowProfile.name, 3);
@@doc(FlowProfile.name,
  "The name of the FlowProfile resource to operate on. Must be 3 to 64 characters long and contain only alphanumeric characters or hyphens."
);
@@doc(FlowProfile.properties,
  "The set of configuration properties that define the behavior and rules of the FlowProfile."
);
@@doc(FlowProfiles.createOrUpdate::parameters.resource,
  "The FlowProfile resource definition to create or update."
);
@@doc(FlowProfiles.update::parameters.properties,
  "The FlowProfile patch definition containing the properties to update."
);
