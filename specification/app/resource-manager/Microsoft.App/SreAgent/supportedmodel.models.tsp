import "./supportedmodel.models.tsp";

namespace Microsoft.App;

/** Supported AI model properties */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource. No provisioning state provided."
model SupportedModelProperties {
  /** The provider name (e.g., MicrosoftFoundry, Anthropic) */
  provider?: string;

  /** The model name (e.g., gpt-5.2, claude-sonnet-4-5) */
  `model`?: string;

  /** Indicates whether this is the default model */
  default?: boolean;
}
