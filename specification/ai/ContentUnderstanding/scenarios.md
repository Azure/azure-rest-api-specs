# Champion Scenarios

## Automated Invoice Processing Pipeline

**Customer Value:** Transform manual invoice processing into a fully automated AP workflow that reduces processing time from hours to minutes while improving accuracy and audit trails.

**Business Scenario:** A finance team receives hundreds of invoices daily via email, web uploads, and cloud storage. They need to extract key data, validate information, and route invoices to the appropriate approval workflows based on vendor, amount, and department.

**Complete HTTP Workflow:**

```http
@endpoint = {{$dotenv CONTENT_UNDERSTANDING_ENDPOINT}}
@apiVersion = 2025-05-01-preview
@bearerToken = {{$dotenv BEARER_TOKEN}}
@invoiceUrl = {{$dotenv INVOICE_DOCUMENT_URL}}

### Step 1: Create or Replace Analyzer (invoice)
# @name createInvoiceAnalyzer
PUT {{endpoint}}/contentunderstanding/analyzers/invoice-analyzer?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "description": "Invoice field extractor",
  "baseAnalyzerId": "prebuilt-documentAnalyzer",
  "config": {
    "enableOcr": true,
    "enableLayout": true,
    "returnDetails": true
  },
  "fieldSchema": {
    "name": "InvoiceSchema",
    "description": "Core invoice fields + line items",
    "fields": {
      "InvoiceId":        { "type": "string", "description": "Invoice number" },
      "InvoiceDate":      { "type": "date"   },
      "DueDate":          { "type": "date"   },
      "VendorName":       { "type": "string" },
      "VendorAddress":    { "type": "string" },
      "BillToName":       { "type": "string" },
      "SubTotal":         { "type": "number" },
      "TotalTax":         { "type": "number" },
      "InvoiceTotal":     { "type": "number" },
      "Currency":         { "type": "string" },
      "LineItems": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "Description": { "type": "string" },
            "Quantity":    { "type": "number" },
            "UnitPrice":   { "type": "number" },
            "Amount":      { "type": "number" }
          }
        }
      }
    },
    "definitions": {}
  }
}

### Poll analyzer creation
# @name pollInvoiceAnalyzerCreate
GET {{createInvoiceAnalyzer.response.headers.Operation-Location}}
Authorization: Bearer {{bearerToken}}

### Step 2: Create or Replace Classifier (invoice-classifier)
# @name createInvoiceClassifier
PUT {{endpoint}}/contentunderstanding/classifiers/invoice-classifier?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "description": "Inbox triage for AP",
  "splitMode": "auto",
  "categories": {
    "Invoice":        { "analyzerId": "invoice-analyzer" },
    "Receipt":        {},
    "PurchaseOrder":  {},
    "Contract":       {},
    "Other":          {}
  }
}

### Poll classifier creation
# @name pollInvoiceClassifierCreate
GET {{createInvoiceClassifier.response.headers.Operation-Location}}
Authorization: Bearer {{bearerToken}}

### Step 3: Classify document by URL
# @name classifyInvoiceDoc
POST {{endpoint}}/contentunderstanding/classifiers/invoice-classifier:classify?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{ "url": "{{invoiceUrl}}" }

### Step 4: Get Classification Result
# @name getClassificationResult
GET {{classifyInvoiceDoc.response.headers.Operation-Location}}
Authorization: Bearer {{bearerToken}}

// Response: 200 OK
// { "category": "Invoice", "confidence": 0.98, "pages": [1], "id": "res-cls-invoice-001" }

### Step 5: Extract Invoice Data (Since Classified as Invoice)
# @name analyzeInvoice
POST {{endpoint}}/contentunderstanding/analyzers/invoice-analyzer:analyze?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
    "url": "{{invoiceUrl}}"
}

### Step 6: Retrieve Extracted Invoice Fields
# @name getInvoiceResults
GET {{analyzeInvoice.response.headers.Operation-Location}}
Authorization: Bearer {{bearerToken}}

// Response: 200 OK
// {
//   "id": "res-ana-invoice-001",
//   "fields": {
//     "InvoiceId": "INV-2025-001",
//     "InvoiceDate": "2025-08-15",
//     "DueDate": "2025-09-14",
//     "VendorName": "Contoso Supplies Ltd",
//     "VendorAddress": "123 Business Park, Seattle, WA 98101",
//     "BillToName": "Fabrikam Corp",
//     "SubTotal": 1250.00,
//     "TotalTax": 125.00,
//     "InvoiceTotal": 1375.00,
//     "Currency": "USD",
//     "LineItems": [
//       { "Description": "Office Supplies - Paper & Pens", "Quantity": 50, "UnitPrice": 15.00, "Amount": 750.00 },
//       { "Description": "Printer Cartridges - HP LaserJet", "Quantity": 10, "UnitPrice": 50.00, "Amount": 500.00 }
//     ]
//   },
//   "confidence": { "InvoiceTotal": 0.99, "VendorName": 0.96, "InvoiceDate": 0.98 }
// }
```

