import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "./systemdata.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Playwright;

@doc("A saved browser proxy configuration scoped to a Playwright workspace.")
@added(Versions.v2026_11_01_preview)
@resource("proxy-configs")
@parentResource(Workspace)
model ProxyConfig {
  @doc("The proxy configuration ID in GUID format.")
  @key("proxyConfigId")
  @minLength(3)
  @maxLength(36)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  @visibility(Lifecycle.Read)
  id: string;

  // Standard Azure Resource Name parameter regex pattern - https://azure.github.io/typespec-azure/docs/libraries/azure-resource-manager/reference/data-types/#Azure.ResourceManager.ResourceNameParameter
  @minLength(3)
  @maxLength(24)
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @doc("The proxy configuration name.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  name: string;

  @doc("The configuration description. Set this to null to delete the existing value.")
  @maxLength(200)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  description?: string;

  @doc("The named proxy endpoints. At most 5 distinct proxy endpoints are allowed excluding the required 'default-proxy'. Set a 'proxy-endpoint-name':null to delete the existing record.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  proxyPool: Record<ProxyEndpoint>;

  @doc("The proxy selection mode, fixed for each session. Enabled selects proxy endpoint randomly per hostname pattern; Disabled selects the lowest numeric priority.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  rotation?: EnablementStatus = EnablementStatus.Disabled;

  @doc("The hostname patterns that bypass the proxy and goes through internet directly. Set this to null to delete the existing value.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @maxItems(50)
  bypass?: string[];

  @doc("The read-only creation and modification metadata.")
  @visibility(Lifecycle.Read)
  systemData: SystemData;
}

@doc("A named endpoint in a browser proxy pool. Required 'default-proxy' named proxy endpoint without pattern and priority specified for requests that doesn't match any pattern in the given proxy endpoints.")
@added(Versions.v2026_11_01_preview)
model ProxyEndpoint {
  @doc("The proxy origin URL using http, https, or socks4. Embedded credentials and private, loopback, or link-local IP literals are not allowed.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  server: url;

  @doc("The hostname patterns routed through this proxy endpoint.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minItems(1)
  @maxItems(40)
  pattern?: string[];

  @doc("The routing priority. Lower values take precedence.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minValue(1)
  @maxValue(100)
  priority?: int32;

  @doc("The proxy endpoint credentials. Set this to null to delete the existing value.")
  @visibility(Lifecycle.Create, Lifecycle.Update)
  credentials?: ProxyCredentials;
}

@doc("The proxy endpoint credentials.")
@added(Versions.v2026_11_01_preview)
model ProxyCredentials {
  @doc("The proxy authentication username.")
  @visibility(Lifecycle.Create, Lifecycle.Update)
  username: string;

  @doc("The secret URI of the proxy password in the playwright workspace's linked Azure Key Vault.")
  @visibility(Lifecycle.Create, Lifecycle.Update)
  secretUri: url;
}

// Operations ////////////////////

@doc("Operations for saved browser proxy configurations. Requires Microsoft Entra authentication and Playwright workspace access.")
@added(Versions.v2026_11_01_preview)
interface ProxyConfigs {
  // ProxyConfig Operations
  @doc("Creates or replaces a proxy configuration and returns it without credentials.")
  createOrReplace is Operations.ResourceCreateOrReplace<ProxyConfig>;

  @doc("Updates an existing proxy configuration and returns it without credentials.")
  update is Operations.ResourceUpdate<ProxyConfig>;

  @doc("Gets a saved proxy configuration without credentials.")
  get is Operations.ResourceRead<ProxyConfig>;

  @doc("Deletes a proxy configuration.")
  delete is Operations.ResourceDelete<ProxyConfig>;

  @doc("Lists saved proxy configurations without credentials. Supports query parameters like top, skip, and filter. Default page size is 10. Use nextLink in response to fetch additional results.")
  list is Operations.ResourceList<ProxyConfig>;
}
