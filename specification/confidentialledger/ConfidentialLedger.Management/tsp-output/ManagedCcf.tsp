import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ConfidentialLedger;
@doc("Managed CCF. Contains the properties of Managed CCF Resource.")
model ManagedCcf is TrackedResource<ManagedCCFProperties> {
  @doc("Name of the Managed CCF")
  @pattern("^[a-zA-Z0-9]")
  @path
  @key("appName")
  @segment("managedCCFs")
  name: string;
}

@armResourceOperations
interface ManagedCcfs {
  @doc("Retrieves the properties of a Managed CCF app.")
  get is ArmResourceRead<ManagedCcf>;
  @doc("Creates a Managed CCF with the specified Managed CCF parameters.")
  create is ArmResourceCreateOrUpdateAsync<ManagedCcf>;
  @doc("Updates properties of Managed CCF")
  update is ArmResourcePatchAsync<ManagedCcf, ManagedCCFProperties>;
  @doc("Deletes an existing Managed CCF.")
  delete is ArmResourceDeleteAsync<ManagedCcf>;
  @doc("Retrieves the properties of all Managed CCF apps.")
  listByResourceGroup is ArmResourceListByParent<
    ManagedCcf,
    {
      ...BaseParameters<ManagedCcf>;

      @doc("The filter to apply on the list operation. eg. $filter=ledgerType eq 'Public'")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Retrieves the properties of all Managed CCF.")
  listBySubscription is ArmListBySubscription<ManagedCcf>;
}
