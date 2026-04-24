# Hero Scenarios for Purview Data Catalog API

This document outlines the key hero scenarios that demonstrate the most common and 
valuable use cases for the Purview Data Catalog API. These scenarios are designed 
to be approachable, practical, and show immediate value to developers.

## 🎯 **Hero Scenario 1: Discover and Catalog Business Data Assets**

**Goal**: Help data analysts and business users quickly find and understand 
available data assets in their organization.

**Difficulty**: ⭐⭐ (Beginner)
**Time to Complete**: 5-10 minutes

### **The Story**

Sarah, a business analyst, needs to find customer data for her quarterly report. 
She wants to discover what customer datasets are available, understand their structure, 
and identify the data owners.

### **Prerequisites**
- Purview Data Catalog endpoint configured
- Authentication credentials (Azure AD token or service principal)
- Basic understanding of REST APIs

### **Step-by-Step Walkthrough**

#### **Step 1: Search for Customer Data (2 minutes)**

```http
POST /dataAssets/query
Content-Type: application/json
Authorization: Bearer {token}

{
  "nameKeyword": "customer",
  "skip": 0,
  "top": 20
}
```

**Expected Result**: List of customer-related data assets with basic metadata.

#### **Step 2: Get Detailed Asset Information (3 minutes)**

```http
GET /dataAssets/da12345-678-90ab-cdef-123456789abc
Authorization: Bearer {token}
```

**Expected Result**: Complete data asset details including schema, ownership, 
and quality metrics.

#### **Step 3: Explore Data Lineage (2 minutes)**

```http
GET /dataAssets/da12345-678-90ab-cdef-123456789abc/relationships?entityType=dataProduct
Authorization: Bearer {token}
```

**Expected Result**: Understanding of data flow and dependencies.

### **Success Criteria**
- ✅ Found relevant customer datasets in under 2 minutes
- ✅ Identified data owners and contact information
- ✅ Understood data sensitivity and compliance requirements
- ✅ Discovered data lineage and dependencies

### **Value Delivered**
- **Time Savings**: Find relevant data in minutes instead of hours
- **Data Understanding**: Clear descriptions, ownership, and lineage information
- **Compliance**: Understand data sensitivity and usage restrictions
- **Risk Reduction**: Avoid using wrong or outdated data sources

---

## 🎯 **Hero Scenario 2: Create and Manage Business Glossary Terms**

**Goal**: Establish a common business vocabulary to ensure consistent data 
understanding across the organization.

**Difficulty**: ⭐⭐⭐ (Intermediate)
**Time to Complete**: 10-15 minutes

### **The Story**

Mike, a data steward, needs to create standardized business terms like 
"Customer Lifetime Value" with clear definitions, ownership, and relationships 
to help teams speak the same data language.

### **Prerequisites**
- Data steward permissions in Purview
- Business domain already created
- Understanding of term relationships and hierarchies

### **Step-by-Step Walkthrough**

#### **Step 1: Create Business Term (5 minutes)**

```http
POST /terms
Content-Type: application/json
Authorization: Bearer {token}

{
  "name": "Customer Lifetime Value",
  "description": "The total monetary value a customer is expected to bring to a business throughout their entire relationship. Includes purchase frequency, average order value, customer lifespan, and profit margins.",
  "domain": "7e74f902-62f5-49f4-8258-92ed2b8537ba",
  "status": "Draft",
  "contacts": {
    "owner": [
      {
        "id": "mike.steward@company.com",
        "description": "Mike - Data Steward"
      }
    ]
  },
  "acronyms": ["CLV", "LTV", "CLTV"]
}
```

#### **Step 2: Create Term Hierarchy (5 minutes)**

```http
POST /terms/{termId}/relationships
Content-Type: application/json
Authorization: Bearer {token}

{
  "entityType": "term",
  "relationshipType": "isA",
  "entityId": "parent-term-id"
}
```

#### **Step 3: Assign Term to Data Assets (5 minutes)**

```http
POST /terms/{termId}/relationships
Content-Type: application/json
Authorization: Bearer {token}

{
  "entityType": "dataAsset",
  "relationshipType": "assignedTo",
  "entityId": "asset-guid"
}
```

