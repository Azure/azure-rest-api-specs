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
@doc("Definition of the configuration type.")
@parentResource(AutomationAccount)
model DscConfiguration is TrackedResource<DscConfigurationProperties> {
  @doc("The configuration name.")
  @path
  @key("configurationName")
  @segment("configurations")
  name: string;

  @doc("Gets or sets the etag of the resource.")
  etag?: string;
}

@armResourceOperations
interface DscConfigurations {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve the configuration identified by configuration name.")
  @operationId("DscConfiguration_Get")
  get is ArmResourceRead<DscConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create the configuration identified by configuration name.")
  @operationId("DscConfiguration_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DscConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create the configuration identified by configuration name.")
  @operationId("DscConfiguration_Update")
  update is ArmCustomPatchSync<
    DscConfiguration,
    DscConfigurationUpdateParameters
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the dsc configuration identified by configuration name.")
  @operationId("DscConfiguration_Delete")
  delete is ArmResourceDeleteSync<DscConfiguration>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a list of configurations.")
  @operationId("DscConfiguration_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<
    DscConfiguration,
    {
      ...BaseParameters<DscConfiguration>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;

      @doc("The number of rows to skip.")
      @query("$skip")
      $skip?: int32;

      @doc("The number of rows to take.")
      @query("$top")
      $top?: int32;

      @doc("Return total rows.")
      @query("$inlinecount")
      $inlinecount?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DscConfiguration_GetContent")
  @doc("Retrieve the configuration script identified by configuration name.")
  // FIXME: DscConfiguration_GetContent could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/configurations/{configurationName}/content")
  @get
  getContent is Azure.Core.Foundations.Operation<
    {
      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;

      @doc("The configuration name.")
      @path
      configurationName: string;

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Accept header")
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
