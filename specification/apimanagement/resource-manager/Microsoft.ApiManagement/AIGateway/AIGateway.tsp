import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Microsoft.ApiManagement;

/** Properties of an AI Gateway. */
#suppress "@azure-tools/typespec-azure-resource-manager/empty-updateable-properties" "The AI Gateway resource supports updating ARM tags; its RP-specific properties are read-only."
@added(Versions.v2026_09_01_preview)
model AiGatewayProperties {
  /** Runtime hostname used to invoke this AI Gateway. */
  @visibility(Lifecycle.Read)
  runtimeHostname?: string;

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;
}

/** An AI Gateway resource. */
@added(Versions.v2026_09_01_preview)
model AiGatewayResource is Azure.ResourceManager.TrackedResource<
  AiGatewayProperties,
  false
> {
  ...ResourceNameParameter<
    Resource = AiGatewayResource,
    KeyName = "aiGatewayName",
    SegmentName = "aigateways",
    NamePattern = "^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}

/** Parameters for updating an AI Gateway. */
@added(Versions.v2026_09_01_preview)
model AiGatewayUpdateParameters
  is Azure.ResourceManager.Foundations.TagsUpdateModel<AiGatewayResource>;