### **Success Criteria**
- ✅ Created standardized term with clear definition
- ✅ Established term hierarchy and relationships
- ✅ Linked term to relevant data assets
- ✅ Set up approval workflow for term publication

### **Value Delivered**
- **Consistency**: Standardized business vocabulary across teams
- **Context**: Rich definitions and relationships for better understanding
- **Governance**: Clear ownership and approval workflows
- **Discoverability**: Easier data asset discovery through business terminology

---

## 🎯 **Hero Scenario 3: Implement Data Product Management**

**Goal**: Organize and manage data as products with clear ownership, SLAs, 
and consumer contracts.

**Difficulty**: ⭐⭐⭐⭐ (Advanced)
**Time to Complete**: 20-30 minutes

### **The Story**

Jennifer, a data product manager, wants to create a "Customer Analytics Data Product" 
that packages customer data with documentation, quality metrics, and clear consumer guidelines.

### **Prerequisites**
- Data product manager role and permissions
- Understanding of data product concepts
- Existing data assets to package
- Business domain structure in place

### **Step-by-Step Walkthrough**

#### **Step 1: Create Data Product Container (10 minutes)**

```http
POST /dataProducts
Content-Type: application/json
Authorization: Bearer {token}

{
  "name": "Customer Analytics Data Product",
  "description": "Comprehensive customer analytics data product providing insights into customer behavior, preferences, and lifetime value across all business channels.",
  "businessUse": "Enables marketing teams to optimize campaigns, product teams to enhance UX, and executives to make data-driven decisions.",
  "type": "Analytical",
  "status": "Published",
  "domain": "7e74f902-62f5-49f4-8258-92ed2b8537ba",
  "updateFrequency": "Daily",
  "audience": ["DataAnalyst", "DataScientist", "BusinessAnalyst"],
  "contacts": {
    "owner": [
      {
        "id": "jennifer.pm@company.com",
        "description": "Jennifer - Data Product Manager"
      }
    ]
  }
}
```

#### **Step 2: Link Data Assets to Product (10 minutes)**

```http
POST /dataProducts/{dataProductId}/relationships
Content-Type: application/json
Authorization: Bearer {token}

{
  "entityType": "dataAsset",
  "relationship": {
    "entityId": "customer-data-asset-guid",
    "relationshipType": "contains"
  }
}
```

#### **Step 3: Set Quality Metrics and SLAs (10 minutes)**

```http
PUT /dataProducts/{dataProductId}
Content-Type: application/json
Authorization: Bearer {token}

{
  "dataQualityScore": 95.8,
  "activeSubscriberCount": 85,
  "managedAttributes": [
    {
      "name": "SLA",
      "value": "99.9% uptime, <2hr refresh",
      "type": "string"
    },
    {
      "name": "DataFreshness",
      "value": "Daily by 6 AM PST",
      "type": "string"
    }
  ]
}
```

### **Success Criteria**
- ✅ Created comprehensive data product with clear business value
- ✅ Linked relevant data assets with proper relationships
- ✅ Defined SLAs and quality metrics
- ✅ Established consumer documentation and guidelines

### **Value Delivered**
- **Product Thinking**: Treat data as a managed product with clear SLAs
- **Discoverability**: Easy discovery of packaged data solutions
- **Quality Assurance**: Clear quality metrics and monitoring
- **Business Alignment**: Direct connection between data and business outcomes

---

## 🚀 **Quick Start Guide (Under 5 minutes)**

### **Setup Authentication**
```bash
# Option 1: Using Azure CLI
az login
export PURVIEW_TOKEN=$(az account get-access-token --resource https://purview.azure.net --query accessToken -o tsv)

# Option 2: Using environment variables
export PURVIEW_ENDPOINT="https://your-account.purview.azure.com"
export AZURE_CLIENT_ID="your-client-id"
export AZURE_CLIENT_SECRET="your-client-secret"
export AZURE_TENANT_ID="your-tenant-id"
```

