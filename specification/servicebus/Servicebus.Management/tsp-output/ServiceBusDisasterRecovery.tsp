import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceBusNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ServiceBus;
@doc("Single item in List or Get Alias(Disaster Recovery configuration) operation")
@parentResource(ServiceBusNamespace)
model ServiceBusDisasterRecovery
  is ProxyResource<ArmDisasterRecoveryProperties> {
  @doc("The Disaster Recovery configuration name")
  @maxLength(50)
  @minLength(1)
  @key("alias")
  @segment("disasterRecoveryConfigs")
  name: string;
}

@armResourceOperations
interface DisasterRecoveryConfigs {
  // @doc("Retrieves Alias(Disaster Recovery configuration) for primary or secondary namespace")
  // get is ArmResourceRead<ServiceBusDisasterRecovery>;
  // @doc("Creates or updates a new Alias(Disaster Recovery configuration)")
  // createOrUpdate is ArmResourceCreateOrReplaceSync<ServiceBusDisasterRecovery>;
  // @doc("Deletes an Alias(Disaster Recovery configuration)")
  // delete is ArmResourceDeleteSync<ServiceBusDisasterRecovery>;
  @doc("Gets all Alias(Disaster Recovery configurations)")
  list is ArmResourceListByParent<ServiceBusDisasterRecovery>;
  @doc("This operation disables the Disaster Recovery and stops replicating changes from primary to secondary namespaces")
  breakPairing is ArmResourceActionSync<ServiceBusDisasterRecovery, void, void>;
  @doc("Invokes GEO DR failover and reconfigure the alias to point to the secondary namespace")
  failOver is ArmResourceActionSync<
    ServiceBusDisasterRecovery,
    FailoverProperties,
    void
  >;
}