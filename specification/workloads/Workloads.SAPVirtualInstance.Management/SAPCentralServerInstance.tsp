import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SAPVirtualInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
/**
 * Define the SAP Central Services Instance resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is used for representing the company product."
@parentResource(SAPVirtualInstance)
model SAPCentralServerInstance is TrackedResource<SAPCentralServerProperties> {
  ...ResourceNameParameter<
    Resource = SAPCentralServerInstance,
    KeyName = "centralInstanceName",
    SegmentName = "centralInstances",
    NamePattern = "^.*"
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is used for representing the company product."
@armResourceOperations
interface SAPCentralServerInstances {
  /**
   * Gets the SAP Central Services Instance resource.
   */
  get is ArmResourceRead<SAPCentralServerInstance>;

  /**
   * Creates the SAP Central Services Instance resource. &lt;br&gt;&lt;br&gt;This will be used by service only. PUT operation on this resource by end user will return a Bad Request error.
   */
  create is ArmResourceCreateOrReplaceAsync<SAPCentralServerInstance>;

  /**
   * Updates the SAP Central Services Instance resource. &lt;br&gt;&lt;br&gt;This can be used to update tags on the resource.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<
    SAPCentralServerInstance,
    UpdateSAPCentralInstanceRequest
  >;

  /**
   * Deletes the SAP Central Services Instance resource. &lt;br&gt;&lt;br&gt;This will be used by service only. Delete operation on this resource by end user will return a Bad Request error. You can delete the parent resource, which is the Virtual Instance for SAP solutions resource, using the delete operation on it.
   */
  delete is ArmResourceDeleteWithoutOkAsync<SAPCentralServerInstance>;

  /**
   * Lists the SAP Central Services Instance resource for the given Virtual Instance for SAP solutions resource.
   */
  list is ArmResourceListByParent<SAPCentralServerInstance>;

  /**
   * Starts the SAP Central Services Instance.
   */
  start is ArmResourceActionAsync<
    SAPCentralServerInstance,
    {
      @doc("SAP Central Services instance start request body.")
      @body
      body?: StartRequest;
    },
    Foundations.OperationStatusResult
  >;

  /**
   * Stops the SAP Central Services Instance.
   */
  stop is ArmResourceActionAsync<
    SAPCentralServerInstance,
    {
      @doc("SAP Central Services instance stop request body.")
      @body
      body?: StopRequest;
    },
    Foundations.OperationStatusResult
  >;
}

@@doc(SAPCentralServerInstance.name,
  "Central Services Instance resource name string modeled as parameter for auto generation to work correctly."
);
@@doc(SAPCentralServerInstances.create::parameters.resource,
  "The SAP Central Services Instance request body."
);
@@doc(SAPCentralServerInstances.update::parameters.properties,
  "The SAP Central Services Instance resource request body."
);
@@doc(SAPCentralServerInstances.start::parameters.body,
  "SAP Central Services instance start request body."
);
@@doc(SAPCentralServerInstances.stop::parameters.body,
  "SAP Central Services instance stop request body."
);
