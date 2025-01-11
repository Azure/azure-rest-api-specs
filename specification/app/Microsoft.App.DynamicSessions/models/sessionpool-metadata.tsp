import "./common.tsp";
using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.App.DynamicSessions;

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

@doc("Runtime information.")
model Runtime {
  @doc("Name of the runtime.")
  name: string;

  @doc("Version of the runtime.")
  version: string;
}

@doc("Package information.")
model Package {
  @doc("Name of the package.")
  name: string;

  @doc("Version of the package.")
  version: string;
}

@doc("Jupyter kernel information.")
model JupyterKernel {
  @doc("Name of the kernel.")
  name: string;

  @doc("Version of the kernel.")
  version: string;

  @doc("Project URL of the kernel.")
  projectUrl: string;

  @doc("Description of the kernel.")
  description: string;
}
