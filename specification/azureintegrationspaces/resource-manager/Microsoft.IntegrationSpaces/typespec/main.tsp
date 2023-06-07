import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.IntegrationSpaces")
@service({
	title: "Microsoft.IntegrationSpaces",
	version: "2023-06-01-preview",
})
@doc("The azure integration spaces resource provider.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.IntegrationSpaces;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
	...ResourceProvisioningState,
	Provisioning,
	Updating,
	Deleting,
	Accepted,
}

@doc("The properties of the resource.")
model ResourceProperties {
	@visibility("read")
	@doc("The status of the last operation.")
	provisioningState?: ProvisioningState;

	@doc("The type of the resource.")
	resourceType: string;

	@doc("The id of the resource.")
	resourceId: string;
}

// Space
@doc("An integration space.")
model Space is TrackedResource<TrackedAisResourceProperties> {
	@key("spaceName")
	@segment("spaces")
	@doc("The name of the space")
	@path
	@pattern("[a-zA-Z0-9_.()-]{0,79}$")
	name: string;
}

@doc("The properties of the space and application.")
model TrackedAisResourceProperties {
	@visibility("read")
	@doc("The status of the last operation.")
	provisioningState?: ProvisioningState;

	@doc("The description of the resource.")
	description?: string;
}

@armResourceOperations
@doc("The operations of space.")
interface Spaces {
	get is ArmResourceRead<Space>;
	create is ArmResourceCreateOrUpdateAsync<Space>;
	update is ArmResourcePatchSync<Space, TrackedAisResourceProperties>;
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

// Infrastructure resource
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

@doc("The properties of the infrastructure resource.")
model InfrastructureResourceProperties extends ResourceProperties {}

@armResourceOperations
@doc("The operations of the infrastructure resource.")
interface InfrastructureResources {
	get is ArmResourceRead<InfrastructureResource>;
	create is ArmResourceCreateOrUpdateAsync<InfrastructureResource>;
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

// Application
@doc("An integration application under space.")
@parentResource(Space)
model Application is TrackedResource<TrackedAisResourceProperties> {
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
	create is ArmResourceCreateOrUpdateAsync<Application>;
	update is ArmResourcePatchSync<Application, TrackedAisResourceProperties>;
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

// Application resource
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

@doc("The properties of the infrastructure resource.")
model ApplicationResourceProperties extends ResourceProperties {
	@doc("The kind of the application resource.")
	resourceKind?: string;
}

@armResourceOperations
interface ApplicationResources {
	get is ArmResourceRead<ApplicationResource>;
	create is ArmResourceCreateOrUpdateAsync<ApplicationResource>;
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
