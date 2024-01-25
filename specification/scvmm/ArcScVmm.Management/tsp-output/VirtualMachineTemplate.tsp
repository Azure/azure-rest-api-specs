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
/**
 * The VirtualMachineTemplates resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  VirtualMachineTemplateProperties
)
model VirtualMachineTemplate extends TrackedResourceBase {
  /**
   * Name of the VirtualMachineTemplate.
   */
  @path
  @key("virtualMachineTemplateName")
  @segment("virtualMachineTemplates")
  @visibility("read")
  name: string;

  /**
   * The extended location.
   */
  extendedLocation: ExtendedLocation;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: VirtualMachineTemplateProperties;
}

@armResourceOperations
interface VirtualMachineTemplates {
  /**
   * Implements VirtualMachineTemplate GET method.
   */
  get is ArmResourceRead<VirtualMachineTemplate>;

  /**
   * Onboards the ScVmm VM Template as an Azure VM Template resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualMachineTemplate,
    BaseParameters<VirtualMachineTemplate>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates the VirtualMachineTemplate resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    VirtualMachineTemplate,
    ResourcePatch,
    BaseParameters<VirtualMachineTemplate>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deregisters the ScVmm VM Template from Azure.
   */
  delete is ArmResourceDeleteAsync<
    VirtualMachineTemplate,
    {
      ...BaseParameters<VirtualMachineTemplate>;

      /**
       * Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.
       */
      @query("force")
      force?: boolean;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * List of VirtualMachineTemplates in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VirtualMachineTemplates_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<VirtualMachineTemplate>;

  /**
   * List of VirtualMachineTemplates in a subscription.
   */
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
