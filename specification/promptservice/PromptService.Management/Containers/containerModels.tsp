import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.PromptService;

/** Details of a container within a Prompt Service Account. */
model ContainerProperties {
  /** Container description. */
  @maxLength(250)
  description?: string;

  /** The model name associated with this container (e.g., gpt-4, claude-3). */
  modelName?: string;

  /** The AI provider associated with this container (e.g., OpenAI, Anthropic). */
  provider?: string = "OpenAI";

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