---

## Custom Document Understanding for HR Employee Onboarding

**Customer Value:** Streamline employee onboarding by automatically extracting data from diverse HR documents (contracts, forms, certifications) and populating HRIS systems without manual data entry.

**Business Scenario:** An HR department processes employment contracts, background check forms, tax documents, and certifications. Each document type has different fields, and manual extraction is error-prone and time-consuming.

**Complete HTTP Workflow:**

```http
@endpoint = {{$dotenv CONTENT_UNDERSTANDING_ENDPOINT}}
@apiVersion = 2025-05-01-preview
@bearerToken = {{$dotenv BEARER_TOKEN}}
@analyzerId = employment-contract-analyzer
@contractFile = {{$dotenv CONTRACT_FILE_PATH}}

### Step 1: Create Custom Employment Contract Analyzer
# @name createHRAnalyzer
PUT {{endpoint}}/contentunderstanding/analyzers/{{analyzerId}}?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "description": "Employment contract extractor",
  "baseAnalyzerId": "prebuilt-documentAnalyzer",
  "config": { "enableOcr": true, "enableLayout": true, "returnDetails": true },
  "fieldSchema": {
    "name": "EmploymentContract",
    "fields": {
      "EmployeeId":     { "type": "string" },
      "FullName":       { "type": "string" },
      "Position":       { "type": "string" },
      "Department":     { "type": "string" },
      "StartDate":      { "type": "date"   },
      "Salary":         { "type": "number" },
      "ManagerName":    { "type": "string" },
      "WorkLocation":   { "type": "string" },
      "EmploymentType": { "type": "string" },
      "Benefits":       { "type": "array", "items": { "type": "string" } }
    },
    "definitions": {}
  }
}

### Step 2: Analyze Employment Contract
# @name analyzeContract
POST {{endpoint}}/contentunderstanding/analyzers/{{analyzerId}}:analyze?_overload=analyzeBinary&api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/pdf

< {{contractFile}}

### Step 3: Poll Analysis Status
# @name checkAnalysisStatus
GET {{analyzeContract.response.headers.Operation-Location}}
Authorization: Bearer {{bearerToken}}

// Response: 200 OK
// {
//   "id": "res-ana-hr-001",
//   "fields": {
//     "EmployeeId": "EMP-2025-0847",
//     "FullName": "Sarah Johnson",
//     "Position": "Senior Software Engineer",
//     "Department": "Engineering",
//     "StartDate": "2025-09-15",
//     "Salary": 125000,
//     "ManagerName": "Michael Chen",
//     "WorkLocation": "Seattle, WA / Remote Hybrid",
//     "EmploymentType": "Full-time",
//     "Benefits": ["Health Insurance", "401k Match", "Stock Options", "Flexible PTO"]
//   },
//   "confidence": { "EmployeeId": 0.99, "FullName": 0.98, "Salary": 0.96, "StartDate": 0.99 }
// }
```

---

## Intelligent Security & Identity Verification

**Customer Value:** Build secure, automated identity verification systems for access control, visitor management, and compliance monitoring using face detection and person identification.

**Business Scenario:** A corporate office needs to manage employee access, track visitor entry, and monitor compliance with security protocols. The system should identify known employees, flag unknown persons, and maintain audit logs.

**Complete HTTP Workflow:**

```http
@endpoint = {{$dotenv CONTENT_UNDERSTANDING_ENDPOINT}}
@apiVersion = 2025-05-01-preview
@bearerToken = {{$dotenv BEARER_TOKEN}}
@securityImageUrl = {{$dotenv SECURITY_CAMERA_IMAGE_URL}}
@employeePhotoUrl = {{$dotenv EMPLOYEE_PHOTO_URL}}

### Step 1: Create Employee Directory
# @name createDirectory
PUT {{endpoint}}/contentunderstanding/personDirectories/corp-emp-2025?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "description": "Corporate Employees 2025",
  "tags": { "facility": "HQ-Seattle", "purpose": "AccessControl" }
}

### Step 2: Add Face to Directory
# @name addEmployeeFace
POST {{endpoint}}/contentunderstanding/personDirectories/corp-emp-2025/faces?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "faceSource": {
    "url": "{{employeePhotoUrl}}"
  },
  "imageReferenceId": "EMP001-profile"
}

### Step 3: Add Person (with registered faceIds)
# @name addEmployee
POST {{endpoint}}/contentunderstanding/personDirectories/corp-emp-2025/persons?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "tags": {
    "name": "John Smith",
    "employeeId": "EMP001",
    "department": "Engineering",
    "accessLevel": "Level-3"
  },
  "faceIds": [ "{{addEmployeeFace.response.body.faceId}}" ]
}

// Response: 201 Created
// { "personId": "person-emp001", "tags": { "name": "John Smith", "employeeId": "EMP001" } }

### Step 4: Detect Faces in Security Camera Feed
# @name detectFaces
POST {{endpoint}}/contentunderstanding/faces:detect?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "url": "{{securityImageUrl}}",
  "maxDetectedFaces": 10
}

// Response: 200 OK
// {
//   "faces": [
//     { "faceId": "det-face-001", "boundingBox": { "left": 150, "top": 100, "width": 180, "height": 220 } }
//   ]
// }

### Step 5: Identify Person Against Employee Directory
# @name identifyPerson
POST {{endpoint}}/contentunderstanding/personDirectories/corp-emp-2025/persons:identify?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "faceSource": { "url": "{{securityImageUrl}}" },
  "maxPersonCandidates": 1
}

// Response: 200 OK
// {
//   "candidates": [
//     { "personId": "person-emp001", "confidence": 0.96 }
//   ]
// }
```

