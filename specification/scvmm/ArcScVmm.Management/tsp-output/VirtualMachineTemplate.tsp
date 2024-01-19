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
@doc("The VirtualMachineTemplates resource definition.")
model VirtualMachineTemplate
  is TrackedResource<VirtualMachineTemplateProperties> {
  @doc("Name of the VirtualMachineTemplate.")
  @path
  @key("virtualMachineTemplateName")
  @segment("virtualMachineTemplates")
  name: string;

  @doc("The extended location.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface VirtualMachineTemplates {
  @doc("Implements VirtualMachineTemplate GET method.")
  get is ArmResourceRead<VirtualMachineTemplate>;

  @doc("Onboards the ScVmm VM Template as an Azure VM Template resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    VirtualMachineTemplate,
    BaseParameters<VirtualMachineTemplate>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates the VirtualMachineTemplate resource.")
  update is ArmCustomPatchAsync<
    VirtualMachineTemplate,
    ResourcePatch,
    BaseParameters<VirtualMachineTemplate>,
    ArmAsyncOperationHeader
  >;

  @doc("Deregisters the ScVmm VM Template from Azure.")
  delete is ArmResourceDeleteAsync<
    VirtualMachineTemplate,
    {
      ...BaseParameters<VirtualMachineTemplate>;

      @doc("Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.")
      @query("force")
      force?: boolean;
    },
    ArmAsyncOperationHeader
  >;

  @doc("List of VirtualMachineTemplates in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VirtualMachineTemplate>;

  @doc("List of VirtualMachineTemplates in a subscription.")
  listBySubscription is ArmListBySubscription<VirtualMachineTemplate>;
}

@@projectedName(VirtualMachineTemplates.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(VirtualMachineTemplates.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(VirtualMachineTemplates.createOrUpdate::parameters.resource,
  "Request payload."
);
@@projectedName(VirtualMachineTemplates.update::parameters.properties,
  "json",
  "body"
);
@@extension(VirtualMachineTemplates.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(VirtualMachineTemplates.update::parameters.properties,
  "VirtualMachineTemplates patch details."
);
