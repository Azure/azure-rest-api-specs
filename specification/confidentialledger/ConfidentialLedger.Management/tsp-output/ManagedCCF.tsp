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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieves the properties of a Managed CCF app.")
  @operationId("ManagedCCF_Get")
  get is ArmResourceRead<ManagedCCF>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates a Managed CCF with the specified Managed CCF parameters.")
  @operationId("ManagedCCF_Create")
  create is ArmResourceCreateOrUpdateAsync<
    ManagedCCF,
    BaseParameters<ManagedCCF>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates properties of Managed CCF")
  @operationId("ManagedCCF_Update")
  update is ArmCustomPatchAsync<ManagedCCF, ManagedCCF>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an existing Managed CCF.")
  @operationId("ManagedCCF_Delete")
  delete is ArmResourceDeleteAsync<ManagedCCF>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieves the properties of all Managed CCF apps.")
  @operationId("ManagedCCF_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    ManagedCCF,
    {
      ...BaseParameters<ManagedCCF>;

      @doc("The filter to apply on the list operation. eg. $filter=ledgerType eq 'Public'")
      @query("$filter")
      $filter?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieves the properties of all Managed CCF.")
  @operationId("ManagedCCF_ListBySubscription")
  listBySubscription is ArmListBySubscription<ManagedCCF>;
}

@@projectedName(ManagedCCFS.create::parameters.resource, "json", "ManagedCCF");
@@extension(ManagedCCFS.create::parameters.resource,
  "x-ms-client-name",
  "ManagedCCF"
);
@@doc(ManagedCCFS.create::parameters.resource,
  "Managed CCF Create Request Body"
);
@@projectedName(ManagedCCFS.update::parameters.properties,
  "json",
  "ManagedCCF"
);
@@extension(ManagedCCFS.update::parameters.properties,
  "x-ms-client-name",
  "ManagedCCF"
);
@@doc(ManagedCCFS.update::parameters.properties,
  "Request body for Updating Managed CCF App"
);
