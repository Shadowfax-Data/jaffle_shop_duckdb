# Jaffle Shop Data Warehouse

## Project Overview

The Jaffle Shop project is a dbt (data build tool) implementation that creates a robust data transformation pipeline for a retail business specializing in jaffles (grilled sandwiches). This data warehouse project transforms raw customer, order, and payment data into meaningful business insights, with a particular focus on customer behavior and lifetime value analysis.

### Project Purpose

The primary objectives of this data warehouse are to:
- Transform raw customer and transaction data into clean, analytics-ready datasets
- Calculate key business metrics including customer lifetime value
- Provide a single source of truth for business reporting and analysis
- Enable data-driven decision making for the Jaffle Shop business

### Main Components

The project is structured into several key components:

1. **Staging Layer**
   - Raw data transformation and standardization
   - Three staging models: customers, orders, and payments
   - Implemented as views for efficient storage and processing

2. **Core Models Layer**
   - Two primary analytical models: customers and orders
   - Combines and transforms staging data into business-ready tables
   - Materialized as tables for optimal query performance

3. **Project Configuration**
   - DBT version requirements: >=1.0.0, <2.0.0
   - Modular project structure with separate staging and core layers
   - Comprehensive data testing and documentation

### High-Level Architecture

The data transformation pipeline follows a modular, layered architecture:

```
Raw Data Sources
      ↓
Staging Layer (Views)
  ├── stg_customers
  ├── stg_orders
  └── stg_payments
      ↓
Core Models (Tables)
  ├── customers
  └── orders
```

This architecture ensures:
- Clear separation of concerns between raw data, staging, and final models
- Efficient data processing with appropriate materialization strategies
- Scalable and maintainable codebase
- Robust testing and validation at each layer

The staging layer is materialized as views to maintain flexibility and storage efficiency, while core models are materialized as tables to optimize query performance for end-users. This design supports both efficient processing and reliable analytics capabilities.

## Data Models

### Staging Models

The staging layer consists of three key models that perform initial data transformation and standardization. These models are materialized as views for optimal storage and processing efficiency.

#### stg_customers
This model transforms raw customer data into a standardized format:
- Sources data from `raw_customers`
- Key transformations:
  - Renames `id` to `customer_id` for consistency
  - Preserves customer attributes: first_name, last_name
- Provides a clean, standardized view of customer information

#### stg_orders
This model standardizes order transaction data:
- Sources data from `raw_orders`
- Key transformations:
  - Renames `id` to `order_id` for clarity
  - Maps `user_id` to `customer_id` for consistency with customer model
  - Maintains order_date and status information
- Creates a consistent view of order transactions

#### stg_payments
This model handles payment-related transformations:
- Sources data from `raw_payments`
- Key transformations:
  - Renames `id` to `payment_id`
  - Converts amount from cents to dollars (divides by 100)
  - Preserves payment_method and order_id for transaction tracking
- Standardizes payment information for financial analysis

Each staging model follows a consistent pattern using CTEs (Common Table Expressions):
1. `source` CTE: Extracts data from raw tables
2. `renamed` CTE: Applies column renaming and basic transformations
3. Final select: Exposes the transformed data

The staging models serve as a foundation for the core analytical models, ensuring data consistency and standardization across the entire pipeline.

### Core Models

The core models layer transforms the standardized staging data into business-ready analytical tables. These models implement complex business logic and calculate key metrics for the Jaffle Shop business.

#### customers
The customers model is the primary analytical table for customer analysis and lifetime value calculations:

- **Source Models**: 
  - stg_customers
  - stg_orders
  - stg_payments

- **Key Transformations**:
  1. Customer Order Metrics:
     - First order date
     - Most recent order date
     - Total number of orders
  2. Customer Value Calculations:
     - Customer lifetime value (total amount of all orders)
  3. Combined Customer Profile:
     - Basic information (first_name, last_name)
     - Order history metrics
     - Lifetime value metrics

