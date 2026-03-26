## Swagger Changes

### Changes for `x-ms-odata`

| Path                                                                                                              | Change Type | Value                                                 |
| ----------------------------------------------------------------------------------------------------------------- | ----------- | ----------------------------------------------------- |
| `paths['/{scope}/providers/microsoft.Authorization/roleAssignmentScheduleInstances'].get['x-ms-odata__deleted']`  | deleted     | `#/definitions/RoleAssignmentScheduleInstanceFilter`  |
| `paths['/{scope}/providers/microsoft.Authorization/roleAssignmentScheduleRequests'].get['x-ms-odata__deleted']`   | deleted     | `#/definitions/RoleAssignmentScheduleRequestFilter`   |
| `paths['/{scope}/providers/microsoft.Authorization/roleAssignmentSchedules'].get['x-ms-odata__deleted']`          | deleted     | `#/definitions/RoleAssignmentScheduleFilter`          |
| `paths['/{scope}/providers/microsoft.Authorization/roleEligibilityScheduleInstances'].get['x-ms-odata__deleted']` | deleted     | `#/definitions/RoleEligibilityScheduleInstanceFilter` |
| `paths['/{scope}/providers/microsoft.Authorization/roleEligibilityScheduleRequests'].get['x-ms-odata__deleted']`  | deleted     | `#/definitions/RoleEligibilityScheduleRequestFilter`  |
| `paths['/{scope}/providers/microsoft.Authorization/roleEligibilitySchedules'].get['x-ms-odata__deleted']`         | deleted     | `#/definitions/RoleEligibilityScheduleFilter`         |

### Changes for `RoleAssignmentScheduleFilter`

