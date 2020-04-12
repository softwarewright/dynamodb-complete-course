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

## DynamoDB Consistency Model

*DynamoDB sacrifice consistency for performance.*

- SSD Storage
- Consistent, reliable low latency reads and writes
- Every data block is stored three times

- Data write requested 
- OK (200) received if two of the three writes are successful
- Background Full Sync occurs (Usually occurs in less than a second)
- This means that DynamoDB is eventually consistent


- You can issues strongly consistent reads to always get new data
    - It costs more

## DynamoDB Basic Table Creation

- Table name - 3 - 255 characters
- Primary Key (Partition Key) - Only Scalar Data Types are allows for the partition key
- Sort Key - allows selection of items to selected by value and sorts by that value. Adding the sort key turns the primary key into a composite key.


### Local Secondary Indexes

- You can only create secondary indexes at table creation, recreating them later requires table recreation
- These allow you to create an alterative view of the table, essentially a secondary sort key

### Global Secondary Index

Allows you to create a completely separate partition key and sort key

### Provisioned Capacity

Performance is controlled at a table level, and changes to provisioned capacity should be made with care.

## Interacting with DynamoDB Table

``` bash
aws dynamodb list-tables

aws dynamodb describe-table --table-name WeatherStationData

aws dynamodb create-table --table-name TestTable --attribute-definitions AttributeName=TestId,AttributeType=S AttributeName=DateAndTime,At 
tributeType=S --key-schema AttributeName=TestId,KeyType=HASH Attribute 
Name=DateAndTime,KeyType=RANGE --provisioned-throughput ReadCapacityUn 
its=1,WriteCapacityUnits=1

aws dynamodb wait table-exists --table TestTable
```



## Controlling Table Performance

- Defined PER TABLE
- Separate READ and WRITE Controls
- Changeable at ANY TIME - ASYNC operation
- Be deliberate and cautions when changing
- Anything over than 3000 RCU or 1000 WCU need **special consideration**
- Limit use to long term requirements
- Four Decreases per table per calendar day

### Terms

- Read Capacity Units - RCU - up to 4 kb of data
- Write Capacity Unit - WCU - up to 1 KB data
- Both are allocated on a per second basis
- Smaller operations are always rounded to 1KB or 4 KB minimum
- For larger operations, round up to next highest boundary
- 3 KB Read = 3KB / 4KB = 0.75 = 1 RCU
- 1.5 KB Write = 1.5KB / 1KB = 1.5 = 2 WCU
- Eventually consistent reads use half of the above RCU
- Min RCU or WCU on a table is "1"

### Controlling Capacity

- Capacity Tab
- Cli - Update Table
- IAC - Terraform/CloudFormation
- API - UpdateTable

### Update, Put, Delete

``` bash
aws dynamodb put-item --table-name WeatherStationData --item '{ "StationId": { "S": "00000
3" }, "DateAndTime": { "S": "2012/5/1 00:00:02"  }, "Temperature": { "S": "100"} }'

aws dynamodb update-item --table-name WeatherStationData --key '{ "StationId": { "S": "000 
003" }, "DateAndTime": { "S": "2012/5/1 00:00:02"  } }' --update-expression "SET windspeed=:
windspeed" --expression-attribute-values '{ ":windspeed": { "N": "100" }}'

aws dynamodb delete-item --table-name WeatherStationData --key '{ "StationId": { "S": "000
003" }, "DateAndTime": { "S": "2012/5/1 00:00:02"  } }'
```

## Retrieve Items

### Get Item

- Input P-Key and S-Key if applicable for an item
- Returns all or set of attributes for a match
- Otherwise returns nothing
- By default returns eventually consistent data
- --consistent-read (for consistent read)
- Cant be used against an index, local or global

``` bash
aws dynamodb get-item --table-name WeatherStationData --key '{ "StationId": { "S": "000003 
" }, "DateAndTime": { "S": "2012/5/1 00:00:02" } }' --return-consumed-capacity TOTAL
```

### Query

- Input a P-Key value OR
- A P-Key value AND a S-Key value, or range of values
- Returns all or a set of attributes for a match
- Otherwise it returns a results block with no items
- By default returns eventually consistent data
- --consistent-read
- Can filter on NON key values
- Any discarded values are still charged for capacity wise
- Can query indexes - local and global

