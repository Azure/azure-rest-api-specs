import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SBNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ServiceBus;
@doc("Single item in List or Get Alias(Disaster Recovery configuration) operation")
@parentResource(SBNamespace)
model ArmDisasterRecovery is ProxyResource<ArmDisasterRecoveryProperties> {
  @doc("The Disaster Recovery configuration name")
  @maxLength(50)
  @minLength(1)
  @path
  @key("alias")
  @segment("disasterRecoveryConfigs")
  name: string;
}

@armResourceOperations
interface ArmDisasterRecoveries {
  @doc("Retrieves Alias(Disaster Recovery configuration) for primary or secondary namespace")
  get is ArmResourceRead<ArmDisasterRecovery>;
  @doc("Creates or updates a new Alias(Disaster Recovery configuration)")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ArmDisasterRecovery>;
  @doc("Deletes an Alias(Disaster Recovery configuration)")
  delete is ArmResourceDeleteSync<ArmDisasterRecovery>;
  @doc("Gets all Alias(Disaster Recovery configurations)")
  list is ArmResourceListByParent<ArmDisasterRecovery>;
  @doc("This operation disables the Disaster Recovery and stops replicating changes from primary to secondary namespaces")
  breakPairing is ArmResourceActionSync<ArmDisasterRecovery, {}, {}>;
  @doc("Invokes GEO DR failover and reconfigure the alias to point to the secondary namespace")
  failOver is ArmResourceActionSync<
    ArmDisasterRecovery,
    FailoverProperties,
    {}
  >;
}
