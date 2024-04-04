import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./namespace.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.DurableTask;

@doc("An TaskHub resource belonging to the namespace.")
@parentResource(Namespace)
model TaskHub is ProxyResource<TaskHubProperties> {
	@doc("Task Hub name")
	@key("taskHubName")
	@pattern("^[a-zA-Z0-9-]{3,128}$")
	@segment("taskHubs")
	@path
	@visibility("read", "create")
	name: string;
}

@armResourceOperations(TaskHub)
interface TaskHubs {
	get is ArmResourceRead<TaskHub>;
	createOrUpdate is ArmResourceCreateOrReplaceSync<TaskHub>;
	delete is ArmResourceDeleteSync<TaskHub>;
	listByParent is ArmResourceListByParent<TaskHub>;
}