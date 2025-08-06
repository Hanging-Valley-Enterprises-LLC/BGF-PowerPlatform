# BGF-PowerPlatform
The place for VegProdMOS (VPM) development and deployment

## Project Overview

The Vegetable Production Management (VPM) system is a comprehensive Power Platform solution designed for agricultural operations, supporting the complete workflow from annual planning through harvest to sales fulfillment.

## Repository Structure

```
BGF-PowerPlatform/
├── solutions/                          # Power Platform Solutions
│   ├── VegetableProductionManagement/  # Model-driven app solution
│   ├── BGF-Canvas-Apps/               # Canvas applications
│   └── BGF-Common/                    # Shared components
├── power-bi/                          # Power BI Reports & Semantic Models
│   ├── reports/                       # .pbix files
│   ├── semantic-models/               # Dataset definitions
│   └── paginated-reports/             # .rdl files
├── flows/                             # Power Automate Flows
│   ├── solution-aware/                # Flows within solutions
│   └── standalone/                    # Independent flows
├── documentation/                     # Project Documentation
│   ├── business-processes/            # Process flows and requirements
│   ├── technical/                     # Architecture and design docs
│   └── deployment/                    # Setup and deployment guides
└── deployment/                        # CI/CD Scripts & Pipelines
    ├── scripts/                       # PowerShell/CLI scripts
    └── pipelines/                     # YAML pipeline definitions
```

## Business Context

### Core Process Areas
1. **Grower Annual Planning** - Season planning and forecasting
2. **Field Operations** - Direct seeding and transplanting
3. **Greenhouse Operations** - Seed starting and scheduling  
4. **Harvest Operations** - Product collection and quality control
5. **Production Operations** - Processing, washing, packing
6. **Sales Operations** - Order management and fulfillment

### Key Features
- Complete agricultural lifecycle management
- Harvest-to-order and harvest-to-inventory fulfillment
- Lot tracking and traceability
- QuickBooks integration
- Comprehensive reporting and analytics

## Development Environment

### Prerequisites
- Power Platform CLI (pac)
- Git
- Visual Studio Code (recommended)
- Power Platform Developer Plan

### Solution Management
Solutions are managed using Power Platform CLI:
```bash
# Unpack solution for source control
pac solution unpack --zipfile solution.zip --folder solutions/VegetableProductionManagement

# Pack solution for deployment  
pac solution pack --folder solutions/VegetableProductionManagement --zipfile solution.zip
```

## Deployment Strategy

### Solution Architecture
- **VegetableProductionManagement**: Core model-driven application (AppSource ready)
- **BGF-Canvas-Apps**: Canvas applications with independent release cycles
- **BGF-Common**: Shared components and configurations

### Environments
- **Development**: Individual developer environments
- **Test**: Shared testing environment
- **Production**: Live operational environment

## Ownership & Licensing

### Co-Ownership Structure
This codebase is co-owned by:
- **Hanging Valley Enterprises, LLC (HVE)** - Development lead
- **Boldly Grown Farm LLC (BGF)** - Launch customer and co-owner

### Microsoft Partner Status
- **HVE**: Microsoft Partner #5006632 (Partner Launch Benefits)
- **BGF**: Microsoft Partner #6969240 (Partner Success Core Benefits)

### AppSource Publishing
- Target marketplace: Microsoft AppSource
- Primary offer: Vegetable Production and Sales Management Operating System
- Status: In development

## Getting Started

### Initial Setup
1. Clone this repository
2. Install Power Platform CLI
3. Connect to your Power Platform environment
4. Review documentation in `/documentation/`

### Contributing
Currently in alpha development with limited contributors. Full contribution guidelines will be established as the team expands.

## Migration Notes

**Repository Migration Planning**: This repository may be migrated from individual ownership to BGF organizational account as the project scales. All naming conventions and structure are designed to support seamless migration.

## Contact & Support

### Primary Development Contact
- **Mark Slosberg** - Principal, Hanging Valley Enterprises, LLC
- Email: markslosberg@hangingvalley.com

### Business Contact  
- **Boldly Grown Farm LLC** - Launch Customer
- Implementation and operational feedback

---

## Project Status

**Current Phase**: Sales Order Line Item table migration and repository structure setup
**Next Milestone**: Complete Power BI report inventory and dependency mapping
**Target**: AppSource publication ready solution

---

*Last Updated: [Current Date]*  
*Repository Version: 1.0 (Initial Setup)*
