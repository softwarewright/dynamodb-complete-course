provider "aws" {
    version = "~> 2.0"
    region = "us-west-2"
}

resource "aws_dynamodb_table" "table" {
    name = "WeatherStationData"
    billing_mode = "PROVISIONED"
    read_capacity = 1
    write_capacity = 1
    # primary key
    hash_key = "StationId"
    # sort key
    range_key = "DateAndTime"

    attribute {
        name = "StationId"
        type = "S"
    }

    attribute {
        name = "DateAndTime"
        type = "S"
    }
}