### **First API Call**
```bash
# Search for data assets
curl -X POST "$PURVIEW_ENDPOINT/dataAssets/query" \
  -H "Authorization: Bearer $PURVIEW_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"nameKeyword": "customer", "top": 5}'
```

---

## 📋 **Scenario Progression Matrix**

| Scenario | Prerequisites | Difficulty | Time | Business Impact |
|----------|---------------|------------|------|-----------------|
| Data Discovery | Basic auth setup | ⭐⭐ | 5-10 min | ⭐⭐⭐⭐ |
| Glossary Management | Domain setup | ⭐⭐⭐ | 10-15 min | ⭐⭐⭐⭐⭐ |
| Data Products | Advanced setup | ⭐⭐⭐⭐ | 20-30 min | ⭐⭐⭐⭐⭐ |

### **Learning Path Recommendation**
1. **Start Here**: Data Asset Discovery (builds confidence)
2. **Next**: Business Glossary (establishes governance foundation)
3. **Advanced**: Data Product Management (delivers business value)

---

## 🎯 **Success Metrics**

### **Developer Experience Metrics**
- **Time to First Success**: < 10 minutes from setup to first successful API call
- **Scenario Completion Rate**: > 90% for basic scenarios
- **Developer Satisfaction**: Clear value demonstration in each scenario

### **Business Value Metrics**
- **Data Discovery Time**: Reduced from hours to minutes
- **Vocabulary Consistency**: Standardized terms across teams
- **Data Product Adoption**: Measurable business outcomes from data products

These hero scenarios provide a clear, progressive learning path that demonstrates 
immediate value while building toward more advanced data governance capabilities.

---

## 🎯 **Hero Scenario 4: Track Critical Data Elements and Compliance**

**Goal**: Identify, catalog, and monitor critical data elements for regulatory compliance and risk management.

### **The Story**
David, a compliance officer, needs to identify all data elements containing PII (Personally Identifiable Information) and ensure they're properly classified and protected.

### **Key Operations**
```http
# 1. Create critical data elements for PII
POST /criticalDataElements
{
  "name": "Customer Email Address",
  "description": "Primary email address for customer communication",
  "dataClassification": "PII",
  "complianceFramework": "GDPR"
}

# 2. Query critical data elements by compliance needs
POST /criticalDataElements/query
{
  "managedAttributes": [
    {
      "field": "dataClassification",
      "operator": "equals",
      "value": "PII"
    }
  ]
}

# 3. Link critical data elements to data columns
POST /criticalDataColumns/{columnId}/relationships
{
  "entityType": "criticalDataElement",
  "relationship": {
    "criticalDataElementId": "{element-id}"
  }
}
```

### **Value Delivered**
- **Risk Management**: Clear visibility into sensitive data location
- **Compliance**: Automated compliance reporting and monitoring
- **Data Protection**: Proper classification and protection controls

---

## 🎯 **Hero Scenario 5: Manage Business Domains and OKRs**

**Goal**: Organize data governance around business domains and track objectives with key results.

### **The Story**
Lisa, a domain owner, wants to organize her marketing domain's data assets and track data quality objectives through measurable key results.

### **Key Operations**
```http
# 1. Create or update business domain
POST /businessdomains
{
  "name": "Marketing Domain",
  "description": "All marketing-related data assets and governance",
  "owner": "lisa@company.com"
}

# 2. Create objectives for the domain
POST /objectives
{
  "name": "Improve Marketing Data Quality",
  "description": "Achieve 95% data quality score across all marketing datasets",
  "domainId": "{domain-id}",
  "status": "Active"
}

# 3. Add key results to track progress
POST /objectives/{objectiveId}/keyResults
{
  "name": "Customer Data Quality Score",
  "description": "Achieve 95% quality score for customer datasets",
  "targetValue": 95,
  "currentValue": 87,
  "unit": "percentage"
}
```

### **Value Delivered**
- **Organization**: Clear domain-based data organization
- **Accountability**: Measurable objectives and progress tracking
- **Alignment**: Business goals connected to data governance

---

## 🚀 **Getting Started Examples**

