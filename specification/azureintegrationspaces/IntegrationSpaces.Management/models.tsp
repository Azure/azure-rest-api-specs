namespace Microsoft.IntegrationSpaces;

@doc("The properties of application resource.")
model ApplicationResourceProperties {
  @doc("The provisioning state of the application resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  ...ApplicationResourcePatchProperties;
}

@doc("The properties of application resource in patch request.")
model ApplicationResourcePatchProperties {
  @doc("The type of the application resource.")
  resourceType: string;

  @doc("The Arm id of the application resource.")
  resourceId: string;

  @doc("The kind of the application resource.")
  resourceKind?: string;

  @doc("The alerts of the application resource.")
  alerts?: ApplicationResourceAlerts;
}

@doc("The alerts of the application resource.")
model ApplicationResourceAlerts {
  @doc("The application resource default action groups for alert types.")
  defaults?: AlertDefaults;

  @doc("The application resource alert rules.")
  @Azure.ResourceManager.identifiers(#["alertRuleId"])
  alertRules?: AlertRule[];
}

@doc("The default application groups for each alert type.")
model AlertDefaults {
  @doc("The verbose alert type.")
  verbose?: AlertTypeDefaults;

  @doc("The warning alert type.")
  warning?: AlertTypeDefaults;

  @doc("The informational alert type.")
  informational?: AlertTypeDefaults;

  @doc("The error alert type.")
  error?: AlertTypeDefaults;

  @doc("The critical alert type.")
  critical?: AlertTypeDefaults;
}

@doc("The defaults for alert type.")
model AlertTypeDefaults {
  @doc("The action groups.")
  actionGroups?: string[];
}

@doc("The alert rule.")
model AlertRule {
  @doc("The alert rule identifier.")
  alertRuleId?: string;
}

@doc("The properties of space.")
model SpaceResourceProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  ...SpaceResourcePatchProperties;
}

@doc("The properties of space in patch request.")
model SpaceResourcePatchProperties {
  @doc("The description of the resource.")
  description?: string;
}

@doc("The properties of infrastructure resource.")
model InfrastructureResourceProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  ...InfrastructureResourcePatchProperties;
}

@doc("The properties of infrastructure resource in patch request.")
model InfrastructureResourcePatchProperties {
  @doc("The type of the infrastructure resource.")
  resourceType: string;

  @doc("The id of the infrastructure resource.")
  resourceId: string;
}

@doc("The properties of application.")
model ApplicationProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  ...ApplicationPatchProperties;
}

@doc("The properties of application in patch request.")
model ApplicationPatchProperties {
  @doc("The description of the resource.")
  description?: string;
}
