// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DevHub;

/**
 * Generate preview dockerfile and manifests.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@summary("Generate preview dockerfile and manifests.")
@route("/subscriptions/{subscriptionId}/providers/microsoft.DevHub/locations/{location}/generatePreviewArtifacts")
@tag("Artifacts")
op generatePreviewArtifacts(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...LocationParameter,
  #suppress ""
  @body parameters: ArtifactGenerationProperties,
): ArmResponse<Record<string>> | ErrorResponse;