### **Quick Setup (5 minutes)**
```bash
# 1. Set up authentication
export PURVIEW_ENDPOINT="https://your-purview-account.purview.azure.com"

# 2. Create your first business domain
curl -X POST "$PURVIEW_ENDPOINT/businessdomains" \
  -H "Content-Type: application/json" \
  -d '{"name": "Sales Domain", "description": "Sales data governance"}'

# 3. Add a business term
curl -X POST "$PURVIEW_ENDPOINT/terms" \
  -H "Content-Type: application/json" \
  -d '{"name": "Monthly Recurring Revenue", "domain": "{domain-id}"}'
```

### **Common Integration Patterns**
- **Data Discovery Portal**: Build search interfaces using `/dataAssets/query`
- **Glossary Management**: Create term management UIs with `/terms` endpoints
- **Compliance Dashboards**: Monitor critical data with `/criticalDataElements`
- **Data Product Catalog**: Showcase data products with `/dataProducts`

---

## 🎯 **Hero Scenario 6: Register a Production Table as a Governed Data Asset, Import Its Column Schema, and Tag Sensitive Columns for Compliance**

**Goal**: Bring a production database table under active governance by registering it as a data asset, importing its column schema from Data Map, tagging sensitive columns with critical data elements for regulatory compliance, and linking the asset to a data product for discoverability.

**Difficulty**: ⭐⭐⭐⭐ (Advanced)
**Time to Complete**: 15-20 minutes

### **The Story**

A data steward at a financial services company needs to bring a production Azure SQL table that holds customer transaction records under active governance. The table was already scanned by Microsoft Purview Data Map. She registers it as a data asset, imports its column schema from Data Map, tags the `CustomerEmail` and `AccountNumber` columns with pre-defined critical data elements to satisfy PCI-DSS requirements, and links the asset to the "Payments Data Product" so downstream consumers can discover it through the catalog.

### **Prerequisites**
- Purview endpoint configured and authenticated
- An Azure SQL table already scanned in Microsoft Purview Data Map (Data Map asset ID `87530cc2-5a0f-4f84-befb-2af6f6f60000`; column IDs `a1174096-2a8c-4f8d-9cb4-e23512d85d43` for `CustomerEmail` and `b8d2b3f5-85cc-4d20-968b-be8d957c6716` for `AccountNumber`)
- A "Customer Email" critical data element (`10013344-5566-7788-99aa-bbccddeeff00`) and a "Payments Data Product" (`90013344-5566-7788-99aa-bbccddeeff00`) already exist in the catalog

### **Step-by-Step Walkthrough**

#### **Step 1: Create the Data Asset, Linking It to the Scanned Data Map Table**

```http
POST /dataAssets
Content-Type: application/json
Authorization: Bearer {token}

{
  "source": {
    "assetId": "87530cc2-5a0f-4f84-befb-2af6f6f60000"
  },
  "contacts": {
    "owner": [
      {
        "id": "4e74f902-62f5-49f4-8258-92ed2b8537ba",
        "description": "Jane — Data Steward"
      }
    ]
  }
}
```

**Expected Response** (201 Created):
```json
{
  "id": "da001122-3344-5566-7788-99aabbccddee",
  "name": "transactions_prod",
  "type": "AzureSqlTable",
  "typeProperties": {
    "serverEndpoint": "https://payments-sql.database.windows.net",
    "databaseName": "payments",
    "schemaName": "dbo",
    "tableName": "transactions"
  },
  "source": {
    "type": "DataMap",
    "assetId": "87530cc2-5a0f-4f84-befb-2af6f6f60000",
    "assetType": "azure_sql_table",
    "fqn": "mssql://payments-sql.database.windows.net/payments/dbo/transactions",
    "accountName": "payments-sql",
    "lastRefreshedAt": "2026-03-20T12:00:00.000Z",
    "lastRefreshedBy": "4e74f902-62f5-49f4-8258-92ed2b8537ba"
  },
  "contacts": {
    "owner": [
      {
        "id": "4e74f902-62f5-49f4-8258-92ed2b8537ba",
        "description": "Jane — Data Steward"
      }
    ]
  },
  "systemData": {
    "provisioningState": "Succeeded",
    "createdAt": "2026-03-20T12:00:00.000Z",
    "createdBy": "4e74f902-62f5-49f4-8258-92ed2b8537ba"
  }
}
```

