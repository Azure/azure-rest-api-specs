import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Managed certificates used for Custom Domain bindings of Container Apps in a Managed Environment
 */
@parentResource(ManagedEnvironment)
model ManagedCertificate
  is Azure.ResourceManager.TrackedResource<ManagedCertificateProperties> {
  ...ResourceNameParameter<
    Resource = ManagedCertificate,
    KeyName = "managedCertificateName",
    SegmentName = "managedCertificates",
    NamePattern = ""
  >;
}

alias ManagedCertificateOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the Managed Environment. */
    @path
    @segment("managedEnvironments")
    @key
    environmentName: string;
  },
  {
    /** Name of the Managed Certificate. */
    @path
    @segment("managedCertificates")
    @key
    managedCertificateName: string;
  }
>;

@armResourceOperations
@tag("ManagedEnvironments")
@tag("ManagedCertificates")
interface ManagedCertificates {
  /**
   * Get the specified Managed Certificate.
   */
  @summary("Get the specified Managed Certificate.")
  get is ArmResourceRead<ManagedCertificate>;

  /**
   * Create or Update a Managed Certificate.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create or Update a Managed Certificate.")
  // createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedCertificate>;
  createOrUpdate is ManagedCertificateOps.CreateOrUpdateAsync<
    ManagedCertificate,
    Response = ArmResourceUpdatedResponse<ManagedCertificate> | ArmResourceCreatedResponse<
      ManagedCertificate,
      ArmAsyncOperationHeader<FinalResult = ManagedCertificate> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ManagedCertificateBadRequestError,
    OptionalRequestBody = true
  >;

  /**
   * Patches a managed certificate. Oly patching of tags is supported
   */
  @patch(#{ implicitOptionality: false })
  @summary("Update tags of a managed certificate")
  update is ArmCustomPatchSync<
    ManagedCertificate,
    PatchModel = ManagedCertificatePatch
  >;

  /**
   * Deletes the specified Managed Certificate.
   */
  @summary("Deletes the specified Managed Certificate.")
  delete is ArmResourceDeleteSync<ManagedCertificate>;

  /**
   * Get the Managed Certificates in a given managed environment.
   */
  @summary("Get the Managed Certificates in a given managed environment.")
  list is ArmResourceListByParent<
    ManagedCertificate,
    Response = ArmResponse<ManagedCertificateCollection>
  >;
}

@@doc(ManagedCertificate.name, "Name of the Managed Certificate.");
@@doc(ManagedCertificate.properties,
  "Certificate resource specific properties"
);
@@doc(ManagedCertificates.createOrUpdate::parameters.resource,
  "Managed Certificate to be created or updated"
);
@@doc(ManagedCertificates.update::parameters.properties,
  "Properties of a managed certificate that need to be updated"
);
