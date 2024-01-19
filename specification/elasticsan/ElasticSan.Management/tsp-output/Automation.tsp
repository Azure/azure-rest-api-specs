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

namespace Microsoft.Security;
@doc("The security automation resource.")
model Automation is TrackedResource<AutomationProperties> {
  @doc("The security automation name.")
  @path
  @key("automationName")
  @segment("automations")
  name: string;
}

@armResourceOperations
interface Automations {
  @doc("Retrieves information about the model of a security automation.")
  get is ArmResourceRead<Automation>;

  @doc("Creates or updates a security automation. If a security automation is already created and a subsequent request is issued for the same automation id, then it will be updated.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Automation>;

  @doc("Deletes a security automation.")
  delete is ArmResourceDeleteSync<Automation>;

  @doc("Lists all the security automations in the specified resource group. Use the 'nextLink' property in the response to get the next page of security automations for the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<Automation>;

  @doc("Lists all the security automations in the specified subscription. Use the 'nextLink' property in the response to get the next page of security automations for the specified subscription.")
  list is ArmListBySubscription<Automation>;

  @doc("Validates the security automation model before create or update. Any validation errors are returned to the client.")
  validate is ArmResourceActionSync<
    Automation,
    Automation,
    AutomationValidationStatus
  >;
}

@@projectedName(Automations.createOrUpdate::parameters.resource,
  "json",
  "Automation"
);
@@extension(Automations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "Automation"
);
@@doc(Automations.createOrUpdate::parameters.resource,
  "The security automation resource"
);
@@projectedName(Automations.validate::parameters.body, "json", "Automation");
@@extension(Automations.validate::parameters.body,
  "x-ms-client-name",
  "Automation"
);
@@doc(Automations.validate::parameters.body,
  "The security automation resource"
);
