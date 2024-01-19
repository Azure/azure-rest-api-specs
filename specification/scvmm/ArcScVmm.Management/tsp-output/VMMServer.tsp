import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ScVmm;
@doc("The VmmServers resource definition.")
model VMMServer is TrackedResource<VMMServerProperties> {
  @doc("Name of the VMMServer.")
  @path
  @key("vmmServerName")
  @segment("vmmServers")
  name: string;

  @doc("The extended location.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface VMMServers {
  @doc("Implements VMMServer GET method.")
  get is ArmResourceRead<VMMServer>;

  @doc("Onboards the SCVMM fabric as an Azure VmmServer resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    VMMServer,
    BaseParameters<VMMServer>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates the VmmServers resource.")
  update is ArmCustomPatchAsync<
    VMMServer,
    ResourcePatch,
    BaseParameters<VMMServer>,
    ArmAsyncOperationHeader
  >;

  @doc("Deboards the SCVMM fabric from Azure.")
  delete is ArmResourceDeleteAsync<
    VMMServer,
    {
      ...BaseParameters<VMMServer>;

      @doc("Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.")
      @query("force")
      force?: boolean;
    },
    ArmAsyncOperationHeader
  >;

  @doc("List of VmmServers in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VMMServer>;

  @doc("List of VmmServers in a subscription.")
  listBySubscription is ArmListBySubscription<VMMServer>;
}

@@projectedName(VMMServers.createOrUpdate::parameters.resource, "json", "body");
@@extension(VMMServers.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(VMMServers.createOrUpdate::parameters.resource, "Request payload.");
@@projectedName(VMMServers.update::parameters.properties, "json", "body");
@@extension(VMMServers.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(VMMServers.update::parameters.properties, "VmmServers patch payload.");
