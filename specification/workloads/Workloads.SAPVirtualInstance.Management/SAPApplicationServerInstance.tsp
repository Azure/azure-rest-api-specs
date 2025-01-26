import "@typespec/openapi";
import "./models.tsp";
import "./SAPVirtualInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Workloads;
/**
 * Define the SAP Application Server Instance resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is used for representing the company product."
@parentResource(SAPVirtualInstance)
model SAPApplicationServerInstance
  is TrackedResource<SAPApplicationServerProperties> {
  ...ResourceNameParameter<
    Resource = SAPApplicationServerInstance,
    KeyName = "applicationInstanceName",
    SegmentName = "applicationInstances",
    NamePattern = "^.*"
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is used for representing the company product."
@armResourceOperations
interface SAPApplicationServerInstances {
  /**
   * Gets the SAP Application Server Instance corresponding to the Virtual Instance for SAP solutions resource.
   */
  get is ArmResourceRead<SAPApplicationServerInstance>;

  /**
   * Puts the SAP Application Server Instance resource. &lt;br&gt;&lt;br&gt;This will be used by service only. PUT by end user will return a Bad Request error.
   */
  create is ArmResourceCreateOrReplaceAsync<SAPApplicationServerInstance>;

  /**
   * Puts the SAP Application Server Instance resource.
   */
  @parameterVisibility
  update is ArmCustomPatchSync<
    SAPApplicationServerInstance,
    UpdateSAPApplicationInstanceRequest
  >;

  /**
   * Deletes the SAP Application Server Instance resource. &lt;br&gt;&lt;br&gt;This operation will be used by service only. Delete by end user will return a Bad Request error.
   */
  delete is ArmResourceDeleteWithoutOkAsync<SAPApplicationServerInstance>;

  /**
   * Lists the SAP Application Server Instance resources for a given Virtual Instance for SAP solutions resource.
   */
  list is ArmResourceListByParent<SAPApplicationServerInstance>;

  /**
   * Starts the SAP Application Server Instance.
   */
  start is ArmResourceActionAsync<
    SAPApplicationServerInstance,
    {
      @doc("SAP Application server instance start request body.")
      @body
      body?: StartRequest;
    },
    Foundations.OperationStatusResult
  >;

  /**
   * Stops the SAP Application Server Instance.
   */
  stop is ArmResourceActionAsync<
    SAPApplicationServerInstance,
    {
      @doc("SAP Application server instance stop request body.")
      @body
      body?: StopRequest;
    },
    Foundations.OperationStatusResult
  >;
}

@@doc(SAPApplicationServerInstance.name,
  "The name of SAP Application Server instance resource."
);
@@doc(SAPApplicationServerInstances.create::parameters.resource,
  "The SAP Application Server Instance resource request body."
);
@@doc(SAPApplicationServerInstances.update::parameters.properties,
  "The SAP Application Server Instance resource request body."
);
@@doc(SAPApplicationServerInstances.start::parameters.body,
  "SAP Application server instance start request body."
);
@@doc(SAPApplicationServerInstances.stop::parameters.body,
  "SAP Application server instance stop request body."
);
