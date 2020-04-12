import { DynamoDB } from "aws-sdk";
import faker from "faker/locale/en";

const dynamodb = new DynamoDB({
    region: process.env.REGION || "us-west-2"
});