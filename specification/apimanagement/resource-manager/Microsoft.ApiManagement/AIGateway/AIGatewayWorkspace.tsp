import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Microsoft.ApiManagement;

/** Properties of an AI Gateway workspace. */
@added(Versions.v2026_09_01_preview)
model AiGatewayWorkspaceProperties {
  /** Display name of the workspace. */
  @encodedName("application/json", "name")
  displayName: string;

  /** Description of the workspace. */
  description: string;

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;
}

/** Properties for updating an AI Gateway workspace. */
@added(Versions.v2026_09_01_preview)
model AiGatewayWorkspaceUpdateProperties {
  /** Display name of the workspace. */
  @encodedName("application/json", "name")
  displayName?: string;

  /** Description of the workspace. */
  description?: string;
}

/** Parameters for updating an AI Gateway workspace. */
@added(Versions.v2026_09_01_preview)
model AiGatewayWorkspaceUpdateParameters {
  /** Workspace properties to update. */
  properties?: AiGatewayWorkspaceUpdateProperties;
}

/** An AI Gateway workspace resource. */
@added(Versions.v2026_09_01_preview)
@parentResource(AiGatewayResource)
model AiGatewayWorkspaceResource
  is Azure.ResourceManager.ProxyResource<AiGatewayWorkspaceProperties> {
  ...ResourceNameParameter<
    Resource = AiGatewayWorkspaceResource,
    KeyName = "workspaceName",
    SegmentName = "workspaces",
    NamePattern = "^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}
