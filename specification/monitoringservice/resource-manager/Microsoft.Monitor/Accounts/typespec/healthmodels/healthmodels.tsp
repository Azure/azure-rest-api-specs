import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "./models.tsp";
import "../models.tsp";
import "../service.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is defined in a separate spec for Microsoft.Monitor namespace (specification/monitor/resource-manager/Microsoft.Monitor/Operations)"
@armProviderNamespace("Microsoft.Monitor")
@service(#{ title: "Azure Monitor Workspaces Control Plane API" })
@versioned(Versions)
namespace Microsoft.Monitor;

// Regex for our health model resource name validations. Between 3 and 44 characters, alphanumeric and hyphens, must start with an alphabetic character and end with an alphanumeric character
alias modelResourceNameRegex = "^[a-zA-Z][a-zA-Z0-9-]{1,42}[a-zA-Z0-9]$";

@pattern(modelResourceNameRegex)
@doc("String with regex validation to match the health model resource name requirements")
scalar stringModelResourceName extends string;

// Regex for all our proxy resource name validations. Up to 260 characters, alphanumeric and hyphens, must start and end with an alphanumeric character
alias proxyResourceNameRegex = "^[a-zA-Z0-9][a-zA-Z0-9-]{1,258}[a-zA-Z0-9]$";

@pattern(proxyResourceNameRegex)
@doc("String with regex validation to match the proxy resource name requirements")
scalar stringResourceName extends string;

@maxLength(4096)
@doc("String with max length validation of 4096 characters")
scalar string4096 extends string;

@doc("A HealthModel resource")
@parentResource(AzureMonitorWorkspaceResource)
model HealthModel is TrackedResource<HealthModelProperties> {
  @doc("Name of health model resource")
  @key("healthModelName")
  @path
  @segment("healthmodels")
  name: stringModelResourceName;

  ...ManagedServiceIdentityProperty;
}

@doc("An authentication setting in a health model")
@parentResource(HealthModel)
model AuthenticationSetting is ProxyResource<AuthenticationSettingProperties> {
  @doc("Name of the authentication setting. Must be unique within a health model.")
  @key("authenticationSettingName")
  @segment("authenticationsettings")
  @path
  name: stringResourceName;
}

@doc("An entity (aka node) of a health model")
@parentResource(HealthModel)
model Entity is ProxyResource<EntityProperties> {
  @doc("Name of the entity. Must be unique within a health model.")
  @key("entityName")
  @segment("entities")
  @path
  name: stringResourceName;
}

@doc("A relationship (aka edge) between two entities in a health model")
@parentResource(HealthModel)
model Relationship is ProxyResource<RelationshipProperties> {
  @doc("Name of the relationship. Must be unique within a health model. For example, a concatenation of parentEntityName and childEntityName can be used as the name.")
  @key("relationshipName")
  @segment("relationships")
  @path
  name: stringResourceName;
}

@doc("A discovery rule which automatically finds entities and relationships in a health model based on an Azure Resource Graph query")
@parentResource(HealthModel)
model DiscoveryRule is ProxyResource<DiscoveryRuleProperties> {
  @doc("Name of the discovery rule. Must be unique within a health model.")
  @key("discoveryRuleName")
  @segment("discoveryrules")
  @path
  name: stringResourceName;
}

@doc("A signal definition in a health model")
@parentResource(HealthModel)
model SignalDefinition is ProxyResource<SignalDefinitionProperties> {
  @doc("Name of the signal definition. Must be unique within a health model.")
  @key("signalDefinitionName")
  @segment("signaldefinitions")
  @path
  name: stringResourceName;
}

@armResourceOperations(HealthModel)
@removed(Versions.v2025_10_03)
interface HealthModels {
  get is ArmResourceRead<HealthModel>;
  create is ArmResourceCreateOrUpdateAsync<HealthModel>;
  update is ArmCustomPatchAsync<
    HealthModel,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<HealthModel, {}>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<HealthModel>;
  listByParentResource is ArmResourceListByParent<HealthModel>;
}

@armResourceOperations(SignalDefinition)
@removed(Versions.v2025_10_03)
interface SignalDefinitions {
  get is ArmResourceRead<SignalDefinition>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<SignalDefinition>;
  delete is ArmResourceDeleteSync<SignalDefinition>;

  listByHealthModel is ArmResourceListByParent<
    SignalDefinition,
    Azure.ResourceManager.Foundations.BaseParameters<SignalDefinition> &
      TimestampQueryParam
  >;
}

@armResourceOperations(AuthenticationSetting)
@removed(Versions.v2025_10_03)
interface AuthenticationSettings {
  get is ArmResourceRead<AuthenticationSetting>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<AuthenticationSetting>;
  delete is ArmResourceDeleteSync<AuthenticationSetting>;

  listByHealthModel is ArmResourceListByParent<AuthenticationSetting>;
}

@armResourceOperations(Entity)
@removed(Versions.v2025_10_03)
interface Entities {
  get is ArmResourceRead<Entity>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<Entity>;
  delete is ArmResourceDeleteSync<Entity>;

  listByHealthModel is ArmResourceListByParent<
    Entity,
    Azure.ResourceManager.Foundations.BaseParameters<Entity> &
      TimestampQueryParam
  >;
}

@armResourceOperations(Relationship)
@removed(Versions.v2025_10_03)
interface Relationships {
  get is ArmResourceRead<Relationship>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<Relationship>;
  delete is ArmResourceDeleteSync<Relationship>;

  listByHealthModel is ArmResourceListByParent<
    Relationship,
    Azure.ResourceManager.Foundations.BaseParameters<Relationship> &
      TimestampQueryParam
  >;
}

@armResourceOperations(DiscoveryRule)
@removed(Versions.v2025_10_03)
interface DiscoveryRules {
  get is ArmResourceRead<DiscoveryRule>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<DiscoveryRule>;
  delete is ArmResourceDeleteSync<DiscoveryRule>;

  listByHealthModel is ArmResourceListByParent<
    DiscoveryRule,
    Azure.ResourceManager.Foundations.BaseParameters<DiscoveryRule> &
      TimestampQueryParam
  >;
}

alias TimestampQueryParam = {
  @doc("Timestamp to use for the operation. When specified, the version of the resource at this point in time is retrieved. If not specified, the latest version is used.")
  @query
  timestamp?: utcDateTime;
};
