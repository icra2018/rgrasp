#!/usr/bin/env python

import rospy
import numpy as np
import roslib; roslib.load_manifest("robot_comm")
from robot_comm.srv import *
from visualization_msgs.msg import *
import ik.helper
from ik.ik import generatePlan, EvalPlan, executePlanForward
from std_msgs.msg import Float64

# def lights_on():
#     rospy.init_node('gelsight_helper')
#     rospy.wait_for_service('suction_service',timeout = 5)
#     suction_service=rospy.ServiceProxy('suction_service', SuctionData1)
#     resp1=suction_service("lon", "")
#
# def lights_off():
#     rospy.init_node('gelsight_helper')
#     rospy.wait_for_service('suction_service',timeout = 5)
#     suction_service=rospy.ServiceProxy('suction_service', SuctionData1)
#     resp1=suction_service("loff", "")

def calibrate_gelsight(isExecute=True, withPause=False):
    arc_ori = np.array([0,1,0,0])
    ori_1 = np.array([ -0.70710678118654757, 0.70710678118654757, 0, 0])
    ori_2 = np.array([ 0.70710678118654757, 0.70710678118654757, 0, 0])
    #initialize Parameters
    tip_hand_transform = [0,0,0, 0,0,0]
    #read initial robot poses
    q_initial = ik.helper.get_joints()
    #go to arc_1
    # goToHome.goToARC()
    plans_list = []
    pose_list = []
    #arc position (high)
    pose_list.append(np.array([1.0,0.,0.792, 0,1,0,0]))
    pose_list.append(np.array([.642, .73187, .95168, .69811, .70630, -0.0803, .08568]))
    pose_list.append(np.array([.642, .73187, .748, .69811, .70630, -0.0803, .08568]))
    pose_list.append(np.array([.56577, .73187, .748, .69811, .70630, -0.0803, .08568]))
    pose_list.append(np.array([.48138, .73187, .748, .69811, .70630, -0.0803, .08568]))
    pose_list.append(np.array([.48138, .73187, .95168, .69811, .70630, -0.0803, .08568]))
    pose_list.append(np.array([1.0,0.,0.792, 0,1,0,0]))
    speed_list = ['superSaiyan', 'superSaiyan', 'slow', 'slow', 'slow', 'slow', 'superSaiyan']
    #gripper hand_commands
    # is_gripper_list = [0,0,0,0,0,0,0]
    is_gripper_list = [0,0,1,1,1,0,0]
   #~1. Open gripper
    grasp_plan = EvalPlan('helper.moveGripper(%f, 200)' % 0.11)
    plans_list.append(grasp_plan)

    #2. generate robot motions
    for i in range(len(pose_list)):
        plan, qf, plan_possible = generatePlan(q_initial, pose_list[i][0:3], pose_list[i][3:7], tip_hand_transform, speed_list[i], plan_name = str(i))
        if plan_possible:
            plans_list.append(plan)
            q_initial = qf
        else:
            print ('[Release Safe] Plans failed:')
        if is_gripper_list[i]:
            #sleep
            sleep_plan=EvalPlan('rospy.sleep(1.0)')
            plans_list.append(sleep_plan)
            #close gripper
            grasp_plan = EvalPlan('helper.graspinGripper(%f,%f)'%(800,30))
            plans_list.append(grasp_plan)
            #sleep
            sleep_plan=EvalPlan('rospy.sleep(1.5)')
            plans_list.append(sleep_plan)
            #capture image

            gelsight_plan = EvalPlan('helper.capture_gelsight()')
            plans_list.append(gelsight_plan)
            #sleep
            sleep_plan=EvalPlan('rospy.sleep(.5)')
            plans_list.append(sleep_plan)
            #open gripper
            grasp_plan = EvalPlan('helper.moveGripper(%f, 200)' % 0.11)
            plans_list.append(grasp_plan)
            #sleep
            sleep_plan=EvalPlan('rospy.sleep(2.)')
            plans_list.append(sleep_plan)

    #execute plan_name
    if isExecute and plan_possible:
        executePlanForward(plans_list, withPause)

if __name__=="__main__":
    rospy.init_node('gelsight_calibration', anonymous=True)
    rospy.sleep(0.1)
    calibrate_gelsight()
