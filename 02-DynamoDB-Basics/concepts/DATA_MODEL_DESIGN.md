# Data Model Design

- What data groups exist in the system, how large are they?
- When will the data be accessed? Linear over day? Spikes?
- What access patterns will data have? What happens when a user signs up?
- How will the data grow over time?
- Will all data in the time series have equal access? Historical access.
- What operations will run against the data?
- Are different perspectives of data needed?
- What are batch processing needs?
- Does the system have any real time needs?



Tag tables with a common starting name to be able to understand which tables belong to a specific project.


## Tips

- With DynamoDB there is no penalty for creating multiple smaller tables. In fact being able to handle performance per table can be very advantageous.
- Create date fields as numbers and the value is the number of seconds since epoch time.
- You cannot change the data type of an attribute in place, you have to remove the attribute and readd it.