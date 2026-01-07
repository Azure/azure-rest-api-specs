import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.PortalServices;

interface Operations extends Azure.ResourceManager.Operations {}

/** Available values for the Multi-factor authentication enforcement behavior. */
union MfaEnforcement {
  string,

  /** Use the default Multi-factor authentication enforcement behavior. */
  "Default",

  /** This tenant is opted out of Multi-factor authentication enforcement. */
  "OptOut",

  /** Multi-factor authentication is required. */
  "Enforce",
}

/** The state of the Agent Mode registration for the tenant. */
union AgentModeRegisterState {
  string,

  /** This tenant is unregistered for Agent Mode. */
  "Unregistered",

  /** This tenant is registered for Agent Mode. */
  "Registered",
}

/** The state of the Agent Mode feature for the tenant. */
union AgentModeState {
  string,

  /** Agent Mode is disabled for this tenant. */
  "Disabled",

  /** Agent Mode is enabled for this tenant. */
  "Enabled",
}

/** The agent mode configuration properties. */
model AgentModeProperties {
  /** The state of the Agent Mode registration for the tenant. */
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  registration: AgentModeRegisterState;

  /** The state of the Agent Mode feature for the tenant. */
  @visibility(Lifecycle.Read)
  state?: AgentModeState;
}

/** The Copilot Settings properties. */
model CopilotSettingsProperties {
  /** Boolean indicating if role-based access control is enabled for copilot in this tenant. */
  accessControlEnabled: boolean;

  /** The agent mode configuration properties. */
  @added(Versions.v2025_09_10_preview)
  agentMode?: AgentModeProperties;

  /** The setting for Bring Your Own Storage (BYOS) for copilot in this tenant. If set, copilot will use specified cosmos DB account for storing copilot chat data. */
  @added(Versions.v2025_08_01_preview)
  cosmosResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.DocumentDB/databaseAccounts";
    }
  ]>;

  /** The setting for Multi-Factor Authentication enforcement when signing into this tenant in the Azure Portal. */
  @added(Versions.v2024_08_01_preview)
  @removed(Versions.v2024_09_01_preview)
  portalMfaEnforcement?: MfaEnforcement;

  /** Justification for the value set for portalMfaEnforcement. Required when portalMfaEnforcement is set to a value other than 'Default'. Maximum length is 500 characters. */
  @added(Versions.v2024_08_01_preview)
  @removed(Versions.v2024_09_01_preview)
  portalMfaEnforcementJustification?: string;

  /** The status of the last provisioning operation performed on the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}