#### **Step 2: Ingest the Table's Columns from Data Map into the Catalog**

Ingest each column individually. First, the `CustomerEmail` column:

```http
POST /dataColumns/ingest
Content-Type: application/json
Authorization: Bearer {token}

{
  "requests": [
    {
      "dataMapAssetId": "87530cc2-5a0f-4f84-befb-2af6f6f60000",
      "dataMapColumnId": "a1174096-2a8c-4f8d-9cb4-e23512d85d43"
    }
  ]
}
```

**Expected Response** (200 OK):
```json
{
  "id": "aaaaaa11-1111-2222-3333-444455556666",
  "source": {
    "type": "DataMap",
    "assetId": "87530cc2-5a0f-4f84-befb-2af6f6f60000",
    "columnId": "a1174096-2a8c-4f8d-9cb4-e23512d85d43"
  }
}
```

Then, the `AccountNumber` column:

```http
POST /dataColumns/ingest
Content-Type: application/json
Authorization: Bearer {token}

{
  "requests": [
    {
      "dataMapAssetId": "87530cc2-5a0f-4f84-befb-2af6f6f60000",
      "dataMapColumnId": "b8d2b3f5-85cc-4d20-968b-be8d957c6716"
    }
  ]
}
```

**Expected Response** (200 OK):
```json
{
  "id": "bbbbbb11-1111-2222-3333-444455556666",
  "source": {
    "type": "DataMap",
    "assetId": "87530cc2-5a0f-4f84-befb-2af6f6f60000",
    "columnId": "b8d2b3f5-85cc-4d20-968b-be8d957c6716"
  }
}
```

#### **Step 3: Query Columns to Retrieve Their Catalog IDs and Verify Ingestion**

```http
POST /dataColumns/query
Content-Type: application/json
Authorization: Bearer {token}

{
  "filter": {
    "sourceAssetId": {
      "eq": "87530cc2-5a0f-4f84-befb-2af6f6f60000"
    }
  },
  "includingOrphans": false,
  "includeColumnDetails": true,
  "skip": 0,
  "top": 20
}
```

**Expected Response** (200 OK):
```json
{
  "value": [
    {
      "id": "aaaaaa11-1111-2222-3333-444455556666",
      "source": {
        "type": "DataMap",
        "assetId": "87530cc2-5a0f-4f84-befb-2af6f6f60000",
        "columnId": "a1174096-2a8c-4f8d-9cb4-e23512d85d43"
      },
      "columnDetails": {
        "name": "CustomerEmail",
        "description": "Primary customer email address",
        "dataType": "nvarchar",
        "qualifiedName": "mssql://payments-sql.database.windows.net/payments/dbo/transactions#CustomerEmail"
      }
    },
    {
      "id": "bbbbbb11-1111-2222-3333-444455556666",
      "source": {
        "type": "DataMap",
        "assetId": "87530cc2-5a0f-4f84-befb-2af6f6f60000",
        "columnId": "b8d2b3f5-85cc-4d20-968b-be8d957c6716"
      },
      "columnDetails": {
        "name": "AccountNumber",
        "description": "Customer payment account number",
        "dataType": "nvarchar",
        "qualifiedName": "mssql://payments-sql.database.windows.net/payments/dbo/transactions#AccountNumber"
      }
    }
  ]
}
```

#### **Step 4: Tag Sensitive Columns with Critical Data Elements for PCI-DSS Compliance**

Tag the `CustomerEmail` column:

```http
POST /dataColumns/aaaaaa11-1111-2222-3333-444455556666/relationships?entityType=CRITICALDATAELEMENT
Content-Type: application/json
Authorization: Bearer {token}

{
  "relationshipType": "Related",
  "entityId": "10013344-5566-7788-99aa-bbccddeeff00",
  "description": "CustomerEmail column maps to the PCI-DSS-regulated Customer Email critical data element"
}
```

