import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("The security automation resource.")
model SecurityAutomation is TrackedResource<AutomationProperties> {
  @doc("The security automation name.")
  @path
  @key("automationName")
  @segment("automations")
  name: string;
}

@armResourceOperations
interface SecurityAutomations {
  @doc("Retrieves information about the model of a security automation.")
  get is ArmResourceRead<SecurityAutomation>;
  @doc("Creates or updates a security automation. If a security automation is already created and a subsequent request is issued for the same automation id, then it will be updated.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SecurityAutomation>;
  @doc("Deletes a security automation.")
  delete is ArmResourceDeleteSync<SecurityAutomation>;
  @doc("Lists all the security automations in the specified resource group. Use the 'nextLink' property in the response to get the next page of security automations for the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<SecurityAutomation>;
  @doc("Lists all the security automations in the specified subscription. Use the 'nextLink' property in the response to get the next page of security automations for the specified subscription.")
  list is ArmListBySubscription<SecurityAutomation>;
  @doc("Validates the security automation model before create or update. Any validation errors are returned to the client.")
  validate is ArmResourceActionSync<
    SecurityAutomation,
    SecurityAutomation,
    AutomationValidationStatus
  >;
}
