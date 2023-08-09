POSTMORTEM; MY INCIDENT REPORT
MY INCIDENT SUMMARY

When things go wrong, as they sometimes will, it’s important to take a step back and evaluate why and how they did.

Multiple service failures due to low disk space. Which caused service failure for 10 mins.

Some services that write logs to that file system experience service degradation and failure rate surged.

This impacted users’ experience because several users who were attempting to make transactions via the mobile app and USSD channels experienced failures.


While the disk space monitoring showed red, it was not the first thing we noticed as it was not the first time we saw disk space utilization go up. We began investigating to see why other services were failing, only to realize that service couldn’t write to log. We then checked the log and saw that it had gone up to 99%, and this was the first time this was happening, meaning a certain process wrote excessively to log, and caused the disk to fill up.

We cleared the disk space and had services come back up.

TIMELINE

The issue was detected 12PM GMT+1
Monitoring alert and logs
Disk space was freed
We took a wrong step by not initially paying attention to disk space alert, and we never expected it to grow to 99%. However, the threshold for the alert is 75%.
This was handled by my team, the middleware team
The incident was resolved by freeing up disk space.

ROOT CAUSE AND RESOLUTION


Root cause analysis

What happened?
We realized after investigation that the services were failing because they could not write to logs. And they could not write to logs because the logs File system was filled up.

Why was the logs file system filled up?
Normally, this file system is not prone to getting filled, but is monitored. This is why attention was not given to it, but rather the services that were failing.

we found that a charge collection service went into debugging mode and caused it to write excessively to logs, causing disk size to spike.

Resolution

We identified the files that were causing the high disk space, and truncated the logs.

Created an issue for the development team to fix the program that caused log spike.

CORRECTIVE AND PREVENTIVE MEASURE


to prevent subsequent occurrences, attention has to be given to this file system and other critical file system

what to do to prevent this

More active monitoring
modified a cron job to regularly free space on the server.





