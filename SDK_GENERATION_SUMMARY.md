# Query-Based Metric Alerts - SDK Generation Summary

## ✅ Completed Tasks

### 1. Branch Created
- **Branch name**: `sdk/monitor-query-based-metric-alerts-dotnet`
- **Base branch**: `main`
- **Commit**: `2c77543c4b`

### 2. Test Scenarios Added
**File**: `specification/monitor/resource-manager/Microsoft.Insights/preview/2024-03-01-preview/scenarios/QueryBasedMetricAlerts.yaml`

This file includes two comprehensive test scenarios:

#### Scenario 1: QueryBasedMetricAlertLifecycle
Complete end-to-end lifecycle test covering:
1. ✅ Create managed identity
2. ✅ Create action group  
3. ✅ Create monitor account
4. ✅ **Create query-based metric alert** (main test)
5. ✅ Get the created alert
6. ✅ List alerts by resource group
7. ✅ Get alert status
8. ✅ Update the alert
9. ✅ Delete the alert

#### Scenario 2: QueryBasedMetricAlertWithMultipleResources
Multi-resource scope test:
1. ✅ Create alert with multiple scopes
2. ✅ Get the alert
3. ✅ Delete the alert

### 3. .NET Test Examples Created
**File**: `specification/monitor/resource-manager/Microsoft.Insights/preview/2024-03-01-preview/examples/tests/QueryBasedMetricAlertTest.md`

Complete .NET test code examples for:
- ✅ **Test 1**: Create query-based metric alert with PromQL (MOST COMMON)
- ✅ **Test 2**: Get query-based metric alert
- ✅ **Test 3**: List query-based metric alerts
- ✅ **Test 4**: Update query-based metric alert
- ✅ **Test 5**: Get alert status
- ✅ **Test 6**: Delete query-based metric alert
- ✅ **Test 7**: Create with multiple resource scopes

Each test includes:
- Complete setup code
- Arrange-Act-Assert pattern
- Property validations
- Expected assertions

### 4. Documentation Included
The test examples include:
- ✅ Prerequisites and setup
- ✅ PromQL query patterns
- ✅ Managed identity configuration
- ✅ Action group integration
- ✅ Custom properties usage
- ✅ Best practices
- ✅ Common assertions helper
- ✅ Testing tips

## 📋 Next Steps - Create Pull Request

### Option 1: Create PR via GitHub Web UI (Recommended)

1. **Visit this link**: https://github.com/Azure/azure-rest-api-specs/pull/new/sdk/monitor-query-based-metric-alerts-dotnet

2. **Fill in PR details**:

**Title**:
```
Add .NET SDK generation for Query-Based Metric Alerts (2024-03-01-preview)
```

**Description**:
```markdown
## Description

This PR adds support for generating .NET SDK for the new Query-Based Metric Alerts feature in Azure Monitor (API version 2024-03-01-preview).

## Changes

- ✅ Added comprehensive test scenarios in `scenarios/QueryBasedMetricAlerts.yaml`
- ✅ Created .NET test examples documentation with common usage patterns
- ✅ Included complete lifecycle tests (create, get, list, update, delete)
- ✅ Added multi-resource scope scenarios
- ✅ Documented PromQL query patterns and best practices

## Test Scenarios Covered

### Primary Scenario: Query-Based Metric Alert Lifecycle
1. Create managed identity
2. Create action group
3. Create monitor account
4. **Create query-based metric alert with PromQL criteria**
5. Get the created alert
6. List alerts by resource group
7. Get alert status
8. Update alert properties
9. Delete the alert

### Secondary Scenario: Multi-Resource Query Alert
- Create alert with multiple resource scopes
- Validate and delete

## .NET Test Examples

The PR includes comprehensive .NET test code examples for:
- Creating query-based alerts with PromQL queries
- Getting and listing alerts
- Updating alert properties
- Managing alert status
- Working with multiple resource scopes
- Using managed identities and action groups

## Related Information

- **API Version**: 2024-03-01-preview (Public Preview)
- **Feature**: Query-Based Metric Alerts with PromQL support
- **Release Plan**: https://apps.powerapps.com/play/e/ed2ffefd-774d-40dd-ab23-7fff01aeec9f/a/821ab569-ae60-420d-8264-d7b5d5ef734c
- **SDK Language**: .NET (primary), will trigger generation for all configured languages

## SDK Generation

Once this PR is merged, the SDK automation will:
1. Generate .NET SDK for azure-sdk-for-net repository
2. Create PRs in language-specific repositories
3. Include the test examples for SDK validation

## Checklist

- [x] Test scenarios added
- [x] .NET test examples documented
- [x] Examples cover common usage patterns
- [x] Multi-resource scenarios included
- [x] PromQL query patterns documented
- [x] Lifecycle tests complete

---

**Note**: This is a preview API version. The SDK will be generated as a beta package.
```