---

## Multi-Modal Content Analysis for Digital Asset Management

**Customer Value:** Automatically organize, categorize, and extract metadata from diverse digital content (documents, images, videos) to build searchable digital asset libraries and enable content governance.

**Business Scenario:** A marketing team manages thousands of digital assets including campaign materials, product photos, legal documents, and brand guidelines. They need automated tagging, content extraction, and compliance monitoring.

**Complete HTTP Workflow:**

```http
@endpoint = {{$dotenv CONTENT_UNDERSTANDING_ENDPOINT}}
@apiVersion = 2025-05-01-preview
@bearerToken = {{$dotenv BEARER_TOKEN}}
@classifierId = digital-asset-classifier
@campaignImageUrl = {{$dotenv CAMPAIGN_IMAGE_URL}}
@brandGuidelinesUrl = {{$dotenv BRAND_GUIDELINES_URL}}
@campaignImageFile = {{$dotenv CAMPAIGN_IMAGE_FILE_PATH}}

### Step 1: Create Content Type Classifier
# @name createContentClassifier
PUT {{endpoint}}/contentunderstanding/classifiers/{{classifierId}}?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "description": "DAM classifier",
  "splitMode": "noSplit",
  "categories": {
    "Marketing-Material":    {},
    "Product-Photo":         {},
    "Legal-Document":        {},
    "Brand-Guidelines":      {},
    "Technical-Specification": {},
    "Customer-Content":      {}
  }
}

### Step 2: Classify Marketing Campaign Image
# @name classifyImage
POST {{endpoint}}/contentunderstanding/classifiers/{{classifierId}}:classify?_overload=classifyBinary&api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: image/jpeg

< {{campaignImageFile}}

### Step 3: Get Content Classification
# @name getContentClassification
GET {{classifyImage.response.headers.Operation-Location}}
Authorization: Bearer {{bearerToken}}

// Response: 200 OK
// { "category": "Marketing-Material", "confidence": 0.95, "id": "res-cls-dam-001" }

### Step 4: Detect People in Marketing Image
# @name detectPeopleInImage
POST {{endpoint}}/contentunderstanding/faces:detect?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{ "url": "{{campaignImageUrl}}" }


// Response: 200 OK
// {
//   "faces": [
//     { "faceId": "dam-face-001", "boundingBox": { "left": 200, "top": 150, "width": 180, "height": 220 } },
//     { "faceId": "dam-face-002", "boundingBox": { "left": 450, "top": 180, "width": 160, "height": 200 } }
//   ]
// }

### Step 5: Analyze Associated Brand Guidelines Document
# @name analyzeBrandDoc
POST {{endpoint}}/contentunderstanding/analyzers/prebuilt-documentAnalyzer:analyze?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{ "url": "{{brandGuidelinesUrl}}" }

### Step 6: Retrieve Brand Guidelines Analysis
# @name getBrandAnalysis
GET {{analyzeBrandDoc.response.headers.Operation-Location}}
Authorization: Bearer {{bearerToken}}

// Response: 200 OK
// {
//   "id": "res-ana-brand-001",
//   "fields": {
//     "DocumentTitle": "Contoso Brand Guidelines 2025",
//     "Version": "v3.2",
//     "LastUpdated": "2025-08-01",
//     "BrandColors": ["#FF6B35", "#004E89", "#FFFFFF"],
//     "Typography": ["Segoe UI", "Arial", "Helvetica"],
//     "LogoUsage": "Primary logo must maintain 1:1 aspect ratio"
//   },
//   "pages": [{ "pageNumber": 1, "sections": ["Logo Usage", "Color Palette", "Typography", "Photography Style"] }]
// }
```