| Path                                                | Change Type | Value                                                                                                     |
| --------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.RoleAssignmentScheduleFilter__deleted` | deleted     | `{"type":"object","description":"Role assignment schedule filter","properties":{"principalId":{"type"...` |

### Changes for `RoleAssignmentScheduleInstanceFilter`

| Path                                                        | Change Type | Value                                                                                                     |
| ----------------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.RoleAssignmentScheduleInstanceFilter__deleted` | deleted     | `{"type":"object","description":"Role assignment schedule instance filter","properties":{"principalId...` |

### Changes for `RoleAssignmentScheduleRequestFilter`

| Path                                                       | Change Type | Value                                                                                                     |
| ---------------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.RoleAssignmentScheduleRequestFilter__deleted` | deleted     | `{"type":"object","description":"Role assignment schedule request filter","properties":{"principalId"...` |

### Changes for `RoleEligibilityScheduleFilter`

| Path                                                 | Change Type | Value                                                                                                     |
| ---------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.RoleEligibilityScheduleFilter__deleted` | deleted     | `{"type":"object","description":"Role eligibility schedule filter","properties":{"principalId":{"type...` |

### Changes for `RoleEligibilityScheduleInstanceFilter`

| Path                                                         | Change Type | Value                                                                                                     |
| ------------------------------------------------------------ | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.RoleEligibilityScheduleInstanceFilter__deleted` | deleted     | `{"type":"object","description":"Role eligibility schedule instance filter","properties":{"principalI...` |

### Changes for `RoleEligibilityScheduleRequestFilter`

| Path                                                        | Change Type | Value                                                                                                     |
| ----------------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.RoleEligibilityScheduleRequestFilter__deleted` | deleted     | `{"type":"object","description":"Role eligibility schedule request filter","properties":{"principalId...` |

### Changes for `ExpandedPropertiesPrincipal`

| Path                                             | Change Type | Value                                                                                                     |
| ------------------------------------------------ | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.ExpandedPropertiesPrincipal__added` | added       | `{"type":"object","description":"Details of the principal","properties":{"id":{"type":"string","descr...` |

### Changes for `ExpandedPropertiesRoleDefinition`

| Path                                                  | Change Type | Value                                                                                                     |
| ----------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.ExpandedPropertiesRoleDefinition__added` | added       | `{"type":"object","description":"Details of role definition","properties":{"id":{"type":"string","des...` |

### Changes for `ExpandedPropertiesScope`

| Path                                         | Change Type | Value                                                                                                     |
| -------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.ExpandedPropertiesScope__added` | added       | `{"type":"object","description":"Details of the resource scope","properties":{"id":{"type":"string","...` |

### Changes for `PolicyAssignmentPropertiesPolicy`

| Path                                                  | Change Type | Value                                                                                                     |
| ----------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.PolicyAssignmentPropertiesPolicy__added` | added       | `{"type":"object","description":"Details of the policy","properties":{"id":{"type":"string","descript...` |

### Changes for `PolicyAssignmentPropertiesRoleDefinition`

| Path                                                          | Change Type | Value                                                                                                     |
| ------------------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.PolicyAssignmentPropertiesRoleDefinition__added` | added       | `{"type":"object","description":"Details of role definition","properties":{"id":{"type":"string","des...` |

### Changes for `PolicyAssignmentPropertiesScope`

| Path                                                 | Change Type | Value                                                                                                     |
| ---------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.PolicyAssignmentPropertiesScope__added` | added       | `{"type":"object","description":"Details of the resource scope","properties":{"id":{"type":"string","...` |

### Changes for `PolicyPropertiesScope`

| Path                                       | Change Type | Value                                                                                                     |
| ------------------------------------------ | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.PolicyPropertiesScope__added` | added       | `{"type":"object","description":"Details of the resource scope","properties":{"id":{"type":"string","...` |

### Changes for `RoleAssignmentScheduleRequestPropertiesScheduleInfo`

| Path                                                                     | Change Type | Value                                                                                                     |
| ------------------------------------------------------------------------ | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.RoleAssignmentScheduleRequestPropertiesScheduleInfo__added` | added       | `{"type":"object","description":"Schedule info of the role assignment schedule","properties":{"startD...` |

### Changes for `RoleAssignmentScheduleRequestPropertiesScheduleInfoExpiration`

| Path                                                                               | Change Type | Value                                                                                                     |
| ---------------------------------------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.RoleAssignmentScheduleRequestPropertiesScheduleInfoExpiration__added` | added       | `{"type":"object","description":"Expiration of the role assignment schedule","properties":{"type":{"t...` |

### Changes for `RoleAssignmentScheduleRequestPropertiesTicketInfo`

| Path                                                                   | Change Type | Value                                                                                                     |
| ---------------------------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.RoleAssignmentScheduleRequestPropertiesTicketInfo__added` | added       | `{"type":"object","description":"Ticket Info of the role assignment","properties":{"ticketNumber":{"t...` |

### Changes for `RoleEligibilityScheduleRequestPropertiesScheduleInfo`

| Path                                                                      | Change Type | Value                                                                                                     |
| ------------------------------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.RoleEligibilityScheduleRequestPropertiesScheduleInfo__added` | added       | `{"type":"object","description":"Schedule info of the role eligibility schedule","properties":{"start...` |

### Changes for `RoleEligibilityScheduleRequestPropertiesScheduleInfoExpiration`

| Path                                                                                | Change Type | Value                                                                                                     |
| ----------------------------------------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.RoleEligibilityScheduleRequestPropertiesScheduleInfoExpiration__added` | added       | `{"type":"object","description":"Expiration of the role eligibility schedule","properties":{"type":{"...` |

### Changes for `RoleEligibilityScheduleRequestPropertiesTicketInfo`

| Path                                                                    | Change Type | Value                                                                                                     |
| ----------------------------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.RoleEligibilityScheduleRequestPropertiesTicketInfo__added` | added       | `{"type":"object","description":"Ticket Info of the role eligibility","properties":{"ticketNumber":{"...` |

### Changes for `description`

| Path                                                                                      | Change Type | Value                                     |
| ----------------------------------------------------------------------------------------- | ----------- | ----------------------------------------- |
| `definitions.CloudError.properties.error.description__added`                              | added       | `An error response from the service.`     |
| `definitions.RoleManagementPolicyProperties.properties.lastModifiedBy.description__added` | added       | `The name of the entity last modified it` |

### Changes for `required`

| Path                                                                    | Change Type | Value       |
| ----------------------------------------------------------------------- | ----------- | ----------- |
| `definitions.EligibleChildResourcesListResult.required__added`          | added       | `["value"]` |
| `definitions.RoleAssignmentScheduleInstanceListResult.required__added`  | added       | `["value"]` |
| `definitions.RoleAssignmentScheduleListResult.required__added`          | added       | `["value"]` |
| `definitions.RoleAssignmentScheduleRequestListResult.required__added`   | added       | `["value"]` |
| `definitions.RoleEligibilityScheduleInstanceListResult.required__added` | added       | `["value"]` |
| `definitions.RoleEligibilityScheduleListResult.required__added`         | added       | `["value"]` |
| `definitions.RoleEligibilityScheduleRequestListResult.required__added`  | added       | `["value"]` |
| `definitions.RoleManagementPolicyAssignmentListResult.required__added`  | added       | `["value"]` |
| `definitions.RoleManagementPolicyListResult.required__added`            | added       | `["value"]` |

### Changes for `type`

| Path                                                                                                       | Change Type | Value                                                                                            |
| ---------------------------------------------------------------------------------------------------------- | ----------- | ------------------------------------------------------------------------------------------------ |
| `definitions.ExpandedProperties.properties.principal.type__deleted`                                        | deleted     | `object`                                                                                         |
| `definitions.ExpandedProperties.properties.roleDefinition.type__deleted`                                   | deleted     | `object`                                                                                         |
| `definitions.ExpandedProperties.properties.scope.type__deleted`                                            | deleted     | `object`                                                                                         |
| `definitions.PolicyAssignmentProperties.properties.policy.type__deleted`                                   | deleted     | `object`                                                                                         |
| `definitions.PolicyAssignmentProperties.properties.roleDefinition.type__deleted`                           | deleted     | `object`                                                                                         |
| `definitions.PolicyAssignmentProperties.properties.scope.type__deleted`                                    | deleted     | `object`                                                                                         |
| `definitions.PolicyProperties.properties.scope.type__deleted`                                              | deleted     | `object`                                                                                         |
| `definitions.RoleAssignmentSchedule.properties.type__deleted`                                              | deleted     | `{"type":"string","description":"The role assignment schedule type.","readOnly":true}`           |
| `definitions.RoleAssignmentScheduleInstance.properties.type__deleted`                                      | deleted     | `{"type":"string","description":"The role assignment schedule instance type.","readOnly":true}`  |
| `definitions.RoleAssignmentScheduleInstanceProperties.properties.expandedProperties.type__deleted`         | deleted     | `object`                                                                                         |
| `definitions.RoleAssignmentScheduleProperties.properties.expandedProperties.type__deleted`                 | deleted     | `object`                                                                                         |
| `definitions.RoleAssignmentScheduleRequest.properties.type__deleted`                                       | deleted     | `{"type":"string","description":"The role assignment schedule request type.","readOnly":true}`   |
| `definitions.RoleAssignmentScheduleRequestProperties.properties.expandedProperties.type__deleted`          | deleted     | `object`                                                                                         |
| `definitions.RoleAssignmentScheduleRequestProperties.properties.scheduleInfo.type__deleted`                | deleted     | `object`                                                                                         |
| `definitions.RoleAssignmentScheduleRequestProperties.properties.ticketInfo.type__deleted`                  | deleted     | `object`                                                                                         |
| `definitions.RoleEligibilitySchedule.properties.type__deleted`                                             | deleted     | `{"type":"string","description":"The role eligibility schedule type.","readOnly":true}`          |
| `definitions.RoleEligibilityScheduleInstance.properties.type__deleted`                                     | deleted     | `{"type":"string","description":"The role eligibility schedule instance type.","readOnly":true}` |
| `definitions.RoleEligibilityScheduleInstanceProperties.properties.expandedProperties.type__deleted`        | deleted     | `object`                                                                                         |
| `definitions.RoleEligibilityScheduleProperties.properties.expandedProperties.type__deleted`                | deleted     | `object`                                                                                         |
| `definitions.RoleEligibilityScheduleRequest.properties.type__deleted`                                      | deleted     | `{"type":"string","description":"The role eligibility schedule request type.","readOnly":true}`  |
| `definitions.RoleEligibilityScheduleRequestProperties.properties.expandedProperties.type__deleted`         | deleted     | `object`                                                                                         |
| `definitions.RoleEligibilityScheduleRequestProperties.properties.scheduleInfo.type__deleted`               | deleted     | `object`                                                                                         |
| `definitions.RoleEligibilityScheduleRequestProperties.properties.ticketInfo.type__deleted`                 | deleted     | `object`                                                                                         |
| `definitions.RoleManagementPolicy.properties.type__deleted`                                                | deleted     | `{"type":"string","description":"The role management policy type.","readOnly":true}`             |
| `definitions.RoleManagementPolicyAssignment.properties.type__deleted`                                      | deleted     | `{"type":"string","description":"The role management policy type.","readOnly":true}`             |
| `definitions.RoleManagementPolicyAssignmentProperties.properties.policyAssignmentProperties.type__deleted` | deleted     | `object`                                                                                         |
| `definitions.RoleManagementPolicyProperties.properties.policyProperties.type__deleted`                     | deleted     | `object`                                                                                         |

### Changes for `properties`

| Path                                                                                               | Change Type | Value                                                                                                     |
| -------------------------------------------------------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `definitions.ExpandedProperties.properties.principal.properties__deleted`                          | deleted     | `{"id":{"type":"string","description":"Id of the principal"},"displayName":{"type":"string","descript...` |
| `definitions.ExpandedProperties.properties.roleDefinition.properties__deleted`                     | deleted     | `{"id":{"type":"string","description":"Id of the role definition"},"displayName":{"type":"string","de...` |
| `definitions.ExpandedProperties.properties.scope.properties__deleted`                              | deleted     | `{"id":{"type":"string","description":"Scope id of the resource"},"displayName":{"type":"string","des...` |
| `definitions.PolicyAssignmentProperties.properties.policy.properties__deleted`                     | deleted     | `{"id":{"type":"string","description":"Id of the policy"},"lastModifiedBy":{"$ref":"./common-types.js...` |
| `definitions.PolicyAssignmentProperties.properties.roleDefinition.properties__deleted`             | deleted     | `{"id":{"type":"string","description":"Id of the role definition"},"displayName":{"type":"string","de...` |
| `definitions.PolicyAssignmentProperties.properties.scope.properties__deleted`                      | deleted     | `{"id":{"type":"string","description":"Scope id of the resource"},"displayName":{"type":"string","des...` |
| `definitions.PolicyProperties.properties.scope.properties__deleted`                                | deleted     | `{"id":{"type":"string","description":"Scope id of the resource"},"displayName":{"type":"string","des...` |
| `definitions.RoleAssignmentScheduleRequestProperties.properties.scheduleInfo.properties__deleted`  | deleted     | `{"startDateTime":{"type":"string","format":"date-time","description":"Start DateTime of the role ass...` |
| `definitions.RoleAssignmentScheduleRequestProperties.properties.ticketInfo.properties__deleted`    | deleted     | `{"ticketNumber":{"type":"string","description":"Ticket number for the role assignment"},"ticketSyste...` |
| `definitions.RoleEligibilityScheduleRequestProperties.properties.scheduleInfo.properties__deleted` | deleted     | `{"startDateTime":{"type":"string","format":"date-time","description":"Start DateTime of the role eli...` |
| `definitions.RoleEligibilityScheduleRequestProperties.properties.ticketInfo.properties__deleted`   | deleted     | `{"ticketNumber":{"type":"string","description":"Ticket number for the role eligibility"},"ticketSyst...` |

### Changes for `$ref`

| Path                                                                                       | Change Type | Value                                                                |
| ------------------------------------------------------------------------------------------ | ----------- | -------------------------------------------------------------------- |
| `definitions.ExpandedProperties.properties.principal.$ref__added`                          | added       | `#/definitions/ExpandedPropertiesPrincipal`                          |
| `definitions.ExpandedProperties.properties.roleDefinition.$ref__added`                     | added       | `#/definitions/ExpandedPropertiesRoleDefinition`                     |
| `definitions.ExpandedProperties.properties.scope.$ref__added`                              | added       | `#/definitions/ExpandedPropertiesScope`                              |
| `definitions.PolicyAssignmentProperties.properties.policy.$ref__added`                     | added       | `#/definitions/PolicyAssignmentPropertiesPolicy`                     |
| `definitions.PolicyAssignmentProperties.properties.roleDefinition.$ref__added`             | added       | `#/definitions/PolicyAssignmentPropertiesRoleDefinition`             |
| `definitions.PolicyAssignmentProperties.properties.scope.$ref__added`                      | added       | `#/definitions/PolicyAssignmentPropertiesScope`                      |
| `definitions.PolicyProperties.properties.scope.$ref__added`                                | added       | `#/definitions/PolicyPropertiesScope`                                |
| `definitions.RoleAssignmentScheduleRequestProperties.properties.scheduleInfo.$ref__added`  | added       | `#/definitions/RoleAssignmentScheduleRequestPropertiesScheduleInfo`  |
| `definitions.RoleAssignmentScheduleRequestProperties.properties.ticketInfo.$ref__added`    | added       | `#/definitions/RoleAssignmentScheduleRequestPropertiesTicketInfo`    |
| `definitions.RoleEligibilityScheduleRequestProperties.properties.scheduleInfo.$ref__added` | added       | `#/definitions/RoleEligibilityScheduleRequestPropertiesScheduleInfo` |
| `definitions.RoleEligibilityScheduleRequestProperties.properties.ticketInfo.$ref__added`   | added       | `#/definitions/RoleEligibilityScheduleRequestPropertiesTicketInfo`   |

### Changes for `readOnly`

| Path                                                                                   | Change Type | Value  |
| -------------------------------------------------------------------------------------- | ----------- | ------ |
| `definitions.Principal.readOnly__deleted`                                              | deleted     | `true` |
| `definitions.RoleManagementPolicyProperties.properties.lastModifiedBy.readOnly__added` | added       | `true` |

### Changes for `allOf`

| Path                                                       | Change Type | Value                                                                                             |
| ---------------------------------------------------------- | ----------- | ------------------------------------------------------------------------------------------------- |
| `definitions.RoleAssignmentSchedule.allOf__added`          | added       | `[{"$ref":"../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"}]` |
| `definitions.RoleAssignmentScheduleInstance.allOf__added`  | added       | `[{"$ref":"../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"}]` |
| `definitions.RoleAssignmentScheduleRequest.allOf__added`   | added       | `[{"$ref":"../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"}]` |
| `definitions.RoleEligibilitySchedule.allOf__added`         | added       | `[{"$ref":"../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"}]` |
| `definitions.RoleEligibilityScheduleInstance.allOf__added` | added       | `[{"$ref":"../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"}]` |
| `definitions.RoleEligibilityScheduleRequest.allOf__added`  | added       | `[{"$ref":"../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"}]` |
| `definitions.RoleManagementPolicy.allOf__added`            | added       | `[{"$ref":"../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"}]` |
| `definitions.RoleManagementPolicyAssignment.allOf__added`  | added       | `[{"$ref":"../../../common-types/resource-management/v5/types.json#/definitions/ProxyResource"}]` |

### Changes for `id`

| Path                                                                 | Change Type | Value                                                                                          |
| -------------------------------------------------------------------- | ----------- | ---------------------------------------------------------------------------------------------- |
| `definitions.RoleAssignmentSchedule.properties.id__deleted`          | deleted     | `{"type":"string","description":"The role assignment schedule Id.","readOnly":true}`           |
| `definitions.RoleAssignmentScheduleInstance.properties.id__deleted`  | deleted     | `{"type":"string","description":"The role assignment schedule instance ID.","readOnly":true}`  |
| `definitions.RoleAssignmentScheduleRequest.properties.id__deleted`   | deleted     | `{"type":"string","description":"The role assignment schedule request ID.","readOnly":true}`   |
| `definitions.RoleEligibilitySchedule.properties.id__deleted`         | deleted     | `{"type":"string","description":"The role eligibility schedule Id.","readOnly":true}`          |
| `definitions.RoleEligibilityScheduleInstance.properties.id__deleted` | deleted     | `{"type":"string","description":"The role eligibility schedule instance ID.","readOnly":true}` |
| `definitions.RoleEligibilityScheduleRequest.properties.id__deleted`  | deleted     | `{"type":"string","description":"The role eligibility schedule request ID.","readOnly":true}`  |
| `definitions.RoleManagementPolicy.properties.id__deleted`            | deleted     | `{"type":"string","description":"The role management policy Id.","readOnly":true}`             |
| `definitions.RoleManagementPolicyAssignment.properties.id__deleted`  | deleted     | `{"type":"string","description":"The role management policy Id.","readOnly":true}`             |

### Changes for `name`

| Path                                                                   | Change Type | Value                                                                                            |
| ---------------------------------------------------------------------- | ----------- | ------------------------------------------------------------------------------------------------ |
| `definitions.RoleAssignmentSchedule.properties.name__deleted`          | deleted     | `{"type":"string","description":"The role assignment schedule name.","readOnly":true}`           |
| `definitions.RoleAssignmentScheduleInstance.properties.name__deleted`  | deleted     | `{"type":"string","description":"The role assignment schedule instance name.","readOnly":true}`  |
| `definitions.RoleAssignmentScheduleRequest.properties.name__deleted`   | deleted     | `{"type":"string","description":"The role assignment schedule request name.","readOnly":true}`   |
| `definitions.RoleEligibilitySchedule.properties.name__deleted`         | deleted     | `{"type":"string","description":"The role eligibility schedule name.","readOnly":true}`          |
| `definitions.RoleEligibilityScheduleInstance.properties.name__deleted` | deleted     | `{"type":"string","description":"The role eligibility schedule instance name.","readOnly":true}` |
| `definitions.RoleEligibilityScheduleRequest.properties.name__deleted`  | deleted     | `{"type":"string","description":"The role eligibility schedule request name.","readOnly":true}`  |
| `definitions.RoleManagementPolicy.properties.name__deleted`            | deleted     | `{"type":"string","description":"The role management policy name.","readOnly":true}`             |
| `definitions.RoleManagementPolicyAssignment.properties.name__deleted`  | deleted     | `{"type":"string","description":"The role management policy name.","readOnly":true}`             |

### Changes for `x-ms-discriminator-value`

| Path                                                                                           | Change Type | Value                                           |
| ---------------------------------------------------------------------------------------------- | ----------- | ----------------------------------------------- |
| `definitions.RoleManagementPolicyApprovalRule['x-ms-discriminator-value__added']`              | added       | `RoleManagementPolicyApprovalRule`              |
| `definitions.RoleManagementPolicyAuthenticationContextRule['x-ms-discriminator-value__added']` | added       | `RoleManagementPolicyAuthenticationContextRule` |
| `definitions.RoleManagementPolicyEnablementRule['x-ms-discriminator-value__added']`            | added       | `RoleManagementPolicyEnablementRule`            |
| `definitions.RoleManagementPolicyExpirationRule['x-ms-discriminator-value__added']`            | added       | `RoleManagementPolicyExpirationRule`            |
| `definitions.RoleManagementPolicyNotificationRule['x-ms-discriminator-value__added']`          | added       | `RoleManagementPolicyNotificationRule`          |
| `definitions.RoleManagementPolicyPimOnlyModeRule['x-ms-discriminator-value__added']`           | added       | `RoleManagementPolicyPimOnlyModeRule`           |

## Modified Values

| Path                                                                                        | Old Value                                                   | New Value                                         |
| ------------------------------------------------------------------------------------------- | ----------------------------------------------------------- | ------------------------------------------------- |
| `definitions.RoleAssignmentScheduleInstanceProperties.properties.status.description`        | `The status of the role assignment schedule instance.`      | `The status of the role assignment schedule.`     |
| `definitions.RoleAssignmentScheduleRequestProperties.properties.status.description`         | `The status of the role assignment schedule request.`       | `The status of the role assignment schedule.`     |
| `definitions.RoleEligibilityScheduleInstanceProperties.properties.memberType.description`   | `Membership type of the role eligibility schedule`          | `Membership type of the role assignment schedule` |
| `definitions.RoleEligibilityScheduleInstanceProperties.properties.status.description`       | `The status of the role eligibility schedule instance`      | `The status of the role assignment schedule.`     |
| `definitions.RoleEligibilityScheduleProperties.properties.memberType.description`           | `Membership type of the role eligibility schedule`          | `Membership type of the role assignment schedule` |
| `definitions.RoleEligibilityScheduleProperties.properties.status.description`               | `The status of the role eligibility schedule.`              | `The status of the role assignment schedule.`     |
| `definitions.RoleEligibilityScheduleRequestProperties.properties.status.description`        | `The status of the role eligibility schedule request.`      | `The status of the role assignment schedule.`     |
| `definitions.RoleManagementPolicyAssignmentProperties.properties.effectiveRules.items.$ref` | `./common-types.json#/definitions/RoleManagementPolicyRule` | `#/definitions/RoleManagementPolicyRule`          |
| `definitions.RoleManagementPolicyProperties.properties.effectiveRules.items.$ref`           | `./common-types.json#/definitions/RoleManagementPolicyRule` | `#/definitions/RoleManagementPolicyRule`          |
| `definitions.RoleManagementPolicyProperties.properties.lastModifiedBy.$ref`                 | `./common-types.json#/definitions/Principal`                | `#/definitions/Principal`                         |
| `definitions.RoleManagementPolicyProperties.properties.rules.items.$ref`                    | `./common-types.json#/definitions/RoleManagementPolicyRule` | `#/definitions/RoleManagementPolicyRule`          |
| `definitions.UsersOrServicePrincipalSet.properties.type['x-ms-enum'].name`                  | `UserType`                                                  | `CommonUserType`                                  |
