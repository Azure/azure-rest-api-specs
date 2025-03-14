import "./common.tsp";
import "../resources/common.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Inventory;

@added(Versions.v2024_11_01_preview)
@doc("Service Properties")
model ServiceProperties {
  @doc("The display name of the service")
  displayName: string;

  @doc("The id of the service")
  serviceId: string;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2024_11_01_preview)
@doc("The Linked Subscription Properties")
model LinkedSubscriptionProperties {
  @doc("The ARM properties of the subscription")
  subscription: ComplexArmObject;

  @doc("The environment where the subscription resides")
  environment: SubscriptionEnvironment;

  @doc("The cloud where the subscription resides")
  cloud: Cloud;

  @doc("The status of the subscription")
  status: SubscriptionStatus;

  @doc("Determines if the subscription is hosted on behalf of")
  isHobo: IsSubscriptionHobo;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2024_11_01_preview)
@doc("The ARM namespace properties")
model ArmNamespaceProperties {
  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2024_11_01_preview)
@doc("The Resource Type Properties")
model ResourceTypeProperties {
  @doc("The namespace of the resource type")
  resourceNamespace: string;

  @doc("Specifies the readiness of the namespace")
  namespaceReadiness: NamespaceReadiness;

  @doc("The name of the resource type")
  resourceTypeName: string;

  @doc("Specifies the readiness of the resource type")
  resourceTypeReadiness: ResourceTypeReadiness;

  @doc("The type space ID for the resource type")
  typeSpaceId?: string;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2024_11_01_preview)
@doc("The IcM tenant Properties")
model IcmTenantProperties {
  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2024_11_01_preview)
@doc("The IcM team Properties")
model IcmTeamProperties {
  @doc("The tenant name")
  tenantName: string;

  @doc("The team name")
  teamName: string;

  @doc("The tenant front end category name")
  tenantFrontEndCategoryName: string;

  @doc("The tenant ID")
  tenantId: string;

  @doc("The tenant silo ID")
  tenantSiloId: string;

  @doc("The tenant silo IDs")
  tenantSiloIds: string[];

  @doc("The team ID")
  teamId: string;

  @doc("The team public ID")
  teamPublicId: string;

  @doc("The tenant public ID")
  tenantPublicId: string;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2024_11_01_preview)
@doc("The Linked Entra Applications Properties")
model LinkedEntraApplicationProperties {
  @doc("The tenant ID")
  tenantId: string;

  @doc("The ARM properties of the application")
  application: ComplexArmObject;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2024_11_01_preview)
@doc("The Service Hierarchy Properties")
model ServiceHierarchyProperties {
  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2024_11_01_preview)
@doc("The Service Instance Properties")
model ServiceInstanceProperties {
  @doc("The display name of the service instance")
  displayName: string;

  @doc("The service instance ID of the service instance")
  serviceInstanceId: string;

  @doc("The ms location ID of the service instance")
  msLocationId: string;

  @doc("The service hierarchy of the service instance")
  serviceHierarchy: string;

  @doc("The location identifier of the service instance")
  locationIdentifier: string;

  @doc("The cloud in which the service instance resides")
  cloud: Cloud;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2024_11_01_preview)
@doc("Enum that represents the subscription environment")
union SubscriptionEnvironment {
  string,

  @doc("Subscription environment is Production")
  Production: "Production",

  @doc("Subscription environment is NonProduction")
  NonProduction: "NonProduction",
}

@added(Versions.v2024_11_01_preview)
@doc("Enum that represents whether the subscription is active or inactive")
union SubscriptionStatus {
  string,

  @doc("Subscription status is Active")
  Active: "Active",

  @doc("Subscription status is Inactive")
  Inactive: "Inactive",
}

@added(Versions.v2024_11_01_preview)
@doc("Enum that represents whether the subscription is hosted on behalf of")
union IsSubscriptionHobo {
  string,

  @doc("Subscription is HOBO")
  True: "True",

  @doc("Subscription is not HOBO")
  False: "False",
}

@added(Versions.v2024_11_01_preview)
@doc("Enum that represents the readiness of the namespace")
union NamespaceReadiness {
  string,

  @doc("The namespace is in development")
  InDevelopment: "InDevelopment",

  @doc("The namespace is in private preview")
  PrivatePreview: "PrivatePreview",

  @doc("The namespace is in public preview")
  PublicPreview: "PublicPreview",

  @doc("The namespace is in general availability")
  GA: "GA",

  @doc("The namespace is closing down")
  ClosingDown: "ClosingDown",

  @doc("The namespace is retired")
  Retired: "Retired",
}

@added(Versions.v2024_11_01_preview)
@doc("Enum that represents the readiness of the resource type")
union ResourceTypeReadiness {
  string,

  @doc("The namespace is in development")
  InDevelopment: "InDevelopment",

  @doc("The namespace is in private preview")
  PrivatePreview: "PrivatePreview",

  @doc("The namespace is in public preview")
  PublicPreview: "PublicPreview",

  @doc("The namespace is in general availability")
  GA: "GA",

  @doc("The namespace is internal only")
  InternalOnly: "InternalOnly",

  @doc("The namespace is closing down")
  ClosingDown: "ClosingDown",

  @doc("The namespace is removed from ARM")
  RemovedFromARM: "RemovedFromARM",

  @doc("The namespace is deprecated")
  Deprecated: "Deprecated",
}
