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
using Azure.Core;

namespace Microsoft.DurableTask;

@doc("A DurableTaskService resource")
model Namespace is TrackedResource<NamespaceProperties> {
	@doc("The name of the service")
	@pattern("^[a-zA-Z0-9-]{3,128}$")
	@key("namespaceName")
	@segment("namespaces")
	@path
	@visibility("read","create")
	name: string;

    ...ManagedServiceIdentity;
}

@armResourceOperations(Namespace)
interface Namespaces {
	get is ArmResourceRead<Namespace>;
	createOrUpdate is ArmResourceCreateOrReplaceAsync<Namespace>;
	update is ArmResourcePatchSync<
		Namespace,
		NamespaceProperties
	>;
	delete is ArmResourceDeleteSync<Namespace>;
	listByResourceGroup is ArmResourceListByParent<Namespace>;
	listBySubscription is ArmListBySubscription<Namespace>;
}

