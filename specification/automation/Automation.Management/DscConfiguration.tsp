import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the configuration type.
 */
@parentResource(AutomationAccount)
model DscConfiguration
  is Azure.ResourceManager.TrackedResource<DscConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = DscConfiguration,
    KeyName = "configurationName",
    SegmentName = "configurations",
    NamePattern = ""
  >;

  /**
   * Gets or sets the etag of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface DscConfigurations {
  /**
   * Retrieve the configuration identified by configuration name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DscConfiguration_Get")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/configurationoperations")
  get is ArmResourceRead<DscConfiguration>;

  /**
   * Create the configuration identified by configuration name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DscConfiguration_CreateOrUpdate")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/configurationoperations")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    DscConfiguration,
    Request = DscConfigurationCreateOrUpdateParameters
  >;

  /**
   * Create the configuration identified by configuration name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DscConfiguration_Update")
  @patch(#{ implicitOptionality: false })
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/configurationoperations")
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    DscConfiguration,
    PatchModel = DscConfigurationUpdateParameters,
    OptionalRequestBody = true
  >;

  /**
   * Delete the dsc configuration identified by configuration name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DscConfiguration_Delete")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/configurationoperations")
  delete is ArmResourceDeleteSync<DscConfiguration>;

  /**
   * Retrieve a list of configurations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DscConfiguration_ListByAutomationAccount")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/configurationoperations")
  listByAutomationAccount is ArmResourceListByParent<
    DscConfiguration,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of rows to skip.
       */
      @query("$skip")
      $skip?: int32;

      /**
       * The number of rows to take.
       */
      @query("$top")
      $top?: int32;

      /**
       * Return total rows.
       */
      @query("$inlinecount")
      $inlinecount?: string;
    },
    Response = ArmResponse<DscConfigurationListResult>
  >;

  /**
   * Retrieve the configuration script identified by configuration name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/configurationoperations")
  @operationId("DscConfiguration_GetContent")
  @get
  @action("content")
  getContent is ArmResourceActionSync<
    DscConfiguration,
    void,
    ArmResponse<File>
  >;
}

@@doc(DscConfiguration.name, "The configuration name.");
@@doc(DscConfiguration.properties,
  "Gets or sets the configuration properties."
);
@@doc(DscConfigurations.createOrUpdate::parameters.resource,
  "The create or update parameters for configuration."
);
@@doc(DscConfigurations.update::parameters.properties,
  "The create or update parameters for configuration."
);
