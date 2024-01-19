import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DeviceUpdate;
@doc("Device Update instance details.")
@parentResource(Account)
model Instance is TrackedResource<InstanceProperties> {
  @doc("Instance name.")
  @maxLength(36)
  @minLength(3)
  @pattern("^[A-Za-z0-9]+(-[A-Za-z0-9]+)*$")
  @path
  @key("instanceName")
  @segment("instances")
  name: string;
}

@armResourceOperations
interface Instances {
  @doc("Returns instance details for the given instance and account name.")
  get is ArmResourceRead<Instance>;

  @doc("Creates or updates instance.")
  create is ArmResourceCreateOrUpdateAsync<
    Instance,
    BaseParameters<Instance>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates instance's tags.")
  update is ArmCustomPatchSync<Instance, TagUpdate>;

  @doc("Deletes instance.")
  delete is ArmResourceDeleteAsync<
    Instance,
    BaseParameters<Instance>,
    ArmLroLocationHeader
  >;

  @doc("Returns instances for the given account name.")
  listByAccount is ArmResourceListByParent<Instance>;
}

@@projectedName(Instances.create::parameters.resource, "json", "Instance");
@@extension(Instances.create::parameters.resource,
  "x-ms-client-name",
  "Instance"
);
@@doc(Instances.create::parameters.resource, "Instance details.");
@@projectedName(Instances.update::parameters.properties,
  "json",
  "tagUpdatePayload"
);
@@extension(Instances.update::parameters.properties,
  "x-ms-client-name",
  "tagUpdatePayload"
);
@@doc(Instances.update::parameters.properties, "Updated tags.");
