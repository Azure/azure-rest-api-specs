import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkSecurityPerimeter.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * The NSP resource association resource
 */
@parentResource(NetworkSecurityPerimeter)
model NspAssociation
  is Azure.ResourceManager.ProxyResource<NspAssociationProperties> {
  ...ResourceNameParameter<
    Resource = NspAssociation,
    KeyName = "associationName",
    SegmentName = "resourceAssociations",
    NamePattern = "(^[a-zA-Z0-9]+[a-zA-Z0-9_.-]*[a-zA-Z0-9_]+$)|(^[a-zA-Z0-9]$)"
  >;
}

@armResourceOperations
interface NspAssociations {
  /**
   * Gets the specified NSP association by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterAssociations_Get")
  get is ArmResourceRead<NspAssociation>;

  /**
   * Creates or updates a NSP resource association.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("NetworkSecurityPerimeterAssociations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NspAssociation,
    Response = ArmResourceUpdatedResponse<NspAssociation> | ArmResourceCreatedResponse<NspAssociation> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: NspAssociation;
    })
  >;

  /**
   * Deletes an NSP association resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("NetworkSecurityPerimeterAssociations_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    NspAssociation,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists the NSP resource associations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterAssociations_List")
  list is ArmResourceListByParent<
    NspAssociation,
    Parameters = {
      /**
       * An optional query parameter which specifies the maximum number of records to be returned by the server.
       */
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * SkipToken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  /**
   * Reconcile NSP association
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterAssociations_Reconcile")
  reconcile is ArmResourceActionSync<
    NspAssociation,
    unknown,
    ArmResponse<AnyObject>
  >;
}

@@maxLength(NspAssociation.name, 80);
@@doc(NspAssociation.name, "The name of the NSP association.");
@@doc(NspAssociation.properties, "Properties of the NSP resource association.");
@@doc(NspAssociations.createOrUpdate::parameters.resource,
  "Parameters that hold the NspAssociation resource to be created/updated."
);
@@doc(NspAssociations.reconcile::parameters.body,
  "Parameters for NSP association reconcile"
);
