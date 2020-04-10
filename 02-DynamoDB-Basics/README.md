# DynamoDB Basics

## Intro

### Pitch

- Fully managed, NoSQL Database service
- Predictable, fully managed performance with seamless scalability
- No visible servers
- No practical storage limitations
- Full resilient and highly available
- Performance scales consistent, logical and linear way 
- Full and deep integration with AWS IAM - rich security model
- Shares characteristics with Key,Value and Document Store DB's

### General Information

- DynamoDB is a collection of Tables
- Tables are the highest level structure within a database
- Performance is managed at a table level
- DynamoDB uses the performance directive and the data model to manage underlying resource provisioning 
- The schema is not fixed at table level


DynamoDB Tables consist of Items, Items consist of one or more attributes.

First you have a partition key (hash key) unique key, has to be present and has to be unique.

Sort Key - orders items in the database and groups them. Where time series data needs to be stored. Subsets of data.

Attributes are defined with a specific type
    - Scalar - single value entity
        - String
        - Number
        - binary
        - boolean
    - set - unordered set of data
        - string sets
        - number sets
        - binary sets
    - Document
        - List - ordered set of items
        - Map - unordered set of data
