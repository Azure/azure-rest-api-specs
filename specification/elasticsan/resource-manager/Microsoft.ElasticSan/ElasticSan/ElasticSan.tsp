import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ElasticSan;
/**
 * Response for ElasticSan request.
 */
model ElasticSan
  is Azure.ResourceManager.TrackedResource<ElasticSanProperties, false> {
  ...ResourceNameParameter<
    Resource = ElasticSan,
    KeyName = "elasticSanName",
    SegmentName = "elasticSans",
    NamePattern = "^[A-Za-z0-9]+((-|_)[a-z0-9A-Z]+)*$"
  >;
}

@armResourceOperations
interface ElasticSans {
  /**
   * Get a ElasticSan.
   */
  get is ArmResourceRead<ElasticSan>;

  /**
   * Create ElasticSan.
   */
  create is ArmResourceCreateOrReplaceAsync<
    ElasticSan,
    LroHeaders = ArmLroLocationHeader<FinalResult = ElasticSan> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update a Elastic San.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<ElasticSan, PatchModel = ElasticSanUpdate>;

  /**
   * Delete a Elastic San.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    ElasticSan,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of ElasticSan in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ElasticSan,
    Response = ArmResponse<ElasticSanList>
  >;

  /**
   * Gets a list of ElasticSans in a subscription
   */
  listBySubscription is ArmListBySubscription<
    ElasticSan,
    Response = ArmResponse<ElasticSanList>
  >;

  /**
   * Gets the private link resources that need to be created for a elastic San.
   */
  @get
  @action("privateLinkResources")
  listByElasticSan is ArmResourceActionSync<
    ElasticSan,
    void,
    ArmResponse<PrivateLinkResourceListResult>
  >;
}

@@maxLength(ElasticSan.name, 24);
@@minLength(ElasticSan.name, 3);
@@doc(ElasticSan.name, "The name of the ElasticSan.");
@@doc(ElasticSan.properties, "Properties of ElasticSan.");
@@doc(ElasticSans.create::parameters.resource, "Elastic San object.");
@@doc(ElasticSans.update::parameters.properties, "Elastic San object.");
