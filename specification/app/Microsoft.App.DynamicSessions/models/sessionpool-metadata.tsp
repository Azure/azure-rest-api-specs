import "./common.tsp";
using TypeSpec.Versioning;

namespace Microsoft.App.DynamicSessions;

@added(Versions.v2025_02_02_preview)
@doc("SessionPool Metadata.")
model SessionPoolMetadataResponse {
  @doc("List of runtimes.")
  runtimes: Runtime[];

  @doc("List of pre-installed packages.")
  preInstalledPackages: Package[];

  @doc("Creation date in RFC3339 format.")
  createdAt: utcDateTime;

  @doc("Last updated date in RFC3339 format.")
  lastUpdatedAt: utcDateTime;

  @doc("Jupyter kernel information.")
  jupyterKernel: JupyterKernel;
}

@added(Versions.v2025_02_02_preview)
@doc("Runtime information.")
model Runtime {
  @doc("Name of the runtime.")
  name: string;

  @doc("Version of the runtime.")
  version: string;
}

@added(Versions.v2025_02_02_preview)
@doc("Package information.")
model Package {
  @doc("Name of the package.")
  name: string;

  @doc("Version of the package.")
  version: string;
}

@added(Versions.v2025_02_02_preview)
@doc("Jupyter kernel information.")
model JupyterKernel {
  @doc("Name of the kernel.")
  name: string;

  @doc("Version of the kernel.")
  version: string;

  @doc("Project URL of the kernel.")
  projectUrl: url;

  @doc("Description of the kernel.")
  description: string;
}
