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
/**
 * Define the virtualMachineTemplate.
 */
model VirtualMachineTemplate
  is TrackedResource<VirtualMachineTemplateProperties> {
  /**
   * Name of the virtual machine template resource.
   */
  @path
  @key("virtualMachineTemplateName")
  @segment("virtualMachineTemplates")
  name: string;

  /**
   * Gets or sets the extended location.
   */
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface VirtualMachineTemplates {
  /**
   * Implements virtual machine template GET method.
   */
  get is ArmResourceRead<VirtualMachineTemplate>;

  /**
   * Create Or Update virtual machine template.
   */
  create is ArmResourceCreateOrReplaceAsync<
    VirtualMachineTemplate,
    BaseParameters<VirtualMachineTemplate>,
    ArmAsyncOperationHeader
  >;

  /**
   * API to update certain properties of the virtual machine template resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<VirtualMachineTemplate, ResourcePatch>;

  /**
   * Implements virtual machine template DELETE method.
   */
  delete is ArmResourceDeleteAsync<
    VirtualMachineTemplate,
    {
      ...BaseParameters<VirtualMachineTemplate>;

      /**
       * Whether force delete was specified.
       */
      @query("force")
      force?: boolean;
    }
  >;

  /**
   * List of virtualMachineTemplates in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VirtualMachineTemplates_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<VirtualMachineTemplate>;

  /**
   * List of virtualMachineTemplates in a subscription.
   */
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
