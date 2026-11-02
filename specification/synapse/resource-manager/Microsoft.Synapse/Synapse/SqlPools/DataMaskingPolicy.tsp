import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;

@singleton("default")
@parentResource(SqlPool)
model DataMaskingPolicy
  is Azure.ResourceManager.ProxyResource<DataMaskingPolicyProperties> {
  ...ResourceNameParameter<
    Resource = DataMaskingPolicy,
    KeyName = "dataMaskingPolicy",
    SegmentName = "dataMaskingPolicies",
    NamePattern = ""
  >;

  /**
   * The location of the data masking policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * The kind of data masking policy. Metadata, used for Azure portal.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  kind?: string;

  /**
   * Fully qualified resource ID of the sql pool
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  managedBy?: string;
}

@armResourceOperations
interface DataMaskingPolicies {
  /**
   * Gets a Sql pool data masking policy.
   */
  get is ArmResourceRead<DataMaskingPolicy>;

  /**
   * Creates or updates a Sql pool data masking policy
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DataMaskingPolicy,
    Response = ArmResourceUpdatedResponse<DataMaskingPolicy>
  >;
}

@@doc(DataMaskingPolicy.name, "");
@@doc(
  DataMaskingPolicy.properties,
  "The properties of the data masking policy."
);
@@doc(
  DataMaskingPolicies.createOrUpdate::parameters.resource,
  "Parameters for creating or updating a data masking policy."
);
