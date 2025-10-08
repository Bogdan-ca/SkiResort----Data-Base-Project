# Ski-Resort Booking System - Database Project

## Overview
A comprehensive Oracle database management system designed to handle the complete operational workflow of a ski resort. The system manages cabin and room reservations, equipment rentals, ski lesson bookings, and provides advanced analytics for business intelligence.

Developed as a university project to demonstrate practical database design, implementation, and optimization techniques in a real-world business context.

## Features
- **Reservation Management**: Complete booking system for cabins, rooms, and accommodations
- **Equipment Rental Tracking**: Inventory management and rental history for ski equipment
- **Ski Lesson Scheduling**: Instructor assignment and lesson booking functionality
- **Revenue Analytics**: Pre-computed materialized views for financial reporting
- **Performance Optimization**: Oracle INMEMORY column store and result cache implementation
- **Data Integrity**: Comprehensive constraints, sequences, and referential integrity rules
- **Business Intelligence**: Complex analytical queries for customer insights and revenue tracking

## Technologies
- **Oracle Database 19c** - Primary relational database management system
- **PL/SQL** - Stored procedures, functions, and database logic
- **SQL** - Complex analytical queries with CTEs, window functions, and correlated subqueries
- **MongoDB** - NoSQL prototype for architectural comparison
- **Oracle SQL Developer** - Database IDE and management tool

## Database Schema
The system consists of 10+ interconnected tables modeling the complete ski-resort domain:

| Table | Description |
|-------|-------------|
| `Cabana` | Cabin information, capacity, and amenities |
| `Camera` | Individual room details and assignments |
| `Rezervare` | Master reservation records with customer info |
| `Rezervare_Camera` | Room-specific reservation details |
| `Schior` | Customer/skier profiles and contact information |
| `Inchiriere` | Equipment rental transactions and pricing |
| `Lectie_Schi` | Ski lesson bookings and instructor assignments |
| `Tip_Camera` | Room type definitions and pricing tiers |
| `Tip_Calitate` | Quality/rating classifications |
| `Rezervare_Echipament` | Equipment reservation associations |

## Project Structure

```
📁 Ski-Resort Database Project
├── 10-11.sql                              # Schema definition (DDL)
├── 11-inserare.sql                        # Sample data population
├── 12.sql                                 # Analytical queries and reports
├── 18.sql                                 # Additional query examples
├── 20.sql                                 # PL/SQL functions & materialized views
├── 141_caraeane_bogdan-andrei-creeare_inserare.txt  # Complete setup script
├── 141_caraeane_bogdan-andrei-exemple.txt           # Query examples
├── 141_caraeane_bogdan-andrei-18.txt      # Query set 18
├── 141_caraeane_bogdan-andrei-19.txt      # MongoDB prototype
├── 141_caraeane_bogdan-andrei-20.txt      # Advanced features demo
└── 141_caraeane_bogdan-andrei-proiect.pdf # Project documentation
```

## Key Files

### Schema & Data
- **`10-11.sql`** - Complete DDL for tables, sequences, constraints, and indexes
- **`11-inserare.sql`** - Sample data insertion scripts for testing
- **`141_caraeane_bogdan-andrei-creeare_inserare.txt`** - Combined schema and data setup

### Queries & Analytics
- **`12.sql`** - Complex analytical queries (revenue reports, customer analytics)
- **`18.sql`** - Additional reporting queries
- **`141_caraeane_bogdan-andrei-exemple.txt`** - Comprehensive query examples

### Advanced Features
- **`20.sql`** - PL/SQL functions, materialized views, performance optimization demos
- **`141_caraeane_bogdan-andrei-19.txt`** - MongoDB NoSQL prototype
- **`141_caraeane_bogdan-andrei-20.txt`** - Oracle INMEMORY and result cache demonstrations

## Setup Instructions

### Prerequisites
- Oracle Database 19c or higher
- SQL*Plus or Oracle SQL Developer
- Database privileges: `CREATE TABLE`, `CREATE SEQUENCE`, `CREATE VIEW`, `CREATE MATERIALIZED VIEW`, `CREATE FUNCTION`

