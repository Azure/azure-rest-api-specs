import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.ApiManagement;

/** Properties of an AI Gateway workspace. */
@added(Versions.v2026_11_01)
model AiGatewayWorkspaceProperties {
  /** Display name of the workspace. */
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "name")
  displayName: string;

  /** Description of the workspace. */
  @visibility(Lifecycle.Read)
  description: string;

  /** Inline governance policies for the default workspace. */
  @identifiers(#[])
  policies?: AiGatewayPolicy[];

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;
}

/** Properties for updating an AI Gateway workspace. */
@added(Versions.v2026_11_01)
model AiGatewayWorkspaceUpdateProperties {
  /** Inline governance policies to replace on the default workspace. */
  @identifiers(#[])
  policies?: AiGatewayPolicyUpdate[];
}

/** Parameters for updating an AI Gateway workspace. */
@added(Versions.v2026_11_01)
model AiGatewayWorkspaceUpdateParameters {
  /** Workspace properties to update. */
  properties?: AiGatewayWorkspaceUpdateProperties;
}

/** An AI Gateway workspace resource. */
@added(Versions.v2026_11_01)
@parentResource(AiGatewayResource)
model AiGatewayWorkspaceResource
  is Azure.ResourceManager.ProxyResource<AiGatewayWorkspaceProperties> {
  ...ResourceNameParameter<
    Resource = AiGatewayWorkspaceResource,
    KeyName = "workspaceName",
    SegmentName = "workspaces",
    NamePattern = "^default$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}
