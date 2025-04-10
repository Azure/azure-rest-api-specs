import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.LabServices;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ImageUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LabPlanUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LabUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ScheduleUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UserUpdate.properties);

@@clientName(Images.createOrUpdate::parameters.resource, "body");
@@clientName(Images.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Image.properties);

@@clientName(LabPlans.createOrUpdate::parameters.resource, "body");
@@clientName(LabPlans.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(LabPlan.properties);

@@clientName(Labs.createOrUpdate::parameters.resource, "body");
@@clientName(Labs.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Lab.properties);

@@clientName(Schedules.createOrUpdate::parameters.resource, "body");
@@clientName(Schedules.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Schedule.properties);

@@clientName(Users.createOrUpdate::parameters.resource, "body");
@@clientName(Users.update::parameters.properties, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(User.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachine.properties);
