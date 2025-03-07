import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.Logic")
@doc("The azure integration spaces resource provider.")
@service(#{ title: "Microsoft.Logic" })
@versioned(Versions)
namespace Microsoft.Logic;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_06_01_preview: "2025-06-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The Provisioning states.")
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Provisioning state is Provisioning.")
  Provisioning: "Provisioning",

  @doc("Provisioning state is Updating.")
  Updating: "Updating",

  @doc("Provisioning state is Deleting.")
  Deleting: "Deleting",

  @doc("Provisioning state is Accepted.")
  Accepted: "Accepted",
}

@doc("An integration space.")
model Space is TrackedResource<Templates> {
  @key("spaceName")
  @segment("spaces")
  @doc("The name of the space")
  @path
  @pattern("[a-zA-Z0-9_.()-]{0,79}$")
  name: string;
}

@armResourceOperations
@doc("The operations of space.")
interface Spaces {
  get is ArmResourceRead<Space>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<Space>;
  update is ArmResourcePatchSync<Space, SpaceResourcePatchProperties>;
  delete is ArmResourceDeleteSync<Space>;
  listBySubscription is ArmListBySubscription<Space>;
  listByResourceGroup is ArmResourceListByParent<
    Space,
    Azure.ResourceManager.Foundations.BaseParameters<Space> &
      Azure.Core.StandardListQueryParameters &
      Azure.Core.FilterQueryParameter &
      Azure.Core.SelectQueryParameter &
      Azure.Core.ExpandQueryParameter &
      Azure.Core.OrderByQueryParameter
  >;
}

@doc("An infrastructure resource under Space.")
@parentResource(Space)
model InfrastructureResource
  is ProxyResource<InfrastructureResourceProperties> {
  @key("infrastructureResourceName")
  @segment("infrastructureResources")
  @doc("The name of the infrastructure resource in the space.")
  @path
  @pattern("[a-zA-Z0-9_.()-]{0,79}$")
  name: string;
}

@armResourceOperations
@doc("The operations of the infrastructure resource.")
interface InfrastructureResources {
  get is ArmResourceRead<InfrastructureResource>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<InfrastructureResource>;
  update is ArmResourcePatchSync<
    InfrastructureResource,
    InfrastructureResourceProperties
  >;
  delete is ArmResourceDeleteSync<InfrastructureResource>;
  listBySpace is ArmResourceListByParent<
    InfrastructureResource,
    Azure.ResourceManager.Foundations.BaseParameters<InfrastructureResource> &
      Azure.Core.StandardListQueryParameters &
      Azure.Core.FilterQueryParameter &
      Azure.Core.SelectQueryParameter &
      Azure.Core.ExpandQueryParameter &
      Azure.Core.OrderByQueryParameter
  >;
}

@doc("An integration application under space.")
@parentResource(Space)
model Application is TrackedResource<ApplicationProperties> {
  @key("applicationName")
  @segment("applications")
  @doc("The name of the Application")
  @path
  @pattern("[a-zA-Z0-9_.()-]{0,79}$")
  name: string;
}

@armResourceOperations
interface Applications {
  get is ArmResourceRead<Application>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<Application>;
  update is ArmResourcePatchSync<Application, ApplicationPatchProperties>;
  delete is ArmResourceDeleteSync<Application>;
  listBySpace is ArmResourceListByParent<
    Application,
    Azure.ResourceManager.Foundations.BaseParameters<Space> &
      Azure.Core.StandardListQueryParameters &
      Azure.Core.FilterQueryParameter &
      Azure.Core.SelectQueryParameter &
      Azure.Core.ExpandQueryParameter &
      Azure.Core.OrderByQueryParameter
  >;
}

@doc("A resource under application.")
@parentResource(Application)
model ApplicationResource is ProxyResource<ApplicationResourceProperties> {
  @key("resourceName")
  @segment("resources")
  @doc("The name of the application resource.")
  @path
  @pattern("[a-zA-Z0-9_.()-]{0,79}$")
  name: string;
}

@armResourceOperations
interface ApplicationResources {
  get is ArmResourceRead<ApplicationResource>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<ApplicationResource>;
  update is ArmResourcePatchSync<
    ApplicationResource,
    ApplicationResourceProperties
  >;
  delete is ArmResourceDeleteSync<ApplicationResource>;
  listByApplication is ArmResourceListByParent<
    ApplicationResource,
    Azure.ResourceManager.Foundations.BaseParameters<ApplicationResource> &
      Azure.Core.StandardListQueryParameters &
      Azure.Core.FilterQueryParameter &
      Azure.Core.SelectQueryParameter &
      Azure.Core.ExpandQueryParameter &
      Azure.Core.OrderByQueryParameter
  >;
}
