The script will do the below:
-	It will get the time from the user
-	It will detect where is the temp drive of the machine and where it is mounted.
-	It will collect different information of performance cpu, memory , iostat for every second (a sleep of 1 second is added between iterations)
-	It will save it to a file under the temp drive mount point, the file name will be perf_logs
-	Once it is done, it will print a message of completion and exit.

To run the script you run the below command:
-	Upload the script to the server
-	Give it execution script: chmod +x collect_perf_timed.sh
-	Run the script and provide the time in seconds for example:
./collect_perf_timed.sh 60 # here is 60 seconds

Prerequisite to run the script:
-	Have iotop installed on the system
-	The machine should have an azure temp drive (the support for sizes that does not have temp drive will be added soon)
