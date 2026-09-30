namespace Microsoft.App;

/** Supported AI model properties */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource. No provisioning state provided."
model SupportedAgentModelProperties {
  /** The provider name (e.g., MicrosoftFoundry, Anthropic) */
  @TypeSpec.Versioning.renamedFrom(Versions.v2026_07_01, "provider")
  providerName: string;

  /** The display name of the provider (e.g., Microsoft Foundry, Anthropic) */
  providerDisplayName?: string;

  /** The model name (e.g., gpt-5.2, claude-sonnet-4-5) */
  @TypeSpec.Versioning.renamedFrom(Versions.v2026_07_01, "model")
  modelName: string;

  /** The display name of the model (e.g., GPT-5.2, Claude Sonnet 4.5) */
  modelDisplayName?: string;

  /** Billing multiplier for the model (e.g., 1x, 2x) */
  multiplier?: string;

  /** Indicates whether this is the default model */
  default: boolean;
}
