import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using OpenAPI;

namespace Microsoft.ScVmm;
/** The VirtualMachineTemplates resource definition. */
model VirtualMachineTemplate
  is TrackedResource<VirtualMachineTemplateProperties> {
  /** Name of the VirtualMachineTemplate. */
  @maxLength(54)
  @minLength(1)
  @pattern("[a-zA-Z0-9-_\\.]")
  @path
  @key("virtualMachineTemplateName")
  @segment("virtualMachineTemplates")
  name: string;

  /** The extended location. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This property is allowed but not recognized by the linter"
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface VirtualMachineTemplates {
  /** Implements VirtualMachineTemplate GET method. */
  @summary("Gets a VirtualMachineTemplate.")
  get is ArmResourceRead<VirtualMachineTemplate>;
  /** Onboards the ScVmm VM Template as an Azure VM Template resource. */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @summary("Implements VirtualMachineTemplates PUT method.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    VirtualMachineTemplate,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  /** Updates the VirtualMachineTemplate resource. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
  @summary("Implements the VirtualMachineTemplate PATCH method.")
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  update is ArmTagsPatchAsync<VirtualMachineTemplate>;
  /** Deregisters the ScVmm VM Template from Azure. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
  @summary("Implements VirtualMachineTemplate DELETE method.")
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualMachineTemplate,
    {
      ...Foundations.BaseParameters<VirtualMachineTemplate>;
      ...QueryForceDelete;
    }
  >;
  /** List of VirtualMachineTemplates in a resource group. */
  @summary("Implements GET VirtualMachineTemplates in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VirtualMachineTemplate>;
  /** List of VirtualMachineTemplates in a subscription. */
  @summary("Implements GET VirtualMachineTemplates in a subscription.")
  listBySubscription is ArmListBySubscription<VirtualMachineTemplate>;
}
