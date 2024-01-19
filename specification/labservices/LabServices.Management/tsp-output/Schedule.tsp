import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.LabServices;
@doc("Schedule for automatically turning virtual machines in a lab on and off at specified times.")
@parentResource(Lab)
model Schedule is ProxyResource<ScheduleProperties> {
  @doc("The name of the schedule that uniquely identifies it within containing lab. Used in resource URIs.")
  @maxLength(100)
  @minLength(1)
  @pattern("^[-\\w\\\\._\\\\(\\\\)]+$")
  @path
  @key("scheduleName")
  @segment("schedules")
  name: string;
}

@armResourceOperations
interface Schedules {
  @doc("Returns the properties of a lab Schedule.")
  get is ArmResourceRead<Schedule>;

  @doc("Operation to create or update a lab schedule.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Schedule>;

  @doc("Operation to update a lab schedule.")
  update is ArmCustomPatchSync<Schedule, ScheduleUpdate>;

  @doc("Operation to delete a schedule resource.")
  delete is ArmResourceDeleteAsync<
    Schedule,
    BaseParameters<Schedule>,
    ArmLroLocationHeader
  >;

  @doc("Returns a list of all schedules for a lab.")
  listByLab is ArmResourceListByParent<
    Schedule,
    {
      ...BaseParameters<Schedule>;

      @doc("The filter to apply to the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@projectedName(Schedules.createOrUpdate::parameters.resource, "json", "body");
@@extension(Schedules.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(Schedules.createOrUpdate::parameters.resource, "The request body.");
@@projectedName(Schedules.update::parameters.properties, "json", "body");
@@extension(Schedules.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(Schedules.update::parameters.properties, "The request body.");
