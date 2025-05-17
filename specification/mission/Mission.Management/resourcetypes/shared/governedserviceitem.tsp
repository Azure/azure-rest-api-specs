@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("GovernedServiceItem Properties")
model GovernedServiceItem {
  @doc("Service ID")
  id: ServiceIdentifier;

  @doc("Service name")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Governance option for this service (Allow, Deny, ExceptionOnly, or NotApplicable).")
  option?: "Allow" | "Deny" | "ExceptionOnly" | "NotApplicable" | string;

  @doc("Initiative enforcement (Enabled or Disabled).")
  enforcement?: "Enabled" | "Disabled" | string;

  @doc("Policies set to auditOnly (True or False).")
  auditOnly?: boolean;

  @doc("Initiatives associated with this service")
  @visibility(Lifecycle.Read)
  initiatives?: string[];
}
