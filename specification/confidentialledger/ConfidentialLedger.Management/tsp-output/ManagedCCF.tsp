import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ConfidentialLedger;
@doc("Managed CCF. Contains the properties of Managed CCF Resource.")
model ManagedCCF is TrackedResource<ManagedCCFProperties> {
  @doc("Name of the Managed CCF")
  @pattern("^[a-zA-Z0-9]")
  @path
  @key("appName")
  @segment("managedCCFs")
  name: string;
}

@armResourceOperations
interface ManagedCCFS {
  @doc("Retrieves the properties of a Managed CCF app.")
  get is ArmResourceRead<ManagedCCF>;
  @doc("Creates a Managed CCF with the specified Managed CCF parameters.")
  create is ArmResourceCreateOrUpdateAsync<ManagedCCF>;
  @doc("Updates properties of Managed CCF")
  update is ArmResourcePatchAsync<ManagedCCF, ManagedCCFProperties>;
  @doc("Deletes an existing Managed CCF.")
  delete is ArmResourceDeleteAsync<ManagedCCF>;
  @doc("Retrieves the properties of all Managed CCF apps.")
  listByResourceGroup is ArmResourceListByParent<
    ManagedCCF,
    {
      ...BaseParameters<ManagedCCF>;

      @doc("The filter to apply on the list operation. eg. $filter=ledgerType eq 'Public'")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Retrieves the properties of all Managed CCF.")
  listBySubscription is ArmListBySubscription<ManagedCCF>;
}
