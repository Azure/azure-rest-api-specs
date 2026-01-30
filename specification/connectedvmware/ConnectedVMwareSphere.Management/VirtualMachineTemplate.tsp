import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ConnectedVMwarevSphere;
/**
 * Define the virtualMachineTemplate.
 */
model VirtualMachineTemplate
  is Azure.ResourceManager.TrackedResource<
    VirtualMachineTemplateProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = VirtualMachineTemplate,
    KeyName = "virtualMachineTemplateName",
    SegmentName = "virtualMachineTemplates",
    NamePattern = ""
  >;

  /**
   * Gets or sets the extended location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type; e.g. ApiApps are a kind of Microsoft.Web/sites type.  If supported, the resource provider must validate and persist this value.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface VirtualMachineTemplatesOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = VirtualMachineTemplate,
        KeyName = "virtualMachineTemplateName",
        SegmentName = "virtualMachineTemplates",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface VirtualMachineTemplates {
  /**
   * Implements virtual machine template GET method.
   */
  get is ArmResourceRead<VirtualMachineTemplate>;

  /**
   * Create Or Update virtual machine template.
   */
  create is VirtualMachineTemplatesOps.CreateOrUpdateAsync<
    VirtualMachineTemplate,
    OptionalRequestBody = true
  >;

  /**
   * API to update certain properties of the virtual machine template resource.
   */
  @patch(#{ implicitOptionality: false })
  update is VirtualMachineTemplatesOps.CustomPatchSync<
    VirtualMachineTemplate,
    PatchModel = ResourcePatch,
    OptionalRequestBody = true
  >;

  /**
   * Implements virtual machine template DELETE method.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualMachineTemplate,
    Parameters = {
      /**
       * Whether force delete was specified.
       */
      @query("force")
      force?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List of virtualMachineTemplates in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    VirtualMachineTemplate,
    Response = ArmResponse<VirtualMachineTemplatesList>
  >;

  /**
   * List of virtualMachineTemplates in a subscription.
   */
  list is ArmListBySubscription<
    VirtualMachineTemplate,
    Response = ArmResponse<VirtualMachineTemplatesList>
  >;
}

@@doc(VirtualMachineTemplate.name,
  "Name of the virtual machine template resource."
);
@@doc(VirtualMachineTemplate.properties, "Resource properties.");
@@doc(VirtualMachineTemplates.create::parameters.resource, "Request payload.");
@@doc(VirtualMachineTemplates.update::parameters.properties,
  "Resource properties to update."
);
