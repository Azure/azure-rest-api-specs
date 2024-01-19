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

namespace Microsoft.PowerBIDedicated;
@doc("Represents an instance of an auto scale v-core resource.")
model AutoScaleVCore is ProxyResource<AutoScaleVCoreProperties> {
  @doc("The name of the auto scale v-core. It must be a minimum of 3 characters, and a maximum of 63.")
  @maxLength(63)
  @minLength(3)
  @pattern("^[-a-zA-Z0-9_]+$")
  @path
  @key("vcoreName")
  @segment("autoScaleVCores")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface AutoScaleVCores {
  @doc("Gets details about the specified auto scale v-core.")
  get is ArmResourceRead<AutoScaleVCore>;

  @doc("Provisions the specified auto scale v-core based on the configuration specified in the request.")
  create is ArmResourceCreateOrReplaceSync<AutoScaleVCore>;

  @doc("Updates the current state of the specified auto scale v-core.")
  update is ArmCustomPatchSync<AutoScaleVCore, AutoScaleVCoreUpdateParameters>;

  @doc("Deletes the specified auto scale v-core.")
  delete is ArmResourceDeleteSync<AutoScaleVCore>;

  @doc("Gets all the auto scale v-cores for the given resource group.")
  listByResourceGroup is ArmResourceListByParent<AutoScaleVCore>;

  @doc("Lists all the auto scale v-cores for the given subscription.")
  listBySubscription is ArmListBySubscription<AutoScaleVCore>;
}

@@projectedName(AutoScaleVCores.create::parameters.resource,
  "json",
  "vCoreParameters"
);
@@extension(AutoScaleVCores.create::parameters.resource,
  "x-ms-client-name",
  "vCoreParameters"
);
@@doc(AutoScaleVCores.create::parameters.resource,
  "Contains the information used to provision the auto scale v-core."
);
@@projectedName(AutoScaleVCores.update::parameters.properties,
  "json",
  "vCoreUpdateParameters"
);
@@extension(AutoScaleVCores.update::parameters.properties,
  "x-ms-client-name",
  "vCoreUpdateParameters"
);
@@doc(AutoScaleVCores.update::parameters.properties,
  "Request object that contains the updated information for the auto scale v-core."
);