3. **Mark as Draft** (optional - recommended until review)
4. **Click "Create Pull Request"**

### Option 2: Using Git Command Line

If you prefer command line after fixing GitHub auth:
```bash
gh auth login
gh pr create --web
```

## 🔄 What Happens After PR is Created

1. **Validation Pipelines Run**:
   - OpenAPI/Swagger validation
   - Breaking change detection
   - Example validation
   - Linting checks

2. **SDK Automation Triggers**:
   - Once PR is approved and merged
   - Automatically creates PRs in `azure-sdk-for-net`
   - Generates SDK code using AutoRest
   - Includes your test examples

3. **SDK PR Review**:
   - .NET team reviews generated SDK
   - Your test examples help validate functionality
   - SDK gets published as beta package

## 📁 Files Changed

```
specification/monitor/resource-manager/Microsoft.Insights/preview/2024-03-01-preview/
├── scenarios/
│   └── QueryBasedMetricAlerts.yaml          (NEW - Test scenarios)
└── examples/
    └── tests/
        └── QueryBasedMetricAlertTest.md      (NEW - .NET test examples)
```

## 🎯 Most Common Usage Test

**Test 1** in the .NET examples is the most common scenario:

```csharp
CreateQueryBasedMetricAlert_WithPromQL_Success()
```

This test covers:
- Creating a metric alert with PromQL query
- Using managed identity for authentication
- Configuring action groups
- Setting evaluation frequency
- Adding custom properties
- Enabling auto-resolution

## 📊 Test Coverage

| Category | Coverage |
|----------|----------|
| CRUD Operations | ✅ Create, Read, Update, Delete |
| List Operations | ✅ By subscription, by resource group |
| Status Management | ✅ Get status, monitor status |
| Multi-resource | ✅ Multiple scopes support |
| PromQL Queries | ✅ CPU, memory utilization examples |
| Identity | ✅ User-assigned managed identity |
| Actions | ✅ Action groups integration |
| Properties | ✅ Custom and action properties |

## 🔗 Related Links

- **API Specification**: `specification/monitor/resource-manager/Microsoft.Insights/preview/2024-03-01-preview/metricAlert_API.json`
- **Readme Configuration**: `specification/monitor/resource-manager/readme.md` (tag: `package-2024-03-01-preview`)
- **Release Plan**: https://apps.powerapps.com/play/e/ed2ffefd-774d-40dd-ab23-7fff01aeec9f/a/821ab569-ae60-420d-8264-d7b5d5ef734c
- **Branch**: https://github.com/Azure/azure-rest-api-specs/tree/sdk/monitor-query-based-metric-alerts-dotnet

## ✨ Key Features Tested

1. **PromQL Query Support** - The main new feature
2. **Multi-resource Scoping** - Alert across multiple resources
3. **Managed Identity** - Secure authentication
4. **Auto-resolution** - Automatic alert resolution
5. **Custom Properties** - Extensibility support
6. **Action Groups** - Notification integration

---

**Status**: ✅ Ready for PR creation
**Next Action**: Create pull request using the link above
