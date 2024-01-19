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
@doc("Software update configuration properties.")
@parentResource(AutomationAccount)
model SoftwareUpdateConfiguration
  is ProxyResource<SoftwareUpdateConfigurationProperties> {
  @doc("The name of the software update configuration to be created.")
  @path
  @key("softwareUpdateConfigurationName")
  @segment("softwareUpdateConfigurations")
  name: string;
}

@armResourceOperations
interface SoftwareUpdateConfigurations {
  @doc("Get a single software update configuration by name.")
  getByName is ArmResourceRead<
    SoftwareUpdateConfiguration,
    {
      ...BaseParameters<SoftwareUpdateConfiguration>;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;
    }
  >;

  @doc("Create a new software update configuration with the name given in the URI.")
  create is ArmResourceCreateOrReplaceSync<
    SoftwareUpdateConfiguration,
    {
      ...BaseParameters<SoftwareUpdateConfiguration>;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;
    }
  >;

  @doc("delete a specific software update configuration.")
  delete is ArmResourceDeleteSync<
    SoftwareUpdateConfiguration,
    {
      ...BaseParameters<SoftwareUpdateConfiguration>;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;
    }
  >;

  @doc("Get all software update configurations for the account.")
  list is ArmResourceListByParent<
    SoftwareUpdateConfiguration,
    {
      ...BaseParameters<SoftwareUpdateConfiguration>;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@projectedName(SoftwareUpdateConfigurations.create::parameters.resource,
  "json",
  "parameters"
);
@@extension(SoftwareUpdateConfigurations.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SoftwareUpdateConfigurations.create::parameters.resource,
  "Request body."
);
