import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./occurrencemodels.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

namespace Microsoft.ComputeSchedule;

@armResourceOperations
interface Occurrences {
  get is ArmResourceRead<Occurrence>;
  listByAutoAction is ArmResourceListByParent<Occurrence>;

  @segment("resources")
  getResources is ArmResourceListActionSync<Occurrence, OccurrenceResource>;
  cancel is ArmResourceActionNoContentSync<Occurrence, OccurrenceResource[]>;
  delay is ArmResourceActionNoContentSync<Occurrence, DelayRequest>;
}