``` bash
aws dynamodb query --table-name WeatherStationData --key-condition-expression "StationId=:
id" --expression-attribute-values '{ ":id": {"S": "2" } }' --return-consumed-capacity TOTAL

aws dynamodb query --table-name WeatherStationData --key-condition-expression "StationId=:
id AND DateAndTime=:datetime" --expression-attribute-values '{ ":id": {"S": "2" }, ":datetim 
e": { "S": "2012/5/1 00:00:06" } }' --return-consumed-capacity TOTAL 

aws dynamodb query --table-name WeatherStationData --key-condition-expression "StationId=:
id AND DateAndTime Between :startime AND :endTime" --expression-attribute-values '{ ":id": {"S": "2" }, ":startTime": { "S": "2012/5/1 00:00:00" }, ":endTime": { "S": "2012/5/1 00:00:06"} }' --return-consumed-capacity TOTAL

aws dynamodb query --table-name WeatherStationData --key-condition-expression "StationId=:
id" --filter-expression "Temperature>:temp" --expression-attribute-values '{ ":id": {"S": "2 
" }, ":temp": { "N": "20" } }' --return-consumed-capacity TOTAL
```

### Scan

- Input Table
- Output by default is ALL Items & attributes in the table
- Filtering is possible - but all data is read
- By default returns eventually consistent data
- --consistent-read
- Scans can be done in parallel to improve performance
- Returned results can be limited

*Try to avoid this command - only when you need to search on NON key / indexed attributes.*

``` bash
aws dynamodb scan --table-name WeatherStationData
```


## Partitions

- Underlying storage and processing nodes of DynamoDB
- Initially one table equals one partition
- You cannot see them directly
- You don't control the number of partition directly
- A partition can deliver 3000 RCU or 1000 WCU
- There is a relationship between performance required, data stored, and number of partitions
- When you store more than 10GB or 3000 RCU or 1000 WCU a new partition is added and the data is spread between them over time.

### Partition Split

Take the case where you have 500MB size table, but you require 4000 RCU and 500 WCU. Due to the RCU being over 3000 you now will have two partitions that will be created and the capacity will be split between the two.

Therefore partition 1 will receive 2000 RCU and 250 WCU, and partition 2 will receive the same.




## Batch

### BatchGetItem

- 1 or max 100 items from 1 or more tables, max 16MB
- Providing the whole key
- "ValidationException" occurs if you ask for more than 100 items
- "ProvisionedThroughputExceededException" if all ITEMS fail
- More than 16MB of data will return part and unprocessed keys
- ITEMS are atomic, the batch is not
- ITEMS retrieved in parallel - but also unordered
- Non-existent items consume 1 or .5 RCU minimum
- AttributeToGet -allows filtering of results - (You are still billed)
- Generally used in a loop

### BatchWriteItem

#### PutItem Short Comings

- PutItem - Single Item add - v.inefficient
- Each request is 1KB minimum
- Each request has a transaction time

#### BatchWriteIem Benefits

- Up to 25 items, 400KB Item Limit, 16 MB total request limit
- Each item is written separately - still have per-item waste
- Each item is atomic - all of it works or doesn't
- BatchWriteItem ISN'T ATMOIC - it can be partially successful
- Any unprocessed items are returned
- If ALL items fail - then the operation fails
- BatchWriteItem used in loops, with exponential backoff (This is provided in some SDKs)

- 1 or MORE tables
- BatchWriteItem - PUT and DELETE
- Parallel - lower latency/better performance
- Even if parallel - individual WCU's consumed
- DELETES cost 1WCU - even if the item doesn't exist
- 1 Operation type per item - more and entire operation fails
- If KEY attributes don't match - entire operation fails
- > 25 items - entire operation fails


## Tips

- The Put Item API call is Idempotent, meaning that if you call the command multiple times the result will be the same. If the item does not exist it will ensure that the state is there afterward.
- PUT, UPDATE, and DELETE all consume write capacity whether or not the operation performs any changes.
- ScannedCount - items scanned
- Count - items returned

## Resources

- [DynamoDB SLA](https://aws.amazon.com/dynamodb/sla/)
- [Auto Scaling](https://aws.amazon.com/blogs/aws/new-auto-scaling-for-amazon-dynamodb/)

