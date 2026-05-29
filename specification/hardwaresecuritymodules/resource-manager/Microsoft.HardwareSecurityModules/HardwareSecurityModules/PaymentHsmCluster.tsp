import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.HardwareSecurityModules;
/**
 * Resource information with extended details.
 */
@Versioning.added(Versions.v2025_12_01_preview)
model PaymentHsmCluster
  is Azure.ResourceManager.TrackedResource<PaymentHsmClusterProperties> {
  ...ResourceNameParameter<
    Resource = PaymentHsmCluster,
    KeyName = "paymentHsmClusterName",
    SegmentName = "paymentHsmClusters",
    NamePattern = "^[a-zA-Z0-9-]{3,23}$"
  >;

  /**
   * SKU details
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sku?: PaymentHsmClusterSku;
}

@armResourceOperations(#{ allowStaticRoutes: true })
@Versioning.added(Versions.v2025_12_01_preview)
interface PaymentHsmClusters {
  /**
   * Gets the specified Payment HSM Cluster
   */
  get is ArmResourceRead<PaymentHsmCluster>;

  /**
   * Create or Update a Payment HSM Cluster in the specified subscription.
   */
  @Azure.Core.useFinalStateVia("original-uri")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PaymentHsmCluster>;

  /**
   * Update a Payment HSM Cluster in the specified subscription.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    PaymentHsmCluster,
    PatchModel = PaymentHsmClusterPatchParameters
  >;

  /**
   * Deletes the specified Payment HSM Cluster
   */
  delete is ArmResourceDeleteWithoutOkAsync<PaymentHsmCluster>;

  /**
   * The List operation gets information about the Payment HSM Clusters associated with the subscription and within the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    PaymentHsmCluster,
    Parameters = {
      /**
       * The page-continuation token to use with a paged version of this API
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;

  /**
   * The List operation gets information about the Payment HSM Clusters associated with the subscription.
   */
  listBySubscription is ArmListBySubscription<
    PaymentHsmCluster,
    Parameters = {
      /**
       * The page-continuation token to use with a paged version of this API
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
}

@@maxLength(PaymentHsmCluster.name, 23);
@@minLength(PaymentHsmCluster.name, 3);
@@doc(PaymentHsmCluster.name,
  "The name of the Payment HSM Cluster within the specified resource group. Payment HSM Cluster names must be between 3 and 23 characters in length."
);
@@doc(PaymentHsmCluster.properties, "Properties of the Payment HSM Cluster");
@@doc(PaymentHsmClusters.createOrUpdate::parameters.resource,
  "Parameters to create Payment HSM Cluster"
);
@@doc(PaymentHsmClusters.update::parameters.properties,
  "Parameters to create Payment HSM Cluster"
);
