import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Common;

namespace Microsoft.Network;
/**
 * ExpressRouteCircuit resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@Http.Private.includeInapplicableMetadataInPayload(false)
model ExpressRouteCircuit extends Common.Resource {
  properties?: ExpressRouteCircuitPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("circuitName")
  @segment("expressRouteCircuits")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: ExpressRouteCircuitSku;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@armResourceOperations(#{ omitTags: true })
interface ExpressRouteCircuits {
  /**
   * Gets information about the specified express route circuit.
   */
  @tag("ExpressRouteCircuits")
  get is ArmResourceRead<ExpressRouteCircuit, Error = CloudError>;

  /**
   * Creates or updates an express route circuit.
   */
  @tag("ExpressRouteCircuits")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ExpressRouteCircuit,
    Error = CloudError
  >;

  /**
   * Updates an express route circuit tags.
   */
  @tag("ExpressRouteCircuits")
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    ExpressRouteCircuit,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified express route circuit.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ExpressRouteCircuits")
  delete is ArmResourceDeleteWithoutOkAsync<
    ExpressRouteCircuit,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all the express route circuits in a resource group.
   */
  @tag("ExpressRouteCircuits")
  list is ArmResourceListByParent<ExpressRouteCircuit, Error = CloudError>;

  /**
   * Gets all the express route circuits in a subscription.
   */
  @tag("ExpressRouteCircuits")
  listAll is ArmListBySubscription<ExpressRouteCircuit, Error = CloudError>;

  /**
   * Gets all the stats from an express route circuit in a resource group.
   */
  @tag("ExpressRouteCircuitStats")
  @get
  @action("stats")
  getStats is ArmResourceActionSync<
    ExpressRouteCircuit,
    void,
    ArmResponse<ExpressRouteCircuitStats>,
    Error = CloudError
  >;

  /**
   * Retrieves the details of all the link failover tests performed on the express route circuit.
   */
  @tag("ExpressRouteCircuits")
  @action("getCircuitLinkFailoverAllTestsDetails")
  @added(Versions.v2025_07_01)
  getCircuitLinkFailoverAllTestsDetails is ArmResourceActionAsync<
    ExpressRouteCircuit,
    void,
    Response = {
      #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body body: ExpressRouteLinkFailoverAllTestsDetailsList;
    },
    Parameters = {
      /**
       * The type of failover test.
       */
      @query("failoverTestType")
      failoverTestType?: string;

      /**
       * Fetch only the latest tests.
       */
      @query("fetchLatest")
      fetchLatest?: boolean;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = ExpressRouteLinkFailoverAllTestsDetailsList> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Retrieves the details of a particular link failover test performed on the express route circuit.
   */
  @tag("ExpressRouteCircuits")
  @action("getCircuitLinkFailoverSingleTestDetails")
  @added(Versions.v2025_07_01)
  getCircuitLinkFailoverSingleTestDetails is ArmResourceActionAsync<
    ExpressRouteCircuit,
    void,
    Response = {
      #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @body body: ExpressRouteLinkFailoverSingleTestDetailsList;
    },
    Parameters = {
      /**
       * The link type.
       */
      @query("linkType")
      linkType: string;

      /**
       * The circuit test category.
       */
      @query("circuitTestCategory")
      circuitTestCategory: string;

      /**
       * The unique Guid value which identifies the test.
       */
      @query("failoverTestId")
      failoverTestId: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = ExpressRouteLinkFailoverSingleTestDetailsList> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Starts link failover simulation on the express route circuit for the specified link type and test category.
   */
  @tag("ExpressRouteCircuits")
  @action("startCircuitLinkFailoverTest")
  @added(Versions.v2025_07_01)
  startCircuitLinkFailoverTest is ArmResourceActionAsync<
    ExpressRouteCircuit,
    void,
    {
      @body body: stringApplicationJson;
    },
    Parameters = {
      /**
       * The link type.
       */
      @query("linkType")
      linkType: string;

      /**
       * The circuit test category.
       */
      @query("circuitTestCategory")
      circuitTestCategory: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = stringApplicationJson> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Stops link failover simulation on the express route circuit.
   */
  @tag("ExpressRouteCircuits")
  @action("stopCircuitLinkFailoverTest")
  @added(Versions.v2025_07_01)
  stopCircuitLinkFailoverTest is ArmResourceActionAsync<
    ExpressRouteCircuit,
    ExpressRouteLinkFailoverStopApiParameters,
    {
      @body body: stringApplicationJson;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = stringApplicationJson> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;
}

@@doc(ExpressRouteCircuit.name, "The name of express route circuit.");
@@doc(ExpressRouteCircuit.properties,
  "Properties of the express route circuit."
);
@@doc(ExpressRouteCircuits.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update express route circuit operation."
);
@@doc(ExpressRouteCircuits.updateTags::parameters.properties,
  "Parameters supplied to update express route circuit tags."
);
@@doc(ExpressRouteCircuits.stopCircuitLinkFailoverTest::parameters.body,
  "Parameters supplied to stop the link failover simulation on the express route circuit."
);