### Installation

1. **Connect to your Oracle database**
   ```sql
   sqlplus username/password@database
   ```

2. **Create the schema**
   ```sql
   @10-11.sql
   ```

3. **Populate sample data**
   ```sql
   @11-inserare.sql
   ```

4. **Create advanced features (optional)**
   ```sql
   @20.sql
   ```

### Alternative: Complete Setup
Run the combined script for full installation:
```sql
@141_caraeane_bogdan-andrei-creeare_inserare.txt
```

## Key Implementations

### PL/SQL Function: `get_tip_camera_rate`
Calculates room rates dynamically based on room type, quality, and season:
```sql
SELECT get_tip_camera_rate(room_type_id, quality_id) FROM dual;
```

### Materialized View: `mv_rezervari_cabane`
Pre-computed aggregation of cabin reservations for fast reporting:
```sql
SELECT * FROM mv_rezervari_cabane WHERE cabana_id = 1;
```

### Performance Features
- **Result Cache**: Function-level caching for frequently accessed calculations
- **INMEMORY Column Store**: Experimental in-memory processing for analytics
- **V$ Views**: Performance monitoring and query optimization

## Sample Queries

### Top Spending Customers
```sql
SELECT s.nume, s.prenume, SUM(r.pret_total) as total_spent
FROM Schior s
JOIN Rezervare r ON s.id_schior = r.id_schior
GROUP BY s.nume, s.prenume
ORDER BY total_spent DESC
FETCH FIRST 10 ROWS ONLY;
```

### Cabin Revenue Analysis
```sql
SELECT c.nume_cabana, COUNT(rc.id_rezervare) as total_reservations,
       SUM(r.pret_total) as total_revenue
FROM Cabana c
JOIN Camera cam ON c.id_cabana = cam.id_cabana
JOIN Rezervare_Camera rc ON cam.id_camera = rc.id_camera
JOIN Rezervare r ON rc.id_rezervare = r.id_rezervare
GROUP BY c.nume_cabana
ORDER BY total_revenue DESC;
```

### Equipment Utilization
```sql
SELECT e.tip_echipament, COUNT(*) as rental_count,
       AVG(i.pret) as avg_price
FROM Echipament e
JOIN Inchiriere i ON e.id_echipament = i.id_echipament
GROUP BY e.tip_echipament;
```

## Learning Outcomes

This project demonstrates:
- ✅ **Database Design**: Normalized schema design with proper relationships and constraints
- ✅ **Data Integrity**: Implementation of business rules through database constraints
- ✅ **Performance Optimization**: Materialized views, indexing, and caching strategies
- ✅ **Complex Queries**: CTEs, window functions, and analytical SQL
- ✅ **PL/SQL Programming**: Functions, procedures, and database logic
- ✅ **Database Administration**: Data loading, backup/restore strategies
- ✅ **Technology Evaluation**: Comparison of relational (Oracle) vs NoSQL (MongoDB) approaches

## NoSQL Comparison

A MongoDB prototype was developed to evaluate alternative architectural approaches:
- Document-based modeling vs relational normalization
- Query performance trade-offs
- Schema flexibility vs data integrity
- Use case analysis for polyglot persistence

See `141_caraeane_bogdan-andrei-19.txt` for implementation details.

## Future Enhancements
- [ ] RESTful API layer for web/mobile integration
- [ ] Real-time availability checking with triggers
- [ ] Payment processing integration
- [ ] Customer loyalty program tracking
- [ ] Predictive analytics for demand forecasting
- [ ] Multi-language support for international customers

## Author
**Bogdan-Andrei Caraeane** - Group 141  
Database Systems Course - Year 1, Semester 2  
University Project

## License
This project is part of academic coursework. Please reference appropriately if used for educational purposes.

## Acknowledgments
- Oracle Database documentation and best practices
- University Database Systems course materials
- SQL performance tuning resources

---