**Expected Response** (200 OK):
```json
{
  "relationshipType": "Related",
  "entityId": "10013344-5566-7788-99aa-bbccddeeff00",
  "description": "CustomerEmail column maps to the PCI-DSS-regulated Customer Email critical data element",
  "systemData": {
    "createdBy": "4e74f902-62f5-49f4-8258-92ed2b8537ba",
    "lastModifiedBy": "4e74f902-62f5-49f4-8258-92ed2b8537ba",
    "createdAt": "2026-03-20T12:10:00.000Z",
    "lastModifiedAt": "2026-03-20T12:10:00.000Z"
  }
}
```

Tag the `AccountNumber` column:

```http
POST /dataColumns/bbbbbb11-1111-2222-3333-444455556666/relationships?entityType=CRITICALDATAELEMENT
Content-Type: application/json
Authorization: Bearer {token}

{
  "relationshipType": "Related",
  "entityId": "10013344-5566-7788-99aa-bbccddeeff00",
  "description": "AccountNumber column maps to the PCI-DSS-regulated Customer Email critical data element"
}
```

**Expected Response** (200 OK):
```json
{
  "relationshipType": "Related",
  "entityId": "10013344-5566-7788-99aa-bbccddeeff00",
  "description": "AccountNumber column maps to the PCI-DSS-regulated Customer Email critical data element",
  "systemData": {
    "createdBy": "4e74f902-62f5-49f4-8258-92ed2b8537ba",
    "lastModifiedBy": "4e74f902-62f5-49f4-8258-92ed2b8537ba",
    "createdAt": "2026-03-20T12:10:30.000Z",
    "lastModifiedAt": "2026-03-20T12:10:30.000Z"
  }
}
```

#### **Step 5: Link the Data Asset to the "Payments Data Product"**

```http
POST /dataAssets/da001122-3344-5566-7788-99aabbccddee/relationships?entityType=DATAPRODUCT
Content-Type: application/json
Authorization: Bearer {token}

{
  "entityId": "90013344-5566-7788-99aa-bbccddeeff00",
  "relationshipType": "Related",
  "description": "transactions_prod is an underlying table powering the Payments Data Product"
}
```

**Expected Response** (200 OK):
```json
{
  "entityId": "90013344-5566-7788-99aa-bbccddeeff00",
  "relationshipType": "Related",
  "description": "transactions_prod is an underlying table powering the Payments Data Product",
  "systemData": {
    "createdBy": "4e74f902-62f5-49f4-8258-92ed2b8537ba",
    "lastModifiedBy": "4e74f902-62f5-49f4-8258-92ed2b8537ba",
    "createdAt": "2026-03-20T12:15:00.000Z",
    "lastModifiedAt": "2026-03-20T12:15:00.000Z"
  }
}
```

### **Success Criteria**
- ✅ Registered the production table as a governed data asset linked to Data Map
- ✅ Imported column schema (CustomerEmail, AccountNumber) into the catalog
- ✅ Tagged sensitive columns with critical data elements for PCI-DSS compliance
- ✅ Linked the data asset to the Payments Data Product for consumer discoverability

### **Value Delivered**
- **Compliance coverage**: Physical schema columns are mapped to regulatory critical data elements, providing an audit trail for PCI-DSS/GDPR obligations
- **Discoverability**: The data asset appears as a linked resource in the "Payments Data Product" so consumers know exactly which tables are involved
- **Lineage traceability**: Data Map provenance is preserved in every column (`source.columnId`), so the path from raw storage to governed catalog is always traceable

---

## 📋 **Scenario Priority Matrix**

| Scenario | Frequency | Business Impact | Technical Complexity |
|----------|-----------|-----------------|---------------------|
| Data Asset Discovery | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐ |
| Business Glossary | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| Data Products | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| Critical Data Elements | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| Domain & OKR Management | ⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| Asset Registration & Column Tagging | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |

These hero scenarios represent the most valuable and commonly used patterns for the Purview Data Catalog API, providing clear pathways for developers to achieve meaningful business outcomes.
