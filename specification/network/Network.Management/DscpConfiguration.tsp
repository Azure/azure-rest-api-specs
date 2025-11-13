import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Differentiated Services Code Point configuration for any given network interface
 */
model DscpConfiguration
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<DscpConfigurationPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = DscpConfiguration,
    KeyName = "dscpConfigurationName",
    SegmentName = "dscpConfigurations",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface DscpConfigurations {
  /**
   * Gets a DSCP Configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DscpConfiguration_Get")
  get is ArmResourceRead<DscpConfiguration>;

  /**
   * Creates or updates a DSCP Configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DscpConfiguration_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DscpConfiguration,
    LroHeaders = ArmLroLocationHeader<FinalResult = DscpConfiguration> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a DSCP Configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("DscpConfiguration_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    DscpConfiguration,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a DSCP Configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DscpConfiguration_List")
  list is ArmResourceListByParent<DscpConfiguration>;

  /**
   * Gets all dscp configurations in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DscpConfiguration_ListAll")
  listAll is ArmListBySubscription<DscpConfiguration>;
}

@@doc(DscpConfiguration.name, "The name of the resource.");
@@doc(DscpConfiguration.properties, "Properties of the network interface.");
@@doc(DscpConfigurations.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update dscp configuration operation."
);
