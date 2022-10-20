import json
import boto3
import time
import os

asg = boto3.client('autoscaling')


group_asg = ['asg_pyk0','asg_pyk1']


def lambda_handler(event, context):
    retasgs = asg.describe_auto_scaling_groups()
    print(retasgs)
    for retasg in (retasgs['AutoScalingGroups']):
        print(retasg['AutoScalingGroupName'])
        if retasg['AutoScalingGroupName'] in group_asg:
            suspendasg = asg.resume_processes(AutoScalingGroupName=retasg['AutoScalingGroupName'],ScalingProcesses=['Terminate','HealthCheck'])
