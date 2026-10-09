import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "./common.models.tsp";
import "./workspaceEncryption.models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Microsoft.Chaos;
/**
 * Model that represents a Workspace resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required implementation to avoid breaking .NET SDK changes"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Required implementation to avoid breaking .NET SDK changes"
@Azure.ResourceManager.Private.armResourceInternal(WorkspaceProperties)
@Http.Private.includeInapplicableMetadataInPayload(false)
model Workspace extends Azure.ResourceManager.Foundations.TrackedResource {
  ...ResourceNameParameter<
    Resource = Workspace,
    KeyName = "workspaceName",
    SegmentName = "workspaces",
    NamePattern = "^[^<>%&:?#/\\\\]+$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Required implementation to avoid breaking .NET SDK changes"
  @doc("The resource-specific properties for this resource.")
  @Azure.ResourceManager.Private.armResourcePropertiesOptionality(false)
  properties?: WorkspaceProperties;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility with arm-resource-flattening configuration"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  Workspace.properties,
  "autorest"
);

/**
 * Model that represents a list of Workspace resources and a link for pagination.
 */
model WorkspaceListResult is Azure.Core.Page<Workspace>;

/**
 * Model that represents the Workspace properties model.
 */
model WorkspaceProperties {
  /**
   * Most recent provisioning state for the given Workspace resource.
   */
  @visibility(Lifecycle.Read)
  @lroStatus
  provisioningState?: ProvisioningState;

  /**
   * The communication endpoint used to connect and communicate with the workspace for fault-injection orchestration.
   */
  @visibility(Lifecycle.Read)
  communicationEndpoint?: string;

  /**
   * The intended workspace-level resource scope to be used by child scenarios.
   */
  scopes: Azure.Core.armResourceIdentifier[];

  /**
   * The requested customer key and service observations. Accepted creation fixes
   * whether customerManagedKeyEncryption is present. On PUT, omission of
   * encryption or its CMK object, or an empty encryption object, is valid for
   * Microsoft-managed Workspaces but rejected for CMK-created Workspaces.
   * Null is not a valid PUT value. A CMK-created Workspace can replace its key.
   */
  @added(Versions.v2026_11_01)
  encryption?: WorkspaceEncryption;
}

/**
 * Describes a workspace update.
 */
model WorkspaceUpdate {
  ...Azure.ResourceManager.Foundations.TagsUpdateModel<Workspace>;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  /** The resource-specific fields to update. Omitted fields are unchanged. */
  @added(Versions.v2026_11_01)
  properties?: WorkspaceUpdateProperties;
}

/** The Workspace properties supported by partial updates. */
@added(Versions.v2026_11_01)
model WorkspaceUpdateProperties {
  ...TypeSpec.Http.MergePatchUpdate<WorkspaceEncryptionPatchProperties>;
}

/** The writable encryption field used to construct a JSON Merge Patch. */
@added(Versions.v2026_11_01)
model WorkspaceEncryptionPatchProperties {
  /**
   * A JSON Merge Patch of the requested encryption setting. Omission leaves the
   * setting unchanged. Null deletion is rejected on a CMK-created Workspace
   * and is a no-op only when the setting is already absent on a Microsoft-managed
   * Workspace. The service validates the creation choice and merged pair first.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Explicit null is required so JSON Merge Patch can delete encryption. This request-only transform does not change PUT or response nullability."
  encryption?: WorkspaceEncryptionPatch;
}
