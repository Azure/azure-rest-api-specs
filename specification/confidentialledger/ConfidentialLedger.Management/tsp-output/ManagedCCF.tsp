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
/**
 * Managed CCF. Contains the properties of Managed CCF Resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ManagedCCFProperties)
model ManagedCCF extends TrackedResourceBase {
  /**
   * Name of the Managed CCF
   */
  @pattern("^[a-zA-Z0-9]")
  @path
  @key("appName")
  @segment("managedCCFs")
  @visibility("read")
  name: string;

  /**
   * Properties of Managed CCF Resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ManagedCCFProperties;
}

@armResourceOperations
interface ManagedCCFS {
  /**
   * Retrieves the properties of a Managed CCF app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedCCF_Get")
  get is ArmResourceRead<ManagedCCF>;

  /**
   * Creates a Managed CCF with the specified Managed CCF parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedCCF_Create")
  create is ArmResourceCreateOrReplaceAsync<
    ManagedCCF,
    BaseParameters<ManagedCCF>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates properties of Managed CCF
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("ManagedCCF_Update")
  update is ArmCustomPatchAsync<ManagedCCF, ManagedCCF>;

  /**
   * Deletes an existing Managed CCF.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedCCF_Delete")
  delete is ArmResourceDeleteAsync<ManagedCCF>;

  /**
   * Retrieves the properties of all Managed CCF apps.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedCCF_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    ManagedCCF,
    {
      ...BaseParameters<ManagedCCF>;

      /**
       * The filter to apply on the list operation. eg. $filter=ledgerType eq 'Public'
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Retrieves the properties of all Managed CCF.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
