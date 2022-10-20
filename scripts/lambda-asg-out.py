import json
import boto3
import time
import os


ec2 = boto3.client('ec2')
asg = boto3.client('autoscaling')

retasgs = asg.describe_auto_scaling_groups()
print(retasgs)
for retasg in (retasgs['AutoScalingGroups']):
    print(retasg['AutoScalingGroupName'])
    suspendasg = asg.suspend_processes(AutoScalingGroupName=retasg['AutoScalingGroupName'],ScalingProcesses=['Terminate'])
    #suspendasg = asg.resume_processes(AutoScalingGroupName=retasg['AutoScalingGroupName'],ScalingProcesses=['Terminate'])

retasginss = asg.describe_auto_scaling_instances()
print(retasginss)
for retasgins in (retasginss['AutoScalingInstances']):
    print(retasgins['InstanceId'])
    stopinstance = ec2.stop_instances(InstanceIds=[retasgins['InstanceId']])
    print(stopinstance)

response = ec2.describe_instances()
#print(response)


def lambda_handler(event, context):
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
