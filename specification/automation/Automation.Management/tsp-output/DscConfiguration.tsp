import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the configuration type.
 */
@parentResource(AutomationAccount)
model DscConfiguration is TrackedResource<DscConfigurationProperties> {
  /**
   * The configuration name.
   */
  @path
  @key("configurationName")
  @segment("configurations")
  name: string;

  /**
   * Gets or sets the etag of the resource.
   */
  etag?: string;
}

@armResourceOperations
interface DscConfigurations {
  /**
   * Retrieve the configuration identified by configuration name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DscConfiguration_Get")
  get is ArmResourceRead<DscConfiguration>;

  /**
   * Create the configuration identified by configuration name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DscConfiguration_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DscConfiguration>;

  /**
   * Create the configuration identified by configuration name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("DscConfiguration_Update")
  update is ArmCustomPatchSync<
    DscConfiguration,
    DscConfigurationUpdateParameters
  >;

  /**
   * Delete the dsc configuration identified by configuration name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DscConfiguration_Delete")
  delete is ArmResourceDeleteSync<DscConfiguration>;

  /**
   * Retrieve a list of configurations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DscConfiguration_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<
    DscConfiguration,
    {
      ...BaseParameters<DscConfiguration>;

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
    }
  >;

  /**
   * Retrieve the configuration script identified by configuration name.
   */
  // FIXME: DscConfiguration_GetContent could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DscConfiguration_GetContent")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/configurations/{configurationName}/content")
  @get
  getContent is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The configuration name.
       */
      @path
      configurationName: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Accept header
       */
      @header
      accept: "text/powershell";
    },
    void
  >;
}

@@projectedName(DscConfigurations.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(DscConfigurations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DscConfigurations.createOrUpdate::parameters.resource,
  "The create or update parameters for configuration."
);
@@projectedName(DscConfigurations.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(DscConfigurations.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(DscConfigurations.update::parameters.properties,
  "The create or update parameters for configuration."
);
