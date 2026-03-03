import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A managed instance key.
 */
@parentResource(ManagedInstance)
model ManagedInstanceKey
  is Azure.ResourceManager.ProxyResource<ManagedInstanceKeyProperties> {
  ...ResourceNameParameter<
    Resource = ManagedInstanceKey,
    KeyName = "keyName",
    SegmentName = "keys",
    NamePattern = ""
  >;

  /**
   * Kind of encryption protector. This is metadata used for the Azure portal experience.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  kind?: string;
}

@armResourceOperations
interface ManagedInstanceKeys {
  /**
   * Gets a managed instance key.
   */
  get is ArmResourceRead<ManagedInstanceKey>;

  /**
   * Creates or updates a managed instance key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedInstanceKey,
    Response = ArmResourceUpdatedResponse<ManagedInstanceKey> | ArmResourceCreatedResponse<
      ManagedInstanceKey,
      ArmLroLocationHeader<FinalResult = ManagedInstanceKey> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes the managed instance key with the given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedInstanceKey,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of managed instance keys.
   */
  listByInstance is ArmResourceListByParent<
    ManagedInstanceKey,
    Parameters = {
      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@doc(ManagedInstanceKey.name,
  "The name of the managed instance key to be retrieved."
);
@@doc(ManagedInstanceKey.properties, "Resource properties.");
@@doc(ManagedInstanceKeys.createOrUpdate::parameters.resource,
  "The requested managed instance key resource state."
);