---

## Regulatory Compliance & Document Audit Pipeline

**Customer Value:** Ensure regulatory compliance by automatically scanning, classifying, and monitoring documents for compliance violations, sensitive data, and audit trail requirements.

**Business Scenario:** A financial services company must maintain compliance with regulations like SOX, GDPR, and industry standards. They need to scan thousands of documents, identify sensitive information, ensure proper retention, and generate audit reports.

**Complete HTTP Workflow:**

```http
@endpoint = {{$dotenv CONTENT_UNDERSTANDING_ENDPOINT}}
@apiVersion = 2025-05-01-preview
@bearerToken = {{$dotenv BEARER_TOKEN}}
@complianceClassifier = compliance-classifier
@financialAnalyzer = financial-document-analyzer
@financialDocUrl = {{$dotenv FINANCIAL_DOCUMENT_URL}}

### Step 1: Create Compliance Document Classifier
# @name createComplianceClassifier
PUT {{endpoint}}/contentunderstanding/classifiers/{{complianceClassifier}}?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "description": "Compliance triage",
  "splitMode": "noSplit",
  "categories": {
    "Financial-Statement": {},
    "Customer-Agreement":  {},
    "Privacy-Policy":      {},
    "Audit-Report":        {},
    "Employee-Record":     {},
    "Regulatory-Filing":   {}
  }
}

// Response: {"operationId": "classifier-create-compliance-001"}

### Step 2: Create Custom Analyzer for Financial Documents
# @name createFinancialAnalyzer
PUT {{endpoint}}/contentunderstanding/analyzers/{{financialAnalyzer}}?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{
  "description": "Financial doc compliance extractor",
  "baseAnalyzerId": "prebuilt-documentAnalyzer",
  "config": {
    "enableOcr": true,
    "enableLayout": true,
    "returnDetails": true
  },
  "fieldSchema": {
    "name": "FinancialCompliance",
    "fields": {
      "DocumentType":       { "type": "string" },
      "CompanyName":        { "type": "string" },
      "ReportingPeriod":    { "type": "string" },
      "AuditorName":        { "type": "string" },
      "ComplianceStatus":   { "type": "string" },
      "RevenueFigures":     { "type": "array", "items": { "type": "string" } },
      "SignatoryNames":     { "type": "array", "items": { "type": "string" } },
      "ConfidentialityLevel": { "type": "string" },
      "RetentionPeriod":    { "type": "string" }
    },
    "definitions": {}
  }
}

// Response: {"operationId": "analyzer-create-financial-001"}

### Step 3: Classify Uploaded Financial Document
# @name classifyFinancialDoc
POST {{endpoint}}/contentunderstanding/classifiers/{{complianceClassifier}}:classify?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{ "url": "{{financialDocUrl}}" }

### Step 4: Get Document Classification
# @name getDocumentClassification
GET {{classifyFinancialDoc.response.headers.Operation-Location}}
Authorization: Bearer {{bearerToken}}

// Response: 200 OK
// { "category": "Financial-Statement", "confidence": 0.97, "id": "res-cls-finance-001" }

### Step 5: Analyze Financial Document for Compliance Data
# @name analyzeFinancialDoc
POST {{endpoint}}/contentunderstanding/analyzers/{{financialAnalyzer}}:analyze?api-version={{apiVersion}}
Authorization: Bearer {{bearerToken}}
Content-Type: application/json

{ "url": "{{financialDocUrl}}" }

### Step 6: Retrieve Compliance Analysis Results
# @name getComplianceResults
GET {{analyzeFinancialDoc.response.headers.Operation-Location}}
Authorization: Bearer {{bearerToken}}

// Response: 200 OK
// {
//   "id": "res-ana-finance-001",
//   "fields": {
//     "DocumentType": "Quarterly Financial Statement",
//     "CompanyName": "Contoso Financial Services Inc.",
//     "ReportingPeriod": "Q3 2025 (Jul–Sep 2025)",
//     "AuditorName": "Deloitte & Touche LLP",
//     "ComplianceStatus": "SOX Compliant",
//     "RevenueFigures": ["$45.2M", "$42.8M", "$38.9M"],
//     "SignatoryNames": ["John Anderson - CEO", "Sarah Kim - CFO", "Michael Rodriguez - Controller"],
//     "ConfidentialityLevel": "Internal - Financial",
//     "RetentionPeriod": "7 years per SOX requirements"
//   },
//   "complianceValidation": { "requiredSignatures": "complete", "auditTrail": "verified", "dataIntegrity": "passed" },
//   "auditMetadata": { "processedDateTime": "2025-09-02T16:20:00Z", "frameworks": ["SOX", "SEC-10Q"] }
// }
```
