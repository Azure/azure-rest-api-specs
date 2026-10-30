import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./AmlFilesystem.tsp";
import "./AutoReleaseModels.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.StorageCache;

/** An AutoRelease job containing policies that release eligible archived files. */
@added(Versions.v2027_01_01)
@parentResource(AmlFilesystem)
model AutoReleaseJob
  is Azure.ResourceManager.ProxyResource<AutoReleaseJobProperties> {
  ...ResourceNameParameter<
    Resource = AutoReleaseJob,
    KeyName = "autoReleaseJobName",
    SegmentName = "autoReleaseJobs",
    NamePattern = "^[0-9a-zA-Z][-0-9a-zA-Z_]{0,78}[0-9a-zA-Z]$"
  >;
}

/** Operations for managing AutoRelease jobs. */
@added(Versions.v2027_01_01)
@armResourceOperations(#{ omitTags: true })
interface AutoReleaseJobs {
  /** Returns an AutoRelease job. */
  @tag("autoReleaseJobs")
  get is ArmResourceRead<AutoReleaseJob, Error = ErrorResponse>;

  /** Creates an AutoRelease job or updates only its administrative status. */
  @tag("autoReleaseJobs")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AutoReleaseJob,
    Error = ErrorResponse
  >;

  /** Updates the supplied writable properties of an AutoRelease job. */
  @tag("autoReleaseJobs")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AutoReleaseJob,
    PatchModel = AutoReleaseJobUpdate,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = AutoReleaseJob> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponse
  >;

  /** Disables AutoRelease when necessary and deletes the retained job resource. */
  @tag("autoReleaseJobs")
  delete is ArmResourceDeleteWithoutOkAsync<
    AutoReleaseJob,
    Response = ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse,
    Error = ErrorResponse
  >;

  /** Returns all retained AutoRelease jobs under an AML file system. */
  @tag("autoReleaseJobs")
  listByAmlFilesystem is ArmResourceListByParent<
    AutoReleaseJob,
    Response = ArmResponse<AutoReleaseJobsListResult>,
    Error = ErrorResponse
  >;
}

@@maxLength(AutoReleaseJob.name, 80);
@@minLength(AutoReleaseJob.name, 2);
@@doc(AutoReleaseJob.name,
  "Name for the AutoRelease job. Allows alphanumerics, underscores, and hyphens. Start and end with alphanumeric."
);
@@doc(AutoReleaseJob.properties, "Properties of the AutoRelease job.");
@@doc(AutoReleaseJobs.createOrUpdate::parameters.resource,
  "Object containing the complete policy set when creating an AutoRelease job. For an existing job, only adminStatus can be modified; when omitted, the service applies Enable. If read-only properties are included, they must match the existing values of those properties."
);
@@doc(AutoReleaseJobs.update::parameters.properties,
  "Object containing the administrative status to update."
);
