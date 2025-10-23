# Query-Based Metric Alert - .NET Test Examples

This document provides .NET test examples for the most common Query-Based Metric Alert scenarios using the 2024-03-01-preview API.

## Prerequisites

```csharp
using Azure;
using Azure.Core;
using Azure.Identity;
using Azure.ResourceManager;
using Azure.ResourceManager.Monitor;
using Azure.ResourceManager.Monitor.Models;
using Azure.ResourceManager.Resources;
using NUnit.Framework;

namespace Azure.ResourceManager.Monitor.Tests
{
    public class QueryBasedMetricAlertTests : MonitorManagementTestBase
    {
        private ResourceGroupResource _resourceGroup;
        private string _subscriptionId;
        
        [SetUp]
        public async Task Setup()
        {
            _subscriptionId = TestEnvironment.SubscriptionId;
            var subscription = await Client.GetDefaultSubscriptionAsync();
            _resourceGroup = await CreateResourceGroup(subscription, "rg-queryalert-test", AzureLocation.EastUS);
        }
    }
}
```

## Test 1: Create Query-Based Metric Alert with PromQL

This is the **most common scenario** - creating a metric alert using PromQL query.

```csharp
[Test]
[RecordedTest]
public async Task CreateQueryBasedMetricAlert_WithPromQL_Success()
{
    // Arrange
    string alertRuleName = Recording.GenerateAssetName("query-alert-");
    string monitorAccountId = $"/subscriptions/{_subscriptionId}/resourceGroups/{_resourceGroup.Data.Name}/providers/Microsoft.Monitor/accounts/test-monitor-account";
    string actionGroupId = $"/subscriptions/{_subscriptionId}/resourceGroups/{_resourceGroup.Data.Name}/providers/Microsoft.Insights/actionGroups/test-action-group";
    string managedIdentityId = $"/subscriptions/{_subscriptionId}/resourceGroups/{_resourceGroup.Data.Name}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/test-identity";

    var metricAlertData = new MetricAlertData(AzureLocation.EastUS)
    {
        Description = "Alert when CPU utilization exceeds 90%",
        Severity = 3,
        IsEnabled = true,
        EvaluationFrequency = TimeSpan.FromMinutes(1),
        WindowSize = TimeSpan.FromMinutes(5),
        Criteria = new PromQLCriteria
        {
            FailingPeriods = new FailingPeriods
            {
                For = TimeSpan.FromMinutes(5)
            },
            AllOf =
            {
                new PromQLCriterion("Metric1")
                {
                    CriterionType = "StaticThresholdCriterion",
                    Query = "avg({\\\"system.cpu.utilization\\\"}) > 90"
                }
            }
        },
        ResolveConfiguration = new ResolveConfiguration
        {
            AutoResolved = true,
            TimeToResolve = TimeSpan.FromMinutes(10)
        },
        Tags = { }
    };

    // Add scope
    metricAlertData.Scopes.Add(monitorAccountId);

    // Add action
    metricAlertData.Actions.Add(new MetricAlertAction(actionGroupId));

    // Add managed identity
    metricAlertData.Identity = new ManagedServiceIdentity(ManagedServiceIdentityType.UserAssigned);
    metricAlertData.Identity.UserAssignedIdentities.Add(managedIdentityId, new UserAssignedIdentity());

    // Add custom properties
    metricAlertData.CustomProperties.Add("key1", "value1");
    metricAlertData.ActionProperties.Add("Email.Subject", "CPU Alert Triggered");

    // Act
    var collection = _resourceGroup.GetMetricAlerts();
    var createOperation = await collection.CreateOrUpdateAsync(WaitUntil.Completed, alertRuleName, metricAlertData);
    var metricAlert = createOperation.Value;

    // Assert
    Assert.IsNotNull(metricAlert);
    Assert.AreEqual(alertRuleName, metricAlert.Data.Name);
    Assert.AreEqual(3, metricAlert.Data.Severity);
    Assert.IsTrue(metricAlert.Data.IsEnabled);
    Assert.AreEqual(1, metricAlert.Data.Scopes.Count);
    
    var criteria = metricAlert.Data.Criteria as PromQLCriteria;
    Assert.IsNotNull(criteria);
    Assert.AreEqual(1, criteria.AllOf.Count);
    Assert.AreEqual("avg({\\\"system.cpu.utilization\\\"}) > 90", criteria.AllOf[0].Query);
}
```

## Test 2: Get Query-Based Metric Alert

```csharp
[Test]
[RecordedTest]
public async Task GetQueryBasedMetricAlert_Exists_ReturnsAlert()
{
    // Arrange
    string alertRuleName = "existing-query-alert";
    var collection = _resourceGroup.GetMetricAlerts();

    // Act
    var response = await collection.GetAsync(alertRuleName);
    var metricAlert = response.Value;

    // Assert
    Assert.IsNotNull(metricAlert);
    Assert.AreEqual(alertRuleName, metricAlert.Data.Name);
    Assert.IsInstanceOf<PromQLCriteria>(metricAlert.Data.Criteria);
}
```

## Test 3: List Query-Based Metric Alerts

```csharp
[Test]
[RecordedTest]
public async Task ListQueryBasedMetricAlerts_ReturnsAlerts()
{
    // Arrange
    var collection = _resourceGroup.GetMetricAlerts();

    // Act
    var alerts = new List<MetricAlertResource>();
    await foreach (var alert in collection.GetAllAsync())
    {
        alerts.Add(alert);
    }

    // Assert
    Assert.IsNotEmpty(alerts);
    Assert.IsTrue(alerts.Any(a => a.Data.Criteria is PromQLCriteria));
}
```