The model uses several CTEs to build the final customer profile:
- `customer_orders`: Aggregates order history metrics per customer
- `customer_payments`: Calculates total payment amounts per customer
- `final`: Combines all customer information into a comprehensive profile

#### orders
The orders model provides a detailed view of each order with payment breakdowns:

- **Source Models**:
  - stg_orders
  - stg_payments

- **Key Transformations**:
  1. Payment Method Analysis:
     - Breaks down payment amounts by method (credit_card, coupon, bank_transfer, gift_card)
     - Calculates total amount per order
  2. Order Details:
     - Basic order information (order_date, status)
     - Customer association
     - Payment method amounts
     - Total order amount

The model uses a dynamic approach with Jinja templating to handle multiple payment methods:
- Generates separate columns for each payment method amount
- Provides flexible payment analysis capabilities
- Maintains order status and customer relationship data

Both core models are materialized as tables to optimize query performance for business users. They provide a comprehensive view of the business's key entities (customers and orders) with all necessary metrics and relationships for analysis and reporting.

## Technical Implementation

### Materialization Strategy

The project implements a carefully designed materialization strategy to balance performance and resource utilization:

- **Staging Models**: All staging models are materialized as views (`materialized: view` in staging config)
  - Ensures data freshness by always pulling from source
  - Reduces storage overhead since no data is persisted
  - Appropriate for intermediate transformations

- **Core Models**: All core models are materialized as tables (`materialized: table` in root config)
  - Optimizes query performance for end-user access
  - Persists transformed data for faster retrieval
  - Suitable for frequently accessed analytical models

### Project Configuration

The project configuration is defined in `dbt_project.yml` with the following key settings:

- **Project Information**:
  - Name: jaffle_shop
  - Version: 0.1
  - Config Version: 2

- **dbt Version Requirements**:
  - Minimum Version: 1.0.0
  - Maximum Version: <2.0.0

- **Resource Paths**:
  - Models: models/
  - Seeds: seeds/
  - Tests: tests/
  - Analysis: analysis/
  - Macros: macros/

- **Documentation Settings**:
  - Staging models: Silver node color
  - Core models: Gold node color
  - Seeds: Bronze node color

### Project Structure

The project follows dbt best practices with a clear separation of concerns:

```
jaffle_shop/
├── models/
│   ├── staging/      # View materializations
│   └── core/         # Table materializations
├── seeds/            # Static data files
├── tests/            # Custom data tests
├── analysis/         # Ad-hoc analyses
├── macros/          # Reusable code blocks
└── target/          # Compiled SQL and artifacts
```

### Build and Test Process

The project includes several clean-targets for maintaining a healthy development environment:
- target/
- dbt_modules/
- logs/

This ensures that compiled artifacts and logs can be easily cleaned and regenerated during development and deployment.

## CI/CD Process

The project implements a robust Continuous Integration and Continuous Deployment (CI/CD) process through GitHub Actions, ensuring the data warehouse functions correctly across different platforms and environments.

### Platform Validation Workflow

The repository includes a comprehensive GitHub Actions workflow (`validate_on_platforms.yml`) that automatically validates the project's functionality across multiple operating systems and shell environments:

#### Supported Platforms
- macOS (Latest)
- Linux (Ubuntu Latest)
  - Bash shell
  - PowerShell Core
- Windows (Latest)
  - PowerShell
  - Command Prompt (cmd.exe)

#### Validation Process
Each platform runs through a complete deployment and validation sequence:

1. **Environment Setup**
   - Python 3.8.x installation
   - Virtual environment creation
   - Dependencies installation via requirements.txt

2. **DBT Validation**
   - Version verification
   - Debug checks
   - Full model build
   - Documentation generation

3. **Data Validation**
   - Sample query execution against the DuckDB database
   - Verification of customer data integrity

### Workflow Triggers
The CI/CD pipeline is activated on:
- Push events to the 'duckdb' branch
- Pull requests targeting the 'duckdb' branch

This comprehensive validation ensures that the Jaffle Shop data warehouse maintains consistent functionality across all supported platforms and development environments, reducing the risk of environment-specific issues and ensuring reliable deployments.