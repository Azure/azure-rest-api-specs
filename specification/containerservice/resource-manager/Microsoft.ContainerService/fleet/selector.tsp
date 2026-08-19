import "@azure-tools/typespec-azure-core";
using TypeSpec.Versioning;

namespace Microsoft.ContainerService;

@doc("Select members of a fleet.")
@added(Versions.v2026_03_02_preview)
@removed(Versions.v2026_06_01)
model MemberSelector {
  @doc("Kubernetes-style label selector for selecting Fleet members, e.g. `env=production`.")
  @maxLength(512)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  byLabel: string;
}
