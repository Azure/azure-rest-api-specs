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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkSecurityPerimeter)
@Http.Private.includeInapplicableMetadataInPayload(false)
@parentResource(NetworkSecurityPerimeter)
model NspAssociation extends CommonProxyResource {
  /**
   * Properties of the NSP association.
   */
  properties?: NspAssociationProperties;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("associationName")
  @segment("resourceAssociations")
  @pattern("(^[a-zA-Z0-9]+[a-zA-Z0-9_.-]*[a-zA-Z0-9_]+$)|(^[a-zA-Z0-9]$)")
  name: string;
}

@@doc(NspAssociation.name, "The name of the resource");

@armResourceOperations
interface NspAssociations {
  /**
   * Gets the specified NSP association by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkSecurityPerimeterAssociations_Get")
  get is ArmResourceRead<NspAssociation, Error = CloudError>;

  /**
   * Creates or updates a NSP resource association.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkSecurityPerimeterAssociations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NspAssociation,
    Response = ArmResourceUpdatedResponse<NspAssociation> | ArmResourceCreatedResponse<NspAssociation> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader> &
      Azure.Core.Foundations.RetryAfterHeader & {
        @bodyRoot
        _: NspAssociation;
      }),
    Error = CloudError
  >;

  /**
   * Deletes an NSP association resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkSecurityPerimeterAssociations_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    NspAssociation,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists the NSP resource associations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
    },
    Response = NspAssociationsListResult,
    Error = CloudError
  >;

  /**
   * Reconcile NSP association
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("NetworkSecurityPerimeterAssociations_Reconcile")
  reconcile is ArmResourceActionSync<
    NspAssociation,
    unknown,
    ArmResponse<unknown>,
    Error = CloudError
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
