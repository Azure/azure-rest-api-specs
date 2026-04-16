import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ImageTemplate.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.VirtualMachineImages;
/**
 * Represents a trigger that can invoke an image template build.
 */
@parentResource(ImageTemplate)
model Trigger is Azure.ResourceManager.ProxyResource<TriggerProperties> {
  ...ResourceNameParameter<
    Resource = Trigger,
    KeyName = "triggerName",
    SegmentName = "triggers",
    NamePattern = "^[A-Za-z0-9-_.]{1,64}$"
  >;
}

@armResourceOperations
interface Triggers {
  /**
   * Get the specified trigger for the specified image template resource
   */
  get is ArmResourceRead<Trigger>;

  /**
   * Create or update a trigger for the specified virtual machine image template
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Trigger>;

  /**
   * Delete a trigger for the specified virtual machine image template
   */
  delete is ArmResourceDeleteWithoutOkAsync<Trigger>;

  /**
   * List all triggers for the specified Image Template resource
   */
  listByImageTemplate is ArmResourceListByParent<
    Trigger,
    Response = ArmResponse<TriggerCollection>
  >;
}

@@doc(Trigger.name, "The name of the trigger");
@@doc(Trigger.properties, "The properties of a trigger");
@@doc(Triggers.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateTrigger operation"
);
