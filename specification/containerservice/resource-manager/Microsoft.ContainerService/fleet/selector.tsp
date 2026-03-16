import "@azure-tools/typespec-azure-core";
using TypeSpec.Versioning;

namespace Microsoft.ContainerService;

@doc("Select members of a fleet.")
@added(Versions.v2026_03_02_preview)
model MemberSelector {
  @doc("""
    Kubernetes-style label selector for selecting Fleet members, e.g. `env=production`.
    
    The following restrictions apply compared to standard Kubernetes syntax:
      * Only key/value pairs with the `=` operator are accepted.
      * Keys may not be repeated, that is `env=production,env=staging` is invalid.
    """)
  @maxLength(512)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  byLabel: string;
}