## Test 4: Update Query-Based Metric Alert

```csharp
[Test]
[RecordedTest]
public async Task UpdateQueryBasedMetricAlert_Success()
{
    // Arrange
    string alertRuleName = "existing-query-alert";
    var collection = _resourceGroup.GetMetricAlerts();
    var metricAlert = await collection.GetAsync(alertRuleName);

    var patchData = new MetricAlertPatch
    {
        Tags = { { "Environment", "Test" } },
        IsEnabled = false,
        Description = "Updated alert description"
    };

    // Act
    var updateResponse = await metricAlert.Value.UpdateAsync(patchData);

    // Assert
    Assert.IsNotNull(updateResponse.Value);
    Assert.IsFalse(updateResponse.Value.Data.IsEnabled);
    Assert.AreEqual("Updated alert description", updateResponse.Value.Data.Description);
}
```

## Test 5: Get Alert Status

```csharp
[Test]
[RecordedTest]
public async Task GetQueryBasedMetricAlertStatus_ReturnsStatus()
{
    // Arrange
    string alertRuleName = "existing-query-alert";
    var collection = _resourceGroup.GetMetricAlerts();
    var metricAlert = await collection.GetAsync(alertRuleName);

    // Act
    var statusCollection = await metricAlert.Value.GetMetricAlertStatusesAsync();
    var statuses = new List<MetricAlertStatusProperties>();
    
    await foreach (var status in statusCollection)
    {
        statuses.Add(status);
    }

    // Assert
    Assert.IsNotNull(statuses);
}
```

## Test 6: Delete Query-Based Metric Alert

```csharp
[Test]
[RecordedTest]
public async Task DeleteQueryBasedMetricAlert_Success()
{
    // Arrange
    string alertRuleName = "query-alert-to-delete";
    var collection = _resourceGroup.GetMetricAlerts();
    var metricAlert = await collection.GetAsync(alertRuleName);

    // Act
    await metricAlert.Value.DeleteAsync(WaitUntil.Completed);

    // Assert
    var exists = await collection.ExistsAsync(alertRuleName);
    Assert.IsFalse(exists.Value);
}
```

## Test 7: Create with Multiple Resource Scopes

```csharp
[Test]
[RecordedTest]
public async Task CreateQueryBasedMetricAlert_MultipleScopes_Success()
{
    // Arrange
    string alertRuleName = Recording.GenerateAssetName("multi-scope-alert-");
    string monitorAccount1 = $"/subscriptions/{_subscriptionId}/resourceGroups/{_resourceGroup.Data.Name}/providers/Microsoft.Monitor/accounts/account1";
    string monitorAccount2 = $"/subscriptions/{_subscriptionId}/resourceGroups/{_resourceGroup.Data.Name}/providers/Microsoft.Monitor/accounts/account2";

    var metricAlertData = new MetricAlertData(AzureLocation.EastUS)
    {
        Description = "Multi-resource query alert",
        Severity = 2,
        IsEnabled = true,
        EvaluationFrequency = TimeSpan.FromMinutes(5),
        WindowSize = TimeSpan.FromMinutes(15),
        Criteria = new PromQLCriteria
        {
            AllOf =
            {
                new PromQLCriterion("HighMemoryUsage")
                {
                    Query = "avg({\\\"system.memory.utilization\\\"}) > 80"
                }
            }
        }
    };

    // Add multiple scopes
    metricAlertData.Scopes.Add(monitorAccount1);
    metricAlertData.Scopes.Add(monitorAccount2);

    // Act
    var collection = _resourceGroup.GetMetricAlerts();
    var createOperation = await collection.CreateOrUpdateAsync(WaitUntil.Completed, alertRuleName, metricAlertData);
    var metricAlert = createOperation.Value;

    // Assert
    Assert.IsNotNull(metricAlert);
    Assert.AreEqual(2, metricAlert.Data.Scopes.Count);
}
```

## Common Assertions Helper

```csharp
private void AssertQueryBasedMetricAlert(MetricAlertResource alert, string expectedName)
{
    Assert.IsNotNull(alert);
    Assert.AreEqual(expectedName, alert.Data.Name);
    Assert.IsNotNull(alert.Data.Criteria);
    Assert.IsInstanceOf<PromQLCriteria>(alert.Data.Criteria);
    
    var criteria = alert.Data.Criteria as PromQLCriteria;
    Assert.IsNotEmpty(criteria.AllOf);
    Assert.IsTrue(criteria.AllOf.All(c => !string.IsNullOrEmpty(c.Query)));
}
```

## Key Points for Query-Based Metric Alerts

1. **Criteria Type**: Use `PromQLCriteria` for query-based alerts
2. **Query Format**: PromQL queries should be properly escaped
3. **Scopes**: Must reference Azure Monitor accounts or workspace resources
4. **Identity**: User-assigned managed identity is required for accessing resources
5. **Evaluation Frequency**: Minimum 1 minute intervals
6. **Resolution**: Auto-resolve configuration helps prevent alert fatigue

## Testing Tips

- Use `Recording.GenerateAssetName()` for unique resource names
- Clean up resources in `[TearDown]` methods
- Test both successful and error scenarios
- Validate all properties after create/update operations
- Test with different PromQL query patterns
