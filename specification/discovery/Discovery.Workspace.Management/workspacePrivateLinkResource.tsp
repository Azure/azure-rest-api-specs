import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./workspace.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Discovery;

/**
 * A private link resource for Workspace.
 */
@added(Versions.v2026_02_01_preview)
@parentResource(Workspace)
model WorkspacePrivateLinkResource
  is Azure.ResourceManager.ProxyResource<Azure.ResourceManager.CommonTypes.PrivateLinkResourceProperties> {
  ...PrivateLinkResourceParameter;
}

@added(Versions.v2026_02_01_preview)
@armResourceOperations
interface WorkspacePrivateLinkResources {
  /**
   * Gets the specified private link resource for the workspace.
   */
  get is ArmResourceRead<WorkspacePrivateLinkResource>;

  /**
   * Lists all private link resources for the workspace.
   */
  listByWorkspace is ArmResourceListByParent<WorkspacePrivateLinkResource>;
}

@@pattern(PrivateLinkResourceParameter.name, "^[a-z][a-zA-Z0-9]*");
@@minLength(PrivateLinkResourceParameter.name, 3);
@@maxLength(PrivateLinkResourceParameter.name, 63);
