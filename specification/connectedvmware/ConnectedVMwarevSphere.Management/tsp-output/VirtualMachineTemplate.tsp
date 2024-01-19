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

namespace Microsoft.ConnectedVMwarevSphere;
@doc("Define the virtualMachineTemplate.")
model VirtualMachineTemplate
  is TrackedResource<VirtualMachineTemplateProperties> {
  @doc("Name of the virtual machine template resource.")
  @path
  @key("virtualMachineTemplateName")
  @segment("virtualMachineTemplates")
  name: string;

  @doc("Gets or sets the extended location.")
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface VirtualMachineTemplates {
  @doc("Implements virtual machine template GET method.")
  get is ArmResourceRead<VirtualMachineTemplate>;

  @doc("Create Or Update virtual machine template.")
  create is ArmResourceCreateOrUpdateAsync<
    VirtualMachineTemplate,
    BaseParameters<VirtualMachineTemplate>,
    ArmAsyncOperationHeader
  >;

  @doc("API to update certain properties of the virtual machine template resource.")
  update is ArmCustomPatchSync<VirtualMachineTemplate, ResourcePatch>;

  @doc("Implements virtual machine template DELETE method.")
  delete is ArmResourceDeleteAsync<
    VirtualMachineTemplate,
    {
      ...BaseParameters<VirtualMachineTemplate>;

      @doc("Whether force delete was specified.")
      @query("force")
      force?: boolean;
    }
  >;

  @doc("List of virtualMachineTemplates in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VirtualMachineTemplate>;

  @doc("List of virtualMachineTemplates in a subscription.")
  list is ArmListBySubscription<VirtualMachineTemplate>;
}

@@projectedName(VirtualMachineTemplates.create::parameters.resource,
  "json",
  "body"
);
@@extension(VirtualMachineTemplates.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(VirtualMachineTemplates.create::parameters.resource, "Request payload.");
@@projectedName(VirtualMachineTemplates.update::parameters.properties,
  "json",
  "body"
);
@@extension(VirtualMachineTemplates.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(VirtualMachineTemplates.update::parameters.properties,
  "Resource properties to update."
);
