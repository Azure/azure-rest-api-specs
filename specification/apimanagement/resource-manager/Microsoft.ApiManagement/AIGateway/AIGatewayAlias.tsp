import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ApiManagement;

/** A model targeted by an AI Gateway alias. */
@added(Versions.v2026_11_01)
model AiGatewayAliasTarget {
  /** Azure resource identifier of the target model in the default workspace. */
  resourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ApiManagement/aigateways/workspaces/modelProviders/models";
    },
    {
      type: "Microsoft.ApiManagement/service/workspaces/modelProviders/models";
    }
  ]>;

  /** Routing priority. Lower values are preferred; the effective default is zero. */
  @minValue(0)
  @maxValue(100)
  priority?: int32;

  /** Relative selection weight within a priority group. The effective default is one. */
  @minValue(1)
  @maxValue(100)
  weight?: int32;
}

/** A model target to update on an AI Gateway alias. */
@added(Versions.v2026_11_01)
model AiGatewayAliasTargetUpdate is OptionalProperties<AiGatewayAliasTarget>;

/** Properties of a stable client-facing model alias. */
@added(Versions.v2026_11_01)
model AiGatewayAliasProperties {
  /** Client-facing routing name sent in the request model field. */
  aliasName?: string;

  /** Description of the alias. */
  @maxLength(1024)
  description?: string;

  /** Ordered target models used for routing. */
  @minItems(1)
  @maxItems(30)
  @identifiers(#["resourceId"])
  backendModels: AiGatewayAliasTarget[];

  /** Ordered routing stages. Only the routing stage is currently supported. */
  selectionOrder?: "routing"[];

  /** Native endpoints common to every target model; translated endpoints are excluded. */
  @visibility(Lifecycle.Read)
  supportedEndpoints?: string[];

  /** Invocation endpoints, when endpoint metadata is enabled for this gateway. */
  @visibility(Lifecycle.Read)
  @identifiers(#["url"])
  gatewayEndpoints?: AiGatewayEndpoint[];

  /** Inline policies applied to requests routed through the alias. */
  @identifiers(#[])
  policies?: AiGatewayPolicy[];

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;
}

/** Properties to update on an AI Gateway alias. */
@added(Versions.v2026_11_01)
model AiGatewayAliasUpdateProperties {
  /** Client-facing routing name sent in the request model field. */
  aliasName?: string;

  /** Description of the alias. */
  @maxLength(1024)
  description?: string;

  /** Ordered target models used for routing. */
  @minItems(1)
  @maxItems(30)
  @identifiers(#[])
  backendModels?: AiGatewayAliasTargetUpdate[];

  /** Ordered routing stages. Only the routing stage is currently supported. */
  selectionOrder?: "routing"[];

  /** Inline policies applied to requests routed through the alias. */
  @identifiers(#[])
  policies?: AiGatewayPolicyUpdate[];
}

/** Parameters for updating an AI Gateway alias. */
@added(Versions.v2026_11_01)
model AiGatewayAliasUpdateParameters {
  /** Alias properties to update. */
  properties?: AiGatewayAliasUpdateProperties;
}

/** A stable client-facing model identity backed by an ordered pool of models. */
@added(Versions.v2026_11_01)
@parentResource(AiGatewayWorkspaceResource)
model AiGatewayAliasResource is ProxyResource<AiGatewayAliasProperties> {
  ...ResourceNameParameter<
    Resource = AiGatewayAliasResource,
    KeyName = "aliasId",
    SegmentName = "aliases",
    NamePattern = "^[a-zA-Z0-9_.-]+$"
  >;
  ...EntityTagProperty;
}
