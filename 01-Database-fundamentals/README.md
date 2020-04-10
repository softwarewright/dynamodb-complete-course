# Database Fundamentals

## Relational Databases

**Table**

- collection of columns and rows
- Tables contain related and well structured data
- Rows are records within a table, each thing has a row
- Columns are the fields - they store information for each record

**Keys**

- Primary, candidate, and foreign
- Candidate keys - any column which can uniquely identify a row
- Primary keys - one candidate key, selected to provide unique identification
- Foreign key - Uniquely identifies a row in another table, the primary key in another table

### Simple SQL

- DDL - data definition language
- DML - Data manipulation language
- DCL - Data control language

``` sql
SELECT X
FROM Y
WHERE CONDITION
ORDER BY SOMETHING
```

``` sql
UPDATE EMPLOYEES SET Salary=70,000 WHERE ID = 1
```

``` sql
DELETE FROM EMPLOYEES 
WHERE Department = 'IT' or Department = 'SECURITY'
```

### Relationships

- One-To-One
- One-To-Many
- Many-to-Many - Usually done through a composite key

### Performance

- Accepts, runs and returns data from a SQL query
    - SQL qurt is broken into logical blocks
    - A Sequence tree is build
    - Builds execution plan
    - Executes that plan
    - Requests data
    - Processes returned data and returns a query result
- Reads data
- Writes data
- Caches data
- Organize operations  for efficiency

### Scaling

- Horizontal - Warning there is a limit to the size of the instance
- Cluster - Writer and Readers
- Sharding - Separate the into separate databases by a sharding id,Cross table queries become difficult to impossible

## Normalization

*Prepares data to be stored in a database, helping to establish tables and relationships between tables. Eliminates redundancies and inconsistent dependencies.*

### Forms

- 1NF
    1. Primary key
    2. No duplicate rows
    3. No attributes which contain more than one item of information
- 2NF
    1. Data already in 1NF
    2. No partial dependencies on a composite key
- 3NF
    3. No dependencies on non-key attributes

### Why?

- Cost - No data duplication- cheaper storage
- Speed - less data = faster processing
- Integrity - no data duplication
- Faster manipulation - update data once, and have it cascade to all related records

*Takes time and effort, generates more tables, relationships, and processing. In addition queries become more complex.*

## NoSQL Fundamentals

*There is not a single NoSQL view.*

### Key Differences

- Schema-less
- No relationships or ones that are handled very differently
- No need for normalization
- No Structured Query Language
- DB model to fit your needs - not one size fits all
- Consistency Model - ACID vs BASE
    - Atomic, Consistent, Isolated, Durable
    - Basic Availability, Soft-state, Eventual consistency
- Horizontal Scalability

## Types

### Key Value

- Store data as key and value pairs
- The key is unique 
- The value contains the data
- the value is generally schema-less
- Value can contain attributes
- Generally the value is opaque to the DB, it cannot be examined
- Some Key Value DB's are limit to JUST key values, others can group key values pairs into perceived tables

### Document DB

- Document is the aggregate - scaling is based on documents
- Able to search and interact with the structure
- Able to reference other documents

### Column Family

*Used when huge columns of data need to be stored for aggregate based operations.* 

#### Row Advantages/Disadvantages 

- Data grouped and stored around columns not rows
- Faster for iterative or single record processing
- better for smaller tables 
- Not suited where row subset analytics are required

#### Column Advantages/Disadvantages



- Faster, more efficent data access
- Improved compression
- Better parallel processing

### Graph Style DB

- Data and relationships matter
- A strong focus on relationships
- Relationships are fluid and persistent
- Many to many relationships are easy
- Models real life social relational types links without modeling changes
- Nodes
- Properties
- Relationships
- Labels