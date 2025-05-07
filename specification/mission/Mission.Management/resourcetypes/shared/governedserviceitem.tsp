import "@typespec/versioning";
using TypeSpec.Versioning;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@added(Microsoft.Mission.Versions.v2024_06_01_preview)
@doc("GovernedServiceItem Properties")
model GovernedServiceItem {
  @doc("service id")
  id: ServiceIdentifier;

  @doc("service name")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("governance option for this service (Allow, Deny, ExceptionOnly, or NotApplicable).")
  option?: "Allow" | "Deny" | "ExceptionOnly" | "NotApplicable" | string;

  @doc("initiative enforcement (Enabled or Disabled).")
  enforcement?: "Enabled" | "Disabled" | string;

  @doc("policies set to auditOnly (True or False).")
  auditOnly?: boolean;

  @doc("initiatives associated with this service")
  @visibility(Lifecycle.Read)
  initiatives?: string[];
}
