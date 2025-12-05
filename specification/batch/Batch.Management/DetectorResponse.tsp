import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BatchAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Batch;
/**
 * Contains the information for a detector.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(BatchAccount)
model DetectorResponse extends AzureProxyResource {
  properties?: DetectorResponseProperties;
}

alias DetectorResponseOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider<DetectorResponse>;

    /** The name of the Batch account. */
    @path
    @segment("batchAccounts")
    @key
    @pattern("^[a-zA-Z0-9]+$")
    @maxLength(24)
    @minLength(3)
    accountName: string;
  },
  {
    /** The name of the detector. */
    @path
    @segment("detectors")
    @key
    detectorId: string;
  },
  ErrorType = CloudError
>;

@armResourceOperations
interface DetectorResponses {
  /**
   * Gets information about the given detector for a given Batch account.
   */
  getDetector is DetectorResponseOps.Read<DetectorResponse>;

  /**
   * Gets information about the detectors available for a given Batch account.
   */
  listDetectors is DetectorResponseOps.List<
    DetectorResponse,
    Response = ArmResponse<DetectorListResult>
  >;
}

@@doc(DetectorResponse.properties,
  "The properties associated with the detector."
);
