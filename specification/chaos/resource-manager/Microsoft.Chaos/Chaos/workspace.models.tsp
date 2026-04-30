import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "./common.models.tsp";

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
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Workspace.properties,
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
   * The intended workspace-level resource scope to be used by child scenarios.
   */
  scopes: Azure.Core.armResourceIdentifier[];
}

/**
 * Describes a workspace update.
 */
model WorkspaceUpdate {
  ...Azure.ResourceManager.Foundations.TagsUpdateModel<Workspace>;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}
