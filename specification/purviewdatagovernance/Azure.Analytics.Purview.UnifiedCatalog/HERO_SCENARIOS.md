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
- Purview Unified Catalog endpoint configured
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

## 📋 **Scenario Priority Matrix**

| Scenario | Frequency | Business Impact | Technical Complexity |
|----------|-----------|-----------------|---------------------|
| Data Asset Discovery | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐ |
| Business Glossary | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| Data Products | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| Critical Data Elements | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| Domain & OKR Management | ⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |

These hero scenarios represent the most valuable and commonly used patterns for the Purview Data Catalog API, providing clear pathways for developers to achieve meaningful business outcomes.
