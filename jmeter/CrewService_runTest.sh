#!/bin/sh
X=1
XEND=1
while [ $X -le $XEND ]
do
 rm -f /beeno/CrewService.jmx_results.txt
 rm -rf /beeno/CrewService.jmx_jmeterResults
 cd /jmeter543/apache-jmeter-5.4.3/bin
 ./jmeter.sh -n -t /jmeter543/apache-jmeter-5.4.3/gitops/CrewService.jmx -l /beeno/CrewService.jmx_results.txt -e -o /beeno/CrewService.jmx_jmeterResults -j /jmeter543/apache-jmeter-5.4.3/gitops/jmeter.log
 sleep 5
 X=`expr $X + 1`
done
cd /jmeter543/apache-jmeter-5.4.3/gitops
