import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.LabServices;
@doc("Schedule for automatically turning virtual machines in a lab on and off at specified times.")
@parentResource(Lab)
model LabServicesSchedule is ProxyResource<ScheduleProperties> {
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
interface LabServicesSchedules {
  @doc("Returns the properties of a lab Schedule.")
  get is ArmResourceRead<LabServicesSchedule>;
  @doc("Operation to create or update a lab schedule.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<LabServicesSchedule>;
  @doc("Operation to update a lab schedule.")
  update is ArmResourcePatchSync<LabServicesSchedule, ScheduleProperties>;
  @doc("Operation to delete a schedule resource.")
  delete is ArmResourceDeleteAsync<LabServicesSchedule>;
  @doc("Returns a list of all schedules for a lab.")
  listByLab is ArmResourceListByParent<
    LabServicesSchedule,
    {
      ...BaseParameters<LabServicesSchedule>;

      @doc("The filter to apply to the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;
